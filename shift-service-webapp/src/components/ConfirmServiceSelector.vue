<template>
  <div>
    <!-- Dropdown para seleccionar el servicio -->
    <div class="dropdown">
      <select v-model="selectedServiceId" @change="fetchContracts">
        <option v-for="service in services" :key="service.id" :value="service.id">
          {{ service.name }}
        </option>
      </select>
    </div>

    <!-- Botón de editar confirmaciones -->
    <div class="buttons">
      <button @click="editConfirmation">Edit Confirmations</button>
      <button v-if="editMode" @click="cancelEdit">Cancel Edit</button>
    </div>

    <!-- Componente de totalización de horas -->
    <ConfirmTotalHoursTable :shifts="currentContractShifts" :engineers="filteredEngineers" />

    <!-- Mostrar la tabla de turnos o el mensaje según corresponda -->
    <div v-if="currentContractShifts.length > 0">
      <h2>Shifts for the Contract</h2>
      <table class="shifts-table">
        <thead>
          <tr>
            <th>Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Confirmed Engineers</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="shift in currentContractShifts" :key="shift.id">
            <!-- Aplicar estilo solo a la columna Date -->
            <td :style="getDateCellStyle(shift)">{{ shift.date }}</td>
            <td>{{ shift.start_hour }}</td>
            <td>{{ shift.end_hour }}</td>
            <td>
              <!-- Mostrar mensaje si no hay ingenieros confirmados al turno y no está en modo de edición -->
              <div v-if="!editMode">
                <div v-if="!hasConfirmedEngineers(shift)">
                  <p>⚠️ No engineers confirmed.</p>
                </div>
                <!-- Mostrar ingenieros asignados -->
                <div v-else>
                  <div class="engineer-container">
                    <span v-for="engineer in filteredEngineersForShift(shift)" :key="engineer.id">
                      <span :style="{ backgroundColor: getColorForEngineer(engineer.name) }"
                            class="engineer-button">
                        {{ engineer.name }}
                      </span>
                    </span>
                  </div>
                </div>
              </div>
              <!-- Mostrar checkboxes solo en modo de edición -->
              <div v-if="editMode">
                <div class="engineer-container">
                  <label v-for="engineer in filteredEngineersForShift(shift)" :key="engineer.id" class="engineer-checkbox">
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
import ConfirmTotalHoursTable from './ConfirmTotalHoursTable.vue';

export default {
  components: {
    ConfirmTotalHoursTable
  },
  data() {
    return {
      services: [], // Lista de servicios
      contracts: [], // Lista de contratos
      engineers: [], // Lista de ingenieros
      selectedServiceId: null, // ID del servicio seleccionado
      selectedContractId: null, // ID del contrato seleccionado
      currentContractShifts: [], // Turnos para el contrato seleccionado
      allEngineers: [], // Todos los ingenieros disponibles
      editMode: false, // Variable para controlar el modo de edición
    };
  },
  computed: {
    filteredEngineers() {
      // Filtra los ingenieros para incluir solo los que están asignados a algún turno
      const assignedEngineerIds = this.currentContractShifts.flatMap(shift => 
        shift.engineer_shifts.map(eShift => eShift.engineer_id)
      );
      return this.allEngineers.filter(engineer => assignedEngineerIds.includes(engineer.id));
    }
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
          this.selectedContractId = this.contracts[0]?.id; // Por defecto al primer contrato
          this.fetchShifts(this.selectedContractId); // Obtener turnos para el contrato seleccionado
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
          this.fetchEngineers(); // Obtener ingenieros cuando se cargan los turnos
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
    editConfirmation() {
      this.editMode = true; // Habilitar modo de edición
      this.fetchEngineers(); // Obtener ingenieros al hacer clic en "Edit Confirmations"
    },
    cancelEdit() {
      this.editMode = false; // Deshabilitar modo de edición
    },
    isEngineerAssigned(shift, engineerId) {
      const engineerShift = shift.engineer_shifts.find(eShift => eShift.engineer_id === engineerId);
      return engineerShift && engineerShift.status === 'confirmed';
    },
    hasConfirmedEngineers(shift) {
      // Verifica si hay algún ingeniero con el estado 'confirmed'
      return shift.engineer_shifts.some(eShift => eShift.status === 'confirmed');
    },
    getDateCellStyle(shift) {
      // Color de fondo para la columna de fecha basado en la asignación de ingenieros
      return this.hasConfirmedEngineers(shift) ? 'background-color: lightgreen;' : 'background-color: lightcoral;';
    },
    getColorForEngineer(name) {
      // Generar color basado en el nombre del ingeniero
      const hash = [...name].reduce((acc, char) => char.charCodeAt(0) + ((acc << 5) - acc), 0);
      const hue = hash % 360;
      return `hsl(${hue}, 70%, 70%)`;
    },
    toggleEngineer(shiftId, engineerId, event) {
      const shift = this.currentContractShifts.find(s => s.id === shiftId);
      if (!shift) return;

      const isChecked = event.target.checked;
      const existingEngineerShift = shift.engineer_shifts.find(e => e.engineer_id === engineerId);

      if (isChecked) {
        if (!shift.engineer_shifts.some(eShift => eShift.engineer_id === engineerId)) {
          shift.engineer_shifts.push({ engineer_id: engineerId, status: 'confirmed' });
        } else {
          existingEngineerShift.status = 'confirmed';
        }
      } else {
        if (existingEngineerShift) {
          existingEngineerShift.status = 'scheduled';
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
    },
    filteredEngineersForShift(shift) {
      // Filtra los ingenieros asignados al turno específico
      const assignedEngineerIds = shift.engineer_shifts.map(eShift => eShift.engineer_id);
      return this.filteredEngineers.filter(engineer => assignedEngineerIds.includes(engineer.id));
    }
  },
  created() {
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

.shifts-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.shifts-table th, .shifts-table td {
  border: 1px solid #ddd;
  padding: 8px;
}

.shifts-table th {
  background-color: #f4f4f4;
}

.engineer-container {
  display: flex;
  flex-wrap: wrap;
}

.engineer-button {
  display: inline-block;
  padding: 5px;
  margin: 2px;
  border-radius: 4px;
  color: #fff;
  font-weight: bold;
}

.engineer-checkbox {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
}

.engineer-checkbox input {
  margin-right: 5px;
}
</style>
