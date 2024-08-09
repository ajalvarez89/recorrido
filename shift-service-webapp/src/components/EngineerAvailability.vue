<template>
  <div v-if="shift">
    <h3>Edit Availability for Shift: {{ formatShift(shift) }}</h3>
    <ul>
      <li v-for="engineer in engineers" :key="engineer.id">
        <label>
          <input type="checkbox" :value="engineer.id" v-model="selectedEngineers" />
          {{ engineer.name }}
        </label>
      </li>
    </ul>
    <button @click="saveAvailability">Save Availability</button>
  </div>
</template>

<script>
import axios from '../axios';

export default {
  props: ['shift'],
  data() {
    return {
      engineers: [],
      selectedEngineers: [],
    };
  },
  watch: {
    shift: 'fetchEngineers',
  },
  methods: {
    async fetchEngineers() {
      if (!this.shift) return;
      try {
        const response = await axios.get('/engineers');
        this.engineers = response.data;
        this.selectedEngineers = this.shift.engineers.map((e) => e.id);
      } catch (error) {
        console.error(error);
      }
    },
    async saveAvailability() {
      try {
        await axios.put(`/shifts/${this.shift.id}`, {
          engineer_ids: this.selectedEngineers,
        });
        alert('Availability updated!');
      } catch (error) {
        console.error(error);
      }
    },
    formatShift(shift) {
      return `${shift.date} - ${shift.start_hour}:00 to ${shift.end_hour}:00`;
    },
  },
};
</script>
