<script>
import AnimalCard from './AnimalCard.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'

export default {
  name: 'AnimalGrid',
  components: {
    AnimalCard,
    LoadingSpinner,
  },
  props: {
    animals: { type: Array, default: () => [] },
    loading: { type: Boolean, default: false },
    loadingText: { type: String, default: 'Állatok betöltése...' },
    emptyText: { type: String, default: 'Nincs megjeleníthető állat.' },
    colClass: { type: String, default: 'col-sm-6 col-lg-4 col-xl-3' },
  },
}
</script>

<template>
  <div>
    <!-- Loading állapot -->
    <LoadingSpinner v-if="loading" :text="loadingText" />

    <!-- Üres állapot -->
    <div v-else-if="animals.length === 0" class="text-center py-5">
      <div class="display-1 mb-3">🔍</div>
      <h5 class="text-muted">{{ emptyText }}</h5>
      <slot name="empty-action" />
    </div>

    <!-- Grid -->
    <div v-else class="row g-4">
      <div
          v-for="animal in animals"
          :key="animal.id"
          :class="colClass"
      >
        <AnimalCard :animal="animal" />
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>