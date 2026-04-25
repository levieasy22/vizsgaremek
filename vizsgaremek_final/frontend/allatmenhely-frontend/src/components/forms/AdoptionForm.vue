<script>
import axios from '@/services/api.js'
import {createRouter} from "vue-router";

export default {
  name: 'AdoptionForm',
  components: {
    createRouter,
  },
  props: {
    animalId: {
      type: Number,
      required: true
    }
  },

  data() {
    return {
      form: {
        first_name: '',
        last_name: '',
        email: '',
        phone: '',
        address: '',
        motivation: '',
        has_garden: false,
        has_other_pets: false,
        gdpr_consent: false
      },
      loading: false,
      success: false,
      error: ''
    }
  },

  methods: {
    async submitForm() {
      this.loading = true
      this.error = ''

      try {
        await axios.post('/adoption-requests', {
          animal_id: this.animalId,
          ...this.form
        })

        this.success = true
        this.resetForm()
      } catch (err) {
        this.error = err.response?.data?.message || 'Hiba történt a kérelem küldése során.'
      } finally {
        this.loading = false
      }
    },

    resetForm() {
      this.form = {
        first_name: '',
        last_name: '',
        email: '',
        phone: '',
        address: '',
        motivation: '',
        has_garden: false,
        has_other_pets: false,
        gdpr_consent: false
      }
    }
  }
}
</script>

<template>
  <div class="card shadow-sm">
    <div class="card-body">
      <h4 class="card-title mb-4">
        <i class="bi bi-heart-fill text-danger"></i>
        Örökbefogadási kérelem
      </h4>

      <!-- Sikeres küldés üzenet -->
      <div v-if="success" class="alert alert-success" role="alert">
        <i class="bi bi-check-circle-fill"></i>
        Kérelmed sikeresen elküldtük! Hamarosan felvesszük veled a kapcsolatot.
      </div>

      <!-- Hibaüzenet -->
      <div v-if="error" class="alert alert-danger" role="alert">
        <i class="bi bi-exclamation-triangle-fill"></i>
        {{ error }}
      </div>

      <form @submit.prevent="submitForm" v-if="!success">
        <!-- Személyes adatok -->
        <div class="row mb-3">
          <div class="col-md-6">
            <label for="first_name" class="form-label">Vezetéknév *</label>
            <input
                type="text"
                class="form-control"
                id="first_name"
                v-model="form.first_name"
                required
            >
          </div>
          <div class="col-md-6">
            <label for="last_name" class="form-label">Keresztnév *</label>
            <input
                type="text"
                class="form-control"
                id="last_name"
                v-model="form.last_name"
                required
            >
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label for="email" class="form-label">E-mail cím *</label>
            <input
                type="email"
                class="form-control"
                id="email"
                v-model="form.email"
                required
            >
          </div>
          <div class="col-md-6">
            <label for="phone" class="form-label">Telefonszám *</label>
            <input
                type="tel"
                class="form-control"
                id="phone"
                v-model="form.phone"
                required
                placeholder="+36 20 123 4567"
            >
          </div>
        </div>

        <div class="mb-3">
          <label for="address" class="form-label">Lakcím *</label>
          <input
              type="text"
              class="form-control"
              id="address"
              v-model="form.address"
              required
              placeholder="Irányítószám, Város, Utca, Házszám"
          >
        </div>

        <!-- Motiváció -->
        <div class="mb-3">
          <label for="motivation" class="form-label">
            Miért szeretnéd örökbefogadni ezt az állatot? *
          </label>
          <textarea
              class="form-control"
              id="motivation"
              v-model="form.motivation"
              rows="4"
              required
              placeholder="Írj pár mondatot arról, miért szeretnéd..."
          ></textarea>
        </div>

        <!-- Kérdések -->
        <div class="mb-3">
          <div class="form-check">
            <input
                class="form-check-input"
                type="checkbox"
                id="has_garden"
                v-model="form.has_garden"
            >
            <label class="form-check-label" for="has_garden">
              Van kerted vagy udvarod?
            </label>
          </div>
        </div>

        <div class="mb-3">
          <div class="form-check">
            <input
                class="form-check-input"
                type="checkbox"
                id="has_other_pets"
                v-model="form.has_other_pets"
            >
            <label class="form-check-label" for="has_other_pets">
              Vannak más háziállataid?
            </label>
          </div>
        </div>

        <!-- GDPR -->
        <div class="mb-3">
          <div class="form-check">
            <input
                class="form-check-input"
                type="checkbox"
                id="gdpr_consent"
                v-model="form.gdpr_consent"
                required
            >
            <label class="form-check-label" for="gdpr_consent">
              Elfogadom az adatkezelési tájékoztatót *
            </label>
          </div>
        </div>

        <!-- Küldés gomb -->
        <button
            type="submit"
            class="btn btn-primary w-100"
            :disabled="loading"
        >
          <span v-if="loading">
            <span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
            Küldés...
          </span>
          <span v-else>
            <i class="bi bi-send-fill"></i> Kérelem elküldése
          </span>
        </button>

        <p class="text-muted mt-3 mb-0">
          <small>* Kötelező mező</small>
        </p>
      </form>
    </div>
  </div>
</template>

<style scoped>

</style>