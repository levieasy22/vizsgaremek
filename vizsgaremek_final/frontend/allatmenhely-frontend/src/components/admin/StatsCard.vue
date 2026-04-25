<script>
export default {
  name: 'StatsCard',
  props: {
    icon: { type: String, required: true },
    label: { type: String, required: true },
    value: { type: [Number, String], required: true },
    color: { type: String, default: '#2E7D32' },
  },
}
</script>

<template>
  <div class="card border-0 shadow-sm h-100">
    <div class="card-body d-flex align-items-center gap-3 p-4">

      <!-- Ikon -->
      <div
          class="rounded-3 p-3 flex-shrink-0"
          :style="{ backgroundColor: `${color}20` }"
      >
        <i :class="`bi ${icon} fs-3`" :style="{ color: color }"></i>
      </div>

      <!-- Szám és felirat -->
      <div>
        <div class="fs-2 fw-bold lh-1 mb-1">{{ value }}</div>
        <div class="text-muted small">{{ label }}</div>
      </div>

    </div>
  </div>
</template>

<style scoped>

</style>