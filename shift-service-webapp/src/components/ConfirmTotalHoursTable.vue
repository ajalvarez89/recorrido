<template>
  <div v-if="totalHours.length > 0">
    <h2>Total Hours by Engineer</h2>
    <table>
      <thead>
        <tr>
          <th>Engineer</th>
          <th>Total Hours</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="engineer in totalHours" :key="engineer.id" :style="{ backgroundColor: getColorForEngineer(engineer.name) }">
          <td>{{ engineer.name }}</td>
          <td>{{ engineer.hours }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  props: {
    shifts: Array,
    engineers: Array
  },
  computed: {
    totalHours() {
      const hoursByEngineer = {};

      this.shifts.forEach(shift => {
        shift.engineer_shifts.forEach(eShift => {
          if (eShift.status === 'confirmed' && !eShift._destroy) {
            if (!hoursByEngineer[eShift.engineer_id]) {
              hoursByEngineer[eShift.engineer_id] = 0;
            }
            hoursByEngineer[eShift.engineer_id] += 1;
          }
        });
      });

      return this.engineers.map(engineer => ({
        id: engineer.id,
        name: engineer.name,
        hours: hoursByEngineer[engineer.id] || 0
      })).filter(engineer => engineer.hours > 0);
    }
  },
  methods: {
    getColorForEngineer(name) {
      const hash = [...name].reduce((acc, char) => char.charCodeAt(0) + ((acc << 5) - acc), 0);
      const hue = hash % 360;
      return `hsl(${hue}, 70%, 80%)`;
    }
  }
};
</script>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
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
</style>
