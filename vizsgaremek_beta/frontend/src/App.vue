<script >
import MenuLayout from "@/layouts/MenuLayout.vue";
import FooterLayout from "@/layouts/FooterLayout.vue";
export default {
  name: "App",
  components: {FooterLayout, MenuLayout}
}
</script>

<template>
  <div class="bg-light min-vh-100">
    <MenuLayout/>
    <main class="container">
      <RouterView/>
    </main>
    <FooterLayout/>
  </div>
</template>

<style scoped></style>
