<script setup>
defineProps({
  text:      { type: String, default: '' },
  size:      { type: String, default: '3rem' },
  minHeight: { type: String, default: '200px' },
})
</script>

<template>
  <div class="d-flex justify-content-center align-items-center" :style="{ minHeight: minHeight }">
    <div class="text-center">
      <div
          class="spinner-border"
          :style="{ width: size, height: size, color: 'var(--menhely-primary, #2E7D32)' }"
          role="status"
      >
        <span class="visually-hidden">Betöltés...</span>
      </div>
      <p v-if="text" class="mt-3 text-muted small">{{ text }}</p>
    </div>
  </div>
</template>

<style scoped>

</style>