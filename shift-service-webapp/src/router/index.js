import { createRouter, createWebHistory } from 'vue-router';
import MainView from '../views/MainView.vue';
import ManageConfirmedShifts from '../views/ManageConfirmedShifts.vue';

const routes = [
  {
    path: '/',
    name: 'MainView',
    component: MainView
  },
  {
    path: '/manage_confirmed_shifts',
    name: 'ManageConfirmedShifts',
    component: ManageConfirmedShifts
  }
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
});

export default router;
