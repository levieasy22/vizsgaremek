<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import AppNavbar from '@/components/layout/AppNavbar.vue'
import AppFooter from '@/components/layout/AppFooter.vue'

const route = useRoute()

// Ha az útvonal /admin-nal kezdődik, az admin layout fut
const isAdminRoute = computed(() => route.path.startsWith('/admin'))
</script>

<template>
  <div>
    <!--
      Admin oldalon (/admin/...) NEM jelenik meg a navbar és footer,
      mert az AdminLayout.vue-nak saját váza van oldalsávval.
      Minden más oldalon megjelenik a navbar és footer.
    -->
    <template v-if="!isAdminRoute">
      <AppNavbar />
      <main>
        <RouterView />
      </main>
      <AppFooter />
    </template>
    <template v-else>
      <RouterView />
    </template>

  </div>
</template>

<style scoped>

</style>