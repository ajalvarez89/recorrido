<template>
  <div v-if="shift">
    <h3>Edit Availability for Shift: {{ formatShift(shift) }}</h3>
    <ul>
      <li v-for="engineer in engineers" :key="engineer.id" :style="{ backgroundColor: getBackgroundColor(engineer.name) }">
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
    getBackgroundColor(name) {
      const hash = Array.from(name).reduce((hash, char) => {
        return (hash << 5) - hash + char.charCodeAt(0);
      }, 0);
      const color = `#${((hash >> 24) & 0xFF).toString(16).padStart(2, '0')}${((hash >> 16) & 0xFF).toString(16).padStart(2, '0')}${((hash >> 8) & 0xFF).toString(16).padStart(2, '0')}`;
      return color;
    },
  },
};
</script>

<style scoped>
</style>
