<script>
import AnimalCard from '@/components/animals/AnimalCard.vue'
import axios from '@/services/api.js'
import {createRouter} from "vue-router";

export default {
  name: 'AdoptionView',
  components: {
    AnimalCard,
    createRouter,
    api: axios
  },
  data() {
    return {
      animals: [],
      filters: {
        type: '',
        gender: '',
        age: '',
        search: ''
      },
      loading: false,
      error: ''
    }
  },
  computed: {
    filteredAnimals() {
      let result = [...this.animals]
      // Típus szűrés
      if (this.filters.type) {
        result = result.filter(animal => animal.type === this.filters.type)
      }
      // Nem szűrés
      if (this.filters.gender) {
        result = result.filter(animal => animal.gender === this.filters.gender)
      }
      // Kor szűrés
      if (this.filters.age) {
        if (this.filters.age === 'young') {
          result = result.filter(animal => animal.age >= 0 && animal.age <= 2)
        } else if (this.filters.age === 'adult') {
          result = result.filter(animal => animal.age >= 3 && animal.age <= 7)
        } else if (this.filters.age === 'senior') {
          result = result.filter(animal => animal.age >= 8)
        }
      }
      // Keresés (név vagy fajta)
      if (this.filters.search) {
        const searchLower = this.filters.search.toLowerCase()
        result = result.filter(animal => {
          const nameMatch = animal.name.toLowerCase().includes(searchLower)
          const breedMatch = animal.breed && animal.breed.toLowerCase().includes(searchLower)
          return nameMatch || breedMatch
        })
      }
      return result
    },
    hasActiveFilters() {
      return this.filters.type ||
          this.filters.gender ||
          this.filters.age ||
          this.filters.search
    }
  },
  mounted() {
    this.fetchAnimals()
    // URL query param alapján beállítjuk a szűrőt (menüből érkezés)
    const typeFromQuery = this.$route.query.type
    if (typeFromQuery && ['kutya', 'macska'].includes(typeFromQuery)) {
      this.filters.type = typeFromQuery
    }
  },
  watch: {
    '$route.query.type'(newType) {
      if (newType && ['kutya', 'macska'].includes(newType)) {
        this.filters.type = newType
      } else {
        this.filters.type = ''
      }
    }
  },
  methods: {
    async fetchAnimals() {
      this.loading = true
      this.error = ''

      try {
        // Csak az elérhető állatok lekérése
        const response = await axios.get('/animals', {
          params: {
            status: 'elerheto'
          }
        })
        this.animals = response.data.data || response.data
      } catch (err) {
        this.error = 'Hiba történt az állatok betöltése során.'
        console.error('Fetch animals error:', err)
      } finally {
        this.loading = false
      }
    },
    applyFilters() {
      // A computed property automatikusan újraszámol
      // Ez a metódus opcionális, ha szeretnénk külön kezelni a szűrés eseményét
    },
    clearFilters() {
      this.filters = {
        type: '',
        gender: '',
        age: '',
        search: ''
      }
    }
  }
}
</script>

<template>
  <div class="container py-5">
    <!-- Fejléc -->
    <div class="text-center mb-5">
      <h1 class="display-4 fw-bold mb-3">
        Örökbefogadható állatok
      </h1>
      <p class="lead text-muted">
        Minden állatunk oltva, ivartalanítva és új otthonra vár
      </p>
    </div>

    <!-- Szűrők -->
    <div class="card shadow-sm mb-4">
      <div class="card-body">
        <div class="row g-3">
          <!-- Típus szűrő -->
          <div class="col-md-3">
            <label for="typeFilter" class="form-label">
              <i class="bi bi-funnel"></i> Típus
            </label>
            <select
                class="form-select"
                id="typeFilter"
                v-model="filters.type"
                @change="applyFilters"
            >
              <option value="">Mindkettő</option>
              <option value="kutya">🐕 Kutya</option>
              <option value="macska">🐈 Macska</option>
            </select>
          </div>

          <!-- Nem szűrő -->
          <div class="col-md-3">
            <label for="genderFilter" class="form-label">
              <i class="bi bi-gender-ambiguous"></i> Neme
            </label>
            <select
                class="form-select"
                id="genderFilter"
                v-model="filters.gender"
                @change="applyFilters"
            >
              <option value="">Mindkettő</option>
              <option value="him">Hím</option>
              <option value="nosteny">Nőstény</option>
            </select>
          </div>

          <!-- Kor szűrő -->
          <div class="col-md-3">
            <label for="ageFilter" class="form-label">
              <i class="bi bi-calendar"></i> Életkor
            </label>
            <select
                class="form-select"
                id="ageFilter"
                v-model="filters.age"
                @change="applyFilters"
            >
              <option value="">Összes</option>
              <option value="young">Kölyök (0-2 év)</option>
              <option value="adult">Felnőtt (3-7 év)</option>
              <option value="senior">Idős (8+ év)</option>
            </select>
          </div>

          <!-- Keresés -->
          <div class="col-md-3">
            <label for="searchFilter" class="form-label">
              <i class="bi bi-search"></i> Keresés
            </label>
            <input
                type="text"
                class="form-control"
                id="searchFilter"
                v-model="filters.search"
                @input="applyFilters"
                placeholder="Név vagy fajta..."
            >
          </div>
        </div>

        <!-- Szűrők törlése -->
        <div class="mt-3" v-if="hasActiveFilters">
          <button
              class="btn btn-outline-secondary btn-sm"
              @click="clearFilters"
          >
            <i class="bi bi-x-circle"></i> Szűrők törlése
          </button>
        </div>
      </div>
    </div>

    <!-- Találatok száma -->
    <div class="mb-3">
      <p class="text-muted">
        <strong>{{ filteredAnimals.length }}</strong> állat található
      </p>
    </div>

    <!-- Loading state -->
    <div v-if="loading" class="text-center py-5">
      <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Betöltés...</span>
      </div>
      <p class="mt-3 text-muted">Állatok betöltése...</p>
    </div>

    <!-- Error state -->
    <div v-else-if="error" class="alert alert-danger" role="alert">
      <i class="bi bi-exclamation-triangle-fill"></i>
      {{ error }}
    </div>

    <!-- Nincs találat -->
    <div v-else-if="filteredAnimals.length === 0" class="text-center py-5">
      <i class="bi bi-search" style="font-size: 4rem; color: #ccc;"></i>
      <h4 class="mt-3 text-muted">Nincs találat</h4>
      <p class="text-muted">Próbálj más szűrőbeállításokkal!</p>
    </div>

    <!-- Állatok listája -->
    <div v-else class="row">
      <div
          v-for="animal in filteredAnimals"
          :key="animal.id"
          class="col-md-6 col-lg-4 mb-4"
      >
        <AnimalCard :animal="animal" />
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>