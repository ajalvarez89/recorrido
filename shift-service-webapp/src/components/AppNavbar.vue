<template>
  <nav>
    <ul>
      <li>
        <router-link to="/">Home</router-link>
      </li>
      <li>
        <router-link to="/manage_confirmed_shifts">Manage Confirmed Shifts</router-link>
      </li>
    </ul>
  </nav>
</template>

<script>
export default {
  name: 'AppNavbar',
};
</script>

<style scoped>
nav {
  background-color: #333;
  padding: 10px;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1000;
}

ul {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  justify-content: center;
}

li {
  margin: 0 15px;
}

a {
  color: #fff;
  text-decoration: none;
  padding: 5px 10px;
}

a.router-link-active {
  font-weight: bold;
}
</style>
