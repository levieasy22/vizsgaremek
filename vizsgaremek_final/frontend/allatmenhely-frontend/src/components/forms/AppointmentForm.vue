<script>
import axios from '@/services/api.js'
import {createRouter} from "vue-router";

export default {
  name: 'AppointmentForm',
  components: {
    createRouter,
  },
  props: {
    animalId: {
      type: Number,
      default: null
    }
  },

  data() {
    return {
      form: {
        type: '',
        first_name: '',
        last_name: '',
        email: '',
        phone: '',
        appointment_date: '',
        appointment_time: '',
        notes: ''
      },
      loading: false,
      success: false,
      error: ''
    }
  },

  computed: {
    minDate() {
      // Holnapi naptól lehet foglalni
      const tomorrow = new Date()
      tomorrow.setDate(tomorrow.getDate() + 1)
      return tomorrow.toISOString().split('T')[0]
    }
  },

  methods: {
    async submitForm() {
      this.loading = true
      this.error = ''

      try {
        const data = {
          ...this.form
        }

        // Ha van animal_id (állatmegtekintés), hozzáadjuk
        if (this.animalId) {
          data.animal_id = this.animalId
        }

        await axios.post('/appointments', data)

        this.success = true
        this.resetForm()
      } catch (err) {
        this.error = err.response?.data?.message || 'Hiba történt a foglalás során.'
      } finally {
        this.loading = false
      }
    },

    resetForm() {
      this.form = {
        type: '',
        first_name: '',
        last_name: '',
        email: '',
        phone: '',
        appointment_date: '',
        appointment_time: '',
        notes: ''
      }
    }
  }
}
</script>

<template>
  <div class="card shadow-sm">
    <div class="card-body">
      <h4 class="card-title mb-4">
        <i class="bi bi-calendar-check text-primary"></i>
        Időpontfoglalás
      </h4>

      <!-- Sikeres küldés üzenet -->
      <div v-if="success" class="alert alert-success" role="alert">
        <i class="bi bi-check-circle-fill"></i>
        Időpontfoglalásod sikeresen rögzítettük! Hamarosan megerősítő emailt küldünk.
      </div>

      <!-- Hibaüzenet -->
      <div v-if="error" class="alert alert-danger" role="alert">
        <i class="bi bi-exclamation-triangle-fill"></i>
        {{ error }}
      </div>

      <form @submit.prevent="submitForm" v-if="!success">
        <!-- Időpont típusa -->
        <div class="mb-3">
          <label for="type" class="form-label">Időpont típusa *</label>
          <select
              class="form-select"
              id="type"
              v-model="form.type"
              required
          >
            <option value="">Válassz...</option>
            <option value="megtekintes">Állatmegtekintés</option>
            <option value="konzultacio">Konzultáció</option>
            <option value="esemeny">Esemény</option>
          </select>
        </div>

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

        <!-- Időpont választás -->
        <div class="row mb-3">
          <div class="col-md-6">
            <label for="appointment_date" class="form-label">Dátum *</label>
            <input
                type="date"
                class="form-control"
                id="appointment_date"
                v-model="form.appointment_date"
                :min="minDate"
                required
            >
          </div>
          <div class="col-md-6">
            <label for="appointment_time" class="form-label">Időpont *</label>
            <select
                class="form-select"
                id="appointment_time"
                v-model="form.appointment_time"
                required
            >
              <option value="">Válassz időpontot...</option>
              <option value="09:00">09:00</option>
              <option value="10:00">10:00</option>
              <option value="11:00">11:00</option>
              <option value="12:00">12:00</option>
              <option value="13:00">13:00</option>
              <option value="14:00">14:00</option>
              <option value="15:00">15:00</option>
              <option value="16:00">16:00</option>
              <option value="17:00">17:00</option>
            </select>
          </div>
        </div>

        <!-- Megjegyzés -->
        <div class="mb-3">
          <label for="notes" class="form-label">Megjegyzés (opcionális)</label>
          <textarea
              class="form-control"
              id="notes"
              v-model="form.notes"
              rows="3"
              placeholder="Ha van valami, amit tudnunk kell..."
          ></textarea>
        </div>

        <!-- Küldés gomb -->
        <button
            type="submit"
            class="btn btn-primary w-100"
            :disabled="loading"
        >
          <span v-if="loading">
            <span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
            Foglalás...
          </span>
          <span v-else>
            <i class="bi bi-calendar-plus"></i> Időpont foglalása
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