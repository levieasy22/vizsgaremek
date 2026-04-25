<script>
import axios from '@/services/api.js'
import {createRouter} from "vue-router";

export default {
  name: 'ContactForm',
  components: {
    createRouter,
  },
  data() {
    return {
      form: {
        name: '',
        email: '',
        subject: '',
        message: ''
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
        await axios.post('/contact', this.form)

        this.success = true
        this.resetForm()
      } catch (err) {
        this.error = err.response?.data?.message || 'Hiba történt az üzenet küldése során.'
      } finally {
        this.loading = false
      }
    },

    resetForm() {
      this.form = {
        name: '',
        email: '',
        subject: '',
        message: ''
      }
    }
  }
}
</script>

<template>
  <div class="card shadow-sm">
    <div class="card-body">
      <h4 class="card-title mb-4">
        <i class="bi bi-envelope-fill text-secondary text-success"></i>
        Írj nekünk!
      </h4>

      <!-- Sikeres küldés üzenet -->
      <div v-if="success" class="alert alert-success" role="alert">
        <i class="bi bi-check-circle-fill"></i>
        Üzeneted sikeresen elküldtük! Hamarosan válaszolunk.
      </div>

      <!-- Hibaüzenet -->
      <div v-if="error" class="alert alert-danger" role="alert">
        <i class="bi bi-exclamation-triangle-fill"></i>
        {{ error }}
      </div>

      <form @submit.prevent="submitForm" v-if="!success">
        <!-- Név -->
        <div class="mb-3">
          <label for="name" class="form-label">Neved *</label>
          <input
              type="text"
              class="form-control"
              id="name"
              v-model="form.name"
              required
              placeholder="Teljes neved"
          >
        </div>

        <!-- Email -->
        <div class="mb-3">
          <label for="email" class="form-label">E-mail címed *</label>
          <input
              type="email"
              class="form-control"
              id="email"
              v-model="form.email"
              required
              placeholder="pelda@email.com"
          >
        </div>

        <!-- Tárgy -->
        <div class="mb-3">
          <label for="subject" class="form-label">Tárgy *</label>
          <input
              type="text"
              class="form-control"
              id="subject"
              v-model="form.subject"
              required
              placeholder="Miben segíthetünk?"
          >
        </div>

        <!-- Üzenet -->
        <div class="mb-3">
          <label for="message" class="form-label">Üzenet *</label>
          <textarea
              class="form-control"
              id="message"
              v-model="form.message"
              rows="5"
              required
              placeholder="Írd le részletesen, miben segíthetünk..."
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
            Küldés...
          </span>
          <span v-else>
            <i class="bi bi-send-fill"></i> Üzenet küldése
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