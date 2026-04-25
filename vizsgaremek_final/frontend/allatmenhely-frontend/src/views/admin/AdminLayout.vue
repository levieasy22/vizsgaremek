<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import AdminSidebar from '@/components/layout/AdminSidebar.vue'

const sidebarOpen = ref(false)
const windowWidth = ref(window.innerWidth)

const isMobile = computed(() => windowWidth.value < 992)

function handleResize() {
  windowWidth.value = window.innerWidth
  if (windowWidth.value >= 992) {
    sidebarOpen.value = false
  }
}

onMounted(() => {
  window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
  document.body.classList.remove('modal-open')
  document.body.style.removeProperty('overflow')
  document.body.style.removeProperty('padding-right')
  document.querySelectorAll('.modal-backdrop').forEach(el => el.remove())
})
</script>

<template>
  <div class="d-flex" style="min-height: 100vh;">

    <!-- Mobil fejléc – csak kis képernyőn látszik -->
    <div class="d-lg-none w-100 d-flex align-items-center justify-content-between px-3 py-2 text-white"
         style="background-color: #1a1a2e; position: fixed; top: 0; left: 0; right: 0; z-index: 1040; height: 56px;">
      <span class="fw-bold">🐾 Admin Panel</span>
      <button class="btn btn-outline-light btn-sm" @click="sidebarOpen = !sidebarOpen">
        <i :class="sidebarOpen ? 'bi bi-x-lg' : 'bi bi-list'"></i>
      </button>
    </div>

    <!-- Sidebar overlay – mobilon ha nyitva van -->
    <div
        v-if="sidebarOpen"
        class="d-lg-none position-fixed top-0 start-0 w-100 h-100"
        style="background: rgba(0,0,0,0.5); z-index: 1041;"
        @click="sidebarOpen = false"
    ></div>

    <!-- Sidebar -->
    <div
        :class="[
    'd-lg-block',
    sidebarOpen ? 'd-block' : 'd-none'
  ]"
        :style="isMobile ? {
    position: 'fixed',
    top: '0',
    left: '0',
    height: '100vh',
    overflowY: 'auto',
    zIndex: '1042'
  } : {
    position: 'sticky',
    top: '0',
    height: '100vh',
    overflowY: 'auto',
    flexShrink: '0'
  }"
    >
      <AdminSidebar @close="sidebarOpen = false" />
    </div>

    <!-- Fő tartalom -->
    <main
        class="flex-grow-1 bg-light"
        style="overflow-y: auto; min-height: 100vh;"
        :style="{ paddingTop: isMobile ? '56px' : '0' }"
    >
      <div class="p-4">
        <RouterView />
      </div>
    </main>

  </div>
</template>

<style scoped>

</style>