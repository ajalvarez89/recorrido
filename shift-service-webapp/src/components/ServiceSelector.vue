<template>
  <div>
    <div class="dropdown">
      <select v-model="selectedServiceId" @change="fetchContracts">
        <option v-for="service in services" :key="service.id" :value="service.id">
          {{ service.name }}
        </option>
      </select>
    </div>

    <div class="buttons">
      <button @click="editAvailability">Edit Availability</button>

      <button v-if="editMode" @click="cancelEdit">Cancel Edit</button>
    </div>
    <TotalHoursTable :shifts="currentContractShifts" :engineers="allEngineers" />

    <div v-if="currentContractShifts.length > 0">
      <h2>Shifts for the Contract</h2>
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Assigned Engineers</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="shift in currentContractShifts" :key="shift.id" :class="{'highlight': !hasEngineersAssigned(shift)}">
            <td>{{ shift.date }}</td>
            <td>{{ shift.start_hour }}</td>
            <td>{{ shift.end_hour }}</td>
            <td>
              <div v-if="!editMode">
                <div class="engineer-container">
                  <span v-for="engineer in allEngineers" :key="engineer.id">
                    <span v-if="isEngineerAssigned(shift, engineer.id)" class="engineer-button">
                      {{ engineer.name }}
                    </span>
                  </span>
                </div>
              </div>
              <div v-if="editMode">
                <div class="engineer-container">
                  <label v-for="engineer in allEngineers" :key="engineer.id" class="engineer-checkbox">
                    <input
                      type="checkbox"
                      :value="engineer.id"
                      :checked="isEngineerAssigned(shift, engineer.id)"
                      @change="toggleEngineer(shift.id, engineer.id, $event)"
                    />
                    {{ engineer.name }}
                  </label>
                </div>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-else>
      <p>No shifts available.</p>
    </div>
  </div>
</template>

<script>
import TotalHoursTable from './TotalHoursTable.vue';

export default {
  components: {
    TotalHoursTable
  },
  data() {
    return {
      services: [],
      contracts: [],
      engineers: [],
      selectedServiceId: null,
      selectedContractId: null,
      currentContractShifts: [],
      allEngineers: [],
      editMode: false,
    };
  },
  methods: {
    fetchServices() {
      fetch('http://localhost:3000/v1/services')
        .then(response => response.json())
        .then(data => {
          this.services = data;
        })
        .catch(error => {
          console.error('Error fetching services:', error);
        });
    },
    fetchContracts() {
      if (!this.selectedServiceId) return;

      fetch(`http://localhost:3000/v1/contracts?by_service=${this.selectedServiceId}`)
        .then(response => response.json())
        .then(data => {
          this.contracts = data;
          this.selectedContractId = this.contracts[0]?.id;
          this.fetchShifts(this.selectedContractId);
        })
        .catch(error => {
          console.error('Error fetching contracts:', error);
        });
    },
    fetchShifts(contractId) {
      if (!contractId) return;

      fetch(`http://localhost:3000/v1/shifts?by_contract=${contractId}`)
        .then(response => response.json())
        .then(data => {
          this.currentContractShifts = data;
          this.fetchEngineers();
        })
        .catch(error => {
          console.error('Error fetching shifts:', error);
        });
    },
    fetchEngineers() {
      fetch('http://localhost:3000/v1/engineers')
        .then(response => response.json())
        .then(data => {
          this.allEngineers = data;
        })
        .catch(error => {
          console.error('Error fetching engineers:', error);
        });
    },
    editAvailability() {
      this.editMode = true;
      this.fetchEngineers();
    },
    cancelEdit() {
      this.editMode = false;
    },
    isEngineerAssigned(shift, engineerId) {
      return shift.engineer_shifts.some(eShift => eShift.engineer_id === engineerId && !eShift._destroy);
    },
    hasEngineersAssigned(shift) {
      return shift.engineer_shifts.some(eShift => !eShift._destroy);
    },
    toggleEngineer(shiftId, engineerId, event) {
      const shift = this.currentContractShifts.find(s => s.id === shiftId);
      if (!shift) return;

      const isChecked = event.target.checked;
      const existingEngineerShift = shift.engineer_shifts.find(e => e.engineer_id === engineerId);

      if (isChecked) {
        if (!shift.engineer_shifts.some(eShift => eShift.engineer_id === engineerId)) {
          shift.engineer_shifts.push({ engineer_id: engineerId, _destroy: false });
        }
      } else {
        if (existingEngineerShift) {
          existingEngineerShift._destroy = true;
        }
      }
      this.updateShift(shift.id);
    },
    updateShift(shiftId) {
      const shift = this.currentContractShifts.find(s => s.id === shiftId);
      if (!shift) return;

      fetch(`http://localhost:3000/v1/shifts/${shift.id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          engineer_shifts_attributes: shift.engineer_shifts
        }),
      })
      .then(() => {
        this.fetchShifts(this.selectedContractId);
      })
      .catch(error => {
        console.error('Error updating shift:', error);
      });
    }
  },
  mounted() {
    this.fetchServices();
  }
};
</script>

<style scoped>
.dropdown select {
  margin-bottom: 10px;
  padding: 5px;
}

.buttons button {
  margin-right: 10px;
  padding: 5px 10px;
}

table {
  width: 100%;
  border-collapse: collapse;
}

table, th, td {
  border: 1px solid #ddd;
}

th, td {
  padding: 8px;
  text-align: left;
}

th {
  background-color: #f4f4f4;
}

.highlight {
  background-color: #f8d7da;
}

.engineer-container {
  display: flex;
  flex-wrap: wrap;
}

.engineer-button {
  background-color: #007bff;
  color: white;
  padding: 5px 10px;
  border-radius: 4px;
  margin: 2px;
}

.engineer-checkbox {
  margin-right: 10px;
}
</style>
