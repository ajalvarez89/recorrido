<template>
  <div id="main-view">
    <confirm-service-selector @service-selected="onServiceSelected" />
    <shift-list :serviceId="selectedService" @edit-availability="onEditAvailability" />
    <confirm-engineer-availability :shift="selectedShift" />
  </div>
</template>

<script>
import ConfirmServiceSelector from '../components/ConfirmServiceSelector.vue';
import ConfirmEngineerAvailability from '../components/ConfirmEngineerAvailability.vue';

export default {
  components: {
    ConfirmServiceSelector,
    ConfirmEngineerAvailability,
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
