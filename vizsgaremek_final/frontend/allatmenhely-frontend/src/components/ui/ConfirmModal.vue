<script setup>
defineProps({
  modalId:        { type: String,  required: true },
  title:          { type: String,  default: 'Megerősítés szükséges' },
  message:        { type: String,  default: 'Biztosan folytatni szeretnéd?' },
  confirmText:    { type: String,  default: 'Igen, törlöm' },
  confirmVariant: { type: String,  default: 'danger' },
  loading:        { type: Boolean, default: false },
})

defineEmits(['confirm'])
</script>

<template>
  <div
      class="modal fade"
      :id="modalId"
      tabindex="-1"
      aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content border-0 shadow">

        <div class="modal-header border-0 pb-0">
          <h5 class="modal-title d-flex align-items-center gap-2">
            <i class="bi bi-exclamation-triangle-fill text-warning fs-4"></i>
            {{ title }}
          </h5>
          <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
          ></button>
        </div>

        <div class="modal-body py-3">
          <p class="mb-0 text-muted">{{ message }}</p>
        </div>

        <div class="modal-footer border-0 pt-0">
          <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
          >
            Mégse
          </button>
          <button
              type="button"
              :class="`btn btn-${confirmVariant} fw-bold`"
              @click="$emit('confirm')"
              :disabled="loading"
          >
            <span
                v-if="loading"
                class="spinner-border spinner-border-sm me-1"
            ></span>
            {{ confirmText }}
          </button>
        </div>

      </div>
    </div>
  </div>
</template>

<style scoped>

</style>