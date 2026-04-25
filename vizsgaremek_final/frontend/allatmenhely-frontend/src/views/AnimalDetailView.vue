<script>
import AnimalCard from '@/components/animals/AnimalCard.vue'
import AdoptionForm from '@/components/forms/AdoptionForm.vue'
import AppointmentForm from '@/components/forms/AppointmentForm.vue'
import axios from '@/services/api.js'
import { mapState } from 'pinia' // Pinia állapothoz
import { useAuthStore } from '@/stores/auth' // AuthStore a bejelentkezéshez
import defaultDogImg from '@/assets/images/dog2d.jpg'
import defaultCatImg from '@/assets/images/cat2d.jpg'

export default {
  name: 'AnimalDetailView',

  components: {
    AnimalCard,
    AdoptionForm,
    AppointmentForm
  },
  data() {
    return {
      animal: null,
      similarAnimals: [],
      currentImageIndex: 0,
      showAdoptionForm: false,
      showAppointmentForm: false,
      loading: false,
      error: '',
      defaultDogImg,
      defaultCatImg,
    }
  },
  computed: {
    // Itt kérjük le, hogy be van-e jelentkezve a user
    ...mapState(useAuthStore, ['isLoggedIn']),

    storageUrl() {
      return import.meta.env.VITE_STORAGE_URL
    },
    currentImage() {
      if (!this.animal || !this.animal.images || this.animal.images.length === 0) {
        return this.animal?.type === 'kutya' ? defaultDogImg : defaultCatImg
      }
      const image = this.animal.images[this.currentImageIndex]
      return `${this.storageUrl}/${image.image_path}`
    },
    genderText() {
      return this.animal?.gender === 'him' ? 'Hím' : 'Nőstény'
    },
    statusText() {
      const statuses = {
        'elerheto': 'Elérhető',
        'foglalas_alatt': 'Foglalás alatt',
        'orokbefogadva': 'Örökbefogadva'
      }
      return statuses[this.animal?.status] || this.animal?.status
    },
    statusClass() {
      const classes = {
        'elerheto': 'bg-success',
        'foglalas_alatt': 'bg-warning text-dark',
        'orokbefogadva': 'bg-danger'
      }
      return classes[this.animal?.status] || 'bg-secondary'
    }
  },

  mounted() {
    this.fetchAnimal()
  },
  methods: {
    async fetchAnimal() {
      this.loading = true
      this.error = ''
      try {
        const animalId = this.$route.params.id
        const response = await axios.get(`/animals/${animalId}`)
        this.animal = response.data.data || response.data
        this.fetchSimilarAnimals()
      } catch (err) {
        this.error = 'Hiba történt az állat betöltése során.'
        console.error('Fetch animal error:', err)
      } finally {
        this.loading = false
      }
    },
    async fetchSimilarAnimals() {
      if (!this.animal) return
      try {
        const response = await axios.get('/animals', {
          params: {
            type: this.animal.type,
            status: 'elerheto',
            limit: 4
          }
        })
        this.similarAnimals = (response.data.data || response.data)
            .filter(a => a.id !== this.animal.id)
            .slice(0, 3)
      } catch (err) {
        console.error('Fetch similar animals error:', err)
      }
    },
    selectImage(index) {
      this.currentImageIndex = index
    }
  },
  watch: {
    '$route.params.id': {
      handler() {
        this.fetchAnimal()
        this.showAdoptionForm = false
        this.showAppointmentForm = false
        window.scrollTo(0, 0)
      }
    }
  }
}
</script>

<template>
  <div class="container py-5">
    <div v-if="loading" class="text-center py-5">
      <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Betöltés...</span>
      </div>
      <p class="mt-3 text-muted">Állat adatainak betöltése...</p>
    </div>

    <div v-else-if="error" class="alert alert-danger" role="alert">
      <i class="bi bi-exclamation-triangle-fill"></i>
      {{ error }}
    </div>

    <div v-else-if="animal">
      <div class="mb-4">
        <router-link to="/orokbefogadas" class="btn btn-outline-secondary">
          <i class="bi bi-arrow-left"></i> Vissza a listához
        </router-link>
      </div>

      <div class="row">
        <div class="col-lg-6 mb-4">
          <div class="card shadow-sm mb-3">
            <img
                :src="currentImage"
                :alt="animal.name"
                class="card-img-top"
                style="height: 500px; object-fit: cover;"
                @error="e => e.target.src = animal.type === 'kutya' ? defaultDogImg : defaultCatImg"
            >
          </div>
          <div v-if="animal.images && animal.images.length > 1" class="d-flex gap-2">
            <div
                v-for="(image, index) in animal.images"
                :key="image.id"
                class="thumbnail-wrapper"
                @click="selectImage(index)"
            >
              <img
                  :src="`${storageUrl}/${image.image_path}`"
                  :alt="`${animal.name} ${index + 1}`"
                  class="img-thumbnail"
                  :class="{ 'active-thumbnail': currentImageIndex === index }"
                  style="width: 80px; height: 80px; object-fit: cover; cursor: pointer;"
              >
            </div>
          </div>
        </div>

        <div class="col-lg-6">
          <div class="card shadow-sm mb-4">
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-start mb-3">
                <h1 class="display-5 fw-bold mb-0">{{ animal.name }}</h1>
                <span class="badge fs-6" :class="statusClass">{{ statusText }}</span>
              </div>

              <div class="mb-3">
                <span class="badge me-2" :class="animal.type === 'kutya' ? 'bg-secondary' : 'bg-success'">
                  {{ animal.type === 'kutya' ? '🐕 Kutya' : '🐈 Macska' }}
                </span>
                <span class="badge bg-secondary">{{ genderText }}</span>
              </div>

              <hr>

              <div class="row mb-3">
                <div class="col-6">
                  <p class="mb-2">
                    <strong><i class="bi bi-calendar text-secondary"></i> Életkor:</strong><br>
                    {{ animal.age }} éves
                  </p>
                </div>
                <div class="col-6" v-if="animal.breed">
                  <p class="mb-2">
                    <strong><i class="bi bi-tag text-secondary"></i> Fajta:</strong><br>
                    {{ animal.breed }}
                  </p>
                </div>
              </div>

              <div class="row mb-3">
                <div class="col-6">
                  <p class="mb-0">
                    <i class="bi bi-shield-check text-success"></i>
                    <strong>Oltva:</strong> {{ animal.is_vaccinated ? 'Igen' : 'Nem' }}
                  </p>
                </div>
                <div class="col-6">
                  <p class="mb-0">
                    <i class="bi bi-check-circle text-success"></i>
                    <strong>Ivartalanítva:</strong> {{ animal.is_neutered ? 'Igen' : 'Nem' }}
                  </p>
                </div>
              </div>

              <hr>

              <h5 class="mb-3">
                <i class="bi bi-chat-left-text text-secondary"></i> Bemutatkozás
              </h5>
              <p class="text-muted" style="white-space: pre-line;">
                {{ animal.description || 'Nincs leírás.' }}
              </p>
            </div>
          </div>

          <template v-if="isLoggedIn">
            <div class="d-grid gap-2 mb-4">
              <button
                  class="btn btn-danger btn-lg shadow-sm"
                  @click="showAdoptionForm = !showAdoptionForm; showAppointmentForm = false"
                  :disabled="animal.status !== 'elerheto'"
              >
                <i class="bi bi-heart-fill me-2"></i>
                {{ animal.status !== 'elerheto' ? 'Nem elérhető' : 'Örökbefogadás' }}
              </button>

              <button
                  class="btn btn-outline-primary btn-lg shadow-sm"
                  @click="showAppointmentForm = !showAppointmentForm; showAdoptionForm = false"
              >
                <i class="bi bi-calendar-check me-2"></i>
                Időpontfoglalás
              </button>
            </div>

            <div v-if="showAdoptionForm" class="mb-4 card border-danger shadow-sm">
              <div class="card-body">
                <AdoptionForm :animal-id="animal.id" />
              </div>
            </div>

            <div v-if="showAppointmentForm" class="mb-4 card border-primary shadow-sm">
              <div class="card-body">
                <AppointmentForm :animal-id="animal.id" />
              </div>
            </div>
          </template>

          <div v-else class="alert alert-warning text-center shadow-sm p-4 mb-4">
            <i class="bi bi-lock-fill fs-3 d-block mb-2"></i>
            <p class="mb-3 fw-bold">Kérlek jelentkezz be az örökbefogadási vagy az időpontfoglalási űrlap kitöltéséhez!</p>
            <div class="d-grid col-md-8 mx-auto">
              <RouterLink to="/bejelentkezes" class="btn btn-secondary">
                Bejelentkezés
              </RouterLink>
            </div>
          </div>

        </div>
      </div>

      <section class="mt-5" v-if="similarAnimals.length > 0">
        <h3 class="mb-4">Hasonló állatok</h3>
        <div class="row">
          <div
              v-for="similar in similarAnimals"
              :key="similar.id"
              class="col-md-6 col-lg-4 mb-4"
          >
            <AnimalCard :animal="similar" />
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<style scoped>
.active-thumbnail {
  border: 3px solid #0d6efd !important;
}

.thumbnail-wrapper {
  flex: 0 0 auto;
}
</style>