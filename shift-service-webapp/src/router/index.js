import { createRouter, createWebHistory } from 'vue-router';
import HomePage from '../views/HomePage.vue';
// import EngineerList from '../views/EngineerList.vue';
// import EngineerCreate from '../views/EngineerCreate.vue';

const routes = [
  { path: '/test', name: 'HomePage', component: HomePage },
  // { path: '/engineers', name: 'EngineerList', component: EngineerList },
  // { path: '/engineers/new', name: 'EngineerCreate', component: EngineerCreate },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
