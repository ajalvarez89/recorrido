<template>
  <div id="main-view">
    <service-selector @service-selected="onServiceSelected" />
    <shift-list :serviceId="selectedService" @edit-availability="onEditAvailability" />
    <engineer-availability :shift="selectedShift" />
  </div>
</template>

<script>
import ServiceSelector from '../components/ServiceSelector.vue';
import EngineerAvailability from '../components/EngineerAvailability.vue';

export default {
  components: {
    ServiceSelector,
    EngineerAvailability,
  },
  data() {
    return {
      selectedService: null,
      selectedShift: null,
    };
  },
  methods: {
    onServiceSelected(serviceId) {
      this.selectedService = serviceId;
      this.selectedShift = null;
      if (this.selectedService) {
        this.$router.push({ name: 'ManageConfirmedShifts' });
      }
    },
    onEditAvailability(shift) {
      this.selectedShift = shift;
    },
  },
};
</script>

<style>
#main-view {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
  margin-top: 60px;
}
</style>
