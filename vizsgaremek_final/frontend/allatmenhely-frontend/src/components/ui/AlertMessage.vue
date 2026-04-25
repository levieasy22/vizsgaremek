<script setup>
import { computed } from 'vue'

const props = defineProps({
  message:     { type: String,  default: '' },
  type:        { type: String,  default: 'danger' },
  dismissible: { type: Boolean, default: true },
})

defineEmits(['dismiss'])

const iconClass = computed(() => ({
  success: 'bi-check-circle-fill',
  danger:  'bi-exclamation-triangle-fill',
  warning: 'bi-exclamation-circle-fill',
  info:    'bi-info-circle-fill',
}[props.type] || 'bi-info-circle-fill'))
</script>

<template>
  <Transition name="fade">
    <div
        v-if="message"
        :class="`alert alert-${type} alert-dismissible d-flex align-items-start gap-2 mb-3`"
        role="alert"
    >
      <i :class="`bi ${iconClass} fs-5 flex-shrink-0 mt-1`"></i>
      <div class="flex-grow-1">{{ message }}</div>
      <button
          v-if="dismissible"
          type="button"
          class="btn-close flex-shrink-0"
          @click="$emit('dismiss')"
          aria-label="Bezárás"
      ></button>
    </div>
  </Transition>
</template>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>