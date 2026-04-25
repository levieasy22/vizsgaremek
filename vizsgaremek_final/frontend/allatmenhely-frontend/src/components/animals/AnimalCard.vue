<script>
import {createRouter} from "vue-router";
import defaultDogImg from '@/assets/images/dog2d.jpg'
import defaultCatImg from '@/assets/images/cat2d.jpg'

export default {
  name: 'AnimalCard',
  data() {
    return {
      defaultDogImg,
      defaultCatImg,
    }
  },
  components: {
    createRouter,
  },
  props: {
    animal: {
      type: Object,
      required: true
    }
  },
  computed: {
    animalImage() {
      // Backend returns full URL in primary_image_url
      if (this.animal.primary_image_url) {
        return this.animal.primary_image_url
      }
      // Or check images array for detail view
      if (this.animal.images && this.animal.images.length > 0) {
        const primaryImage = this.animal.images.find(img => img.is_primary) || this.animal.images[0]
        return `${import.meta.env.VITE_STORAGE_URL}/${primaryImage.image_path}`
      }
      // Alapértelmezett kép ha nincs feltöltött kép
      return this.animal.type === 'kutya'
          ? defaultDogImg
          : defaultCatImg
    },
    genderText() {
      return this.animal.gender === 'him' ? 'Hím' : 'Nőstény'
    },
    statusText() {
      const statuses = {
        'elerheto': 'Elérhető',
        'foglalas_alatt': 'Foglalás alatt',
        'orokbefogadva': 'Örökbefogadva'
      }
      return statuses[this.animal.status] || this.animal.status
    },
    statusClass() {
      const classes = {
        'elerheto': 'bg-success',
        'foglalas_alatt': 'bg-warning text-dark',
        'orokbefogadva': 'bg-danger'
      }
      return classes[this.animal.status] || 'bg-secondary'
    },
    shortDescription() {
      if (!this.animal.description) return 'Nincs leírás.'
      return this.animal.description.length > 100
          ? this.animal.description.substring(0, 100) + '...'
          : this.animal.description
    }
  }
}
</script>

<template>
  <div class="card h-100 shadow-sm animal-card">
    <!-- Állat képe -->
    <img
        :src="animalImage"
        class="card-img-top"
        :alt="animal.name"
        style="height: 250px; object-fit: cover;"
        @error="e => e.target.src = animal.type === 'kutya' ? defaultDogImg : defaultCatImg"
    >

    <!-- Badge a típusra -->
    <div class="position-absolute top-0 end-0 m-2">
      <span
          class="badge"
          :class="animal.type === 'kutya' ? 'bg-dark' : 'bg-secondary'"
      >
        {{ animal.type === 'kutya' ? 'Kutya' : 'Macska' }}
      </span>
    </div>

    <!-- Státusz badge -->
    <div class="position-absolute top-0 start-0 m-2">
      <span
          class="badge"
          :class="statusClass"
      >
        {{ statusText }}
      </span>
    </div>

    <div class="card-body d-flex flex-column">
      <!-- Állat neve -->
      <h5 class="card-title">{{ animal.name }}</h5>

      <!-- Alapadatok -->
      <div class="mb-3">
        <small class="text-muted d-block">
          <i class="bi bi-gender-ambiguous"></i> {{ genderText }}
        </small>
        <small class="text-muted d-block">
          <i class="bi bi-calendar"></i> {{ animal.age }} éves
        </small>
        <small class="text-muted d-block" v-if="animal.breed">
          <i class="bi bi-tag"></i> {{ animal.breed }}
        </small>
      </div>

      <!-- Leírás rövidített -->
      <p class="card-text flex-grow-1">
        {{ shortDescription }}
      </p>

      <!-- Ikonok - oltva, ivartalanítva -->
      <div class="mb-3">
        <span
            v-if="animal.is_vaccinated"
            class="badge bg-info me-1"
            title="Oltva"
        >
          <i class="bi bi-shield-check"></i> Oltva
        </span>
        <span
            v-if="animal.is_neutered"
            class="badge bg-secondary"
            title="Ivartalanítva"
        >
          <i class="bi bi-check-circle"></i> Ivartalanítva
        </span>
      </div>

      <!-- Részletek gomb -->
      <router-link
          :to="`/allat/${animal.id}`"
          class="btn bg-secondary text-light w-100 mt-auto"
      >
        Részletek <i class="bi bi-arrow-right"></i>
      </router-link>
    </div>
  </div>
</template>

<style scoped>
.animal-card {
  transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.animal-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
}
</style>