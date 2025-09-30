<script setup lang="ts">
import { RouterView } from 'vue-router'
</script>

<template>
  <div id="app">
    <RouterView />
  </div>
</template>

<style>
/* Estilos globales para forzar tema claro */
* {
  box-sizing: border-box;
}

html,
body {
  margin: 0;
  padding: 0;
  background-color: #f5f5f5 !important;
  color: #333 !important;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

#app {
  width: 100%;
  min-height: 100vh;
  margin: 0;
  padding: 0;
  background-color: #f5f5f5 !important;
  color: #333 !important;
  box-sizing: border-box;
}

/* Forzar colores claros en todos los elementos */
div,
section,
header,
h1,
h2,
h3,
p,
span {
  color: #333 !important;
}
</style>
