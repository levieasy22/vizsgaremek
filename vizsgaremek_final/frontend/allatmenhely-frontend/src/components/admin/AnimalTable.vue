<script>
import defaultDogImg from '@/assets/images/dog2d.jpg'
import defaultCatImg from '@/assets/images/cat2d.jpg'
export default {
  name: 'AnimalTable',
  props: {
    animals: { type: Array, default: () => [] },
  },
  emits: ['edit', 'delete'],
  data() {
    return {
      storageUrl: import.meta.env.VITE_STORAGE_URL || 'http://localhost:8000/storage',
      statusLabels: {
        elerheto: 'Elérhető',
        foglalas_alatt: 'Foglalás alatt',
        orokbefogadva: 'Örökbefogadva',
      },
      defaultDogImg,
      defaultCatImg,
    }
  },
  methods: {
    getImageUrl(animal) {
      if (animal.primary_image_url) return animal.primary_image_url
      if (animal.primaryImage?.image_path) return `${this.storageUrl}/${animal.primaryImage.image_path}`
      // Alapértelmezett kép ha nincs feltöltött kép
      return animal.type === 'kutya' ? this.defaultDogImg : this.defaultCatImg
    },
  },
}
</script>

<template>
  <div class="card border-0 shadow-sm">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">

          <thead class="bg-light">
          <tr>
            <th class="px-4 py-3">Állat</th>
            <th>Típus</th>
            <th>Nem</th>
            <th>Kor</th>
            <th>Státusz</th>
            <th>Oltott</th>
            <th class="text-end px-4">Műveletek</th>
          </tr>
          </thead>

          <tbody>
          <tr v-for="animal in animals" :key="animal.id">

            <!-- Kép + Név + Fajta -->
            <td class="px-4">
              <div class="d-flex align-items-center gap-3">
                <img
                    :src="getImageUrl(animal)"
                    :alt="animal.name"
                    style="width: 45px; height: 45px; object-fit: cover; border-radius: 8px;"
                    @error="e => e.target.src = animal.type === 'kutya' ? defaultDogImg : defaultCatImg"
                />
                <div>
                  <div class="fw-semibold">{{ animal.name }}</div>
                  <div class="text-muted small">{{ animal.breed ?? 'Keverék' }}</div>
                </div>
              </div>
            </td>

            <td>
                <span class="badge bg-light text-dark border">
                  {{ animal.type === 'kutya' ? '🐶' : '🐱' }} {{ animal.type }}
                </span>
            </td>

            <td class="small text-muted">
              {{ animal.gender === 'him' ? '♂ Hím' : '♀ Nőstény' }}
            </td>

            <td class="small">{{ animal.age }} év</td>

            <td>
                <span :class="`badge badge-${animal.status}`">
                  {{ statusLabels[animal.status] }}
                </span>
            </td>

            <td>
              <i :class="animal.is_vaccinated
                  ? 'bi bi-check-circle-fill text-success fs-5'
                  : 'bi bi-x-circle-fill text-danger fs-5'">
              </i>
            </td>

            <td class="text-end px-4">
              <div class="d-flex gap-2 justify-content-end">
                <button
                    class="btn btn-outline-primary btn-sm"
                    @click="$emit('edit', animal)"
                    title="Szerkesztés"
                >
                  <i class="bi bi-pencil"></i>
                </button>
                <button
                    class="btn btn-outline-danger btn-sm"
                    @click="$emit('delete', animal)"
                    title="Törlés"
                >
                  <i class="bi bi-trash"></i>
                </button>
              </div>
            </td>

          </tr>

          <!-- Üres állapot -->
          <tr v-if="animals.length === 0">
            <td colspan="7" class="text-center text-muted py-5">
              Nincs megjeleníthető állat.
            </td>
          </tr>
          </tbody>

        </table>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>