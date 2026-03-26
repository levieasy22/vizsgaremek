<script >
import MenuLayout from "@/layouts/MenuLayout.vue";
export default {
  name: "App",
  components: {MenuLayout}
}
</script>

<template>
  <div class="bg-light min-vh-100">
    <MenuLayout/>
    <main class="container">
      <RouterView/>
    </main>
  </div>
</template>

<style scoped></style>
