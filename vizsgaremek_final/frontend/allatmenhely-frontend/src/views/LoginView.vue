<script>
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import AlertMessage from '@/components/ui/AlertMessage.vue'
import { ref } from 'vue'

export default {
  name: 'LoginView',
  components: {
    AlertMessage,
  },
  data() {
    return {
      router: useRouter(),
      auth: useAuthStore(),
      form: {
        email: '',
        password: '',
      },
      loading: false,
      errorMsg: '',
      errors: {},
    }
  },
  methods: {
    async handleLogin() {
      this.loading = true
      this.errorMsg = ''
      this.errors = {}

      try {
        await this.auth.login(this.form)

        if (this.auth.isAdmin) {
          this.router.push({ name: 'AdminDashboard' })
        } else {
          this.router.push({ name: 'Home' })
        }

      } catch (err) {
        if (err.response?.status === 422) {
          this.errors = err.response.data.errors || {}
        }
        this.errorMsg = err.response?.data?.message || 'Hibás email cím vagy jelszó.'
      } finally {
        this.loading = false
      }
    },
  },
}
</script>

<template>
  <div class="min-vh-100 d-flex align-items-center py-5 bg-light">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">

          <div class="card shadow border-0 rounded-4">
            <div class="card-body p-5">

              <!-- Fejléc -->
              <div class="text-center mb-4">
                <div class="display-4 mb-2">🐾</div>
                <h2 class="fw-bold">Bejelentkezés</h2>
                <p class="text-muted small">Üdvözlünk vissza!</p>
              </div>

              <!-- Hibaüzenet -->
              <AlertMessage
                  :message="errorMsg"
                  type="danger"
                  @dismiss="errorMsg = ''"
              />

              <!-- Form -->
              <form @submit.prevent="handleLogin">

                <div class="mb-3">
                  <label class="form-label fw-semibold">Email cím</label>
                  <input
                      v-model="form.email"
                      type="email"
                      class="form-control"
                      :class="{ 'is-invalid': errors.email }"
                      placeholder="pelda@email.hu"
                      required
                  />
                  <div class="invalid-feedback">{{ errors.email?.[0] }}</div>
                </div>

                <div class="mb-4">
                  <label class="form-label fw-semibold">Jelszó</label>
                  <input
                      v-model="form.password"
                      type="password"
                      class="form-control"
                      :class="{ 'is-invalid': errors.password }"
                      placeholder="••••••••"
                      required
                  />
                  <div class="invalid-feedback">{{ errors.password?.[0] }}</div>
                </div>

                <button
                    type="submit"
                    class="btn btn-primary w-100 py-2 fw-bold"
                    :disabled="loading"
                >
                  <span
                      v-if="loading"
                      class="spinner-border spinner-border-sm me-2"
                  ></span>
                  Bejelentkezés
                </button>

              </form>

              <hr class="my-4">

              <p class="text-center text-muted small mb-0">
                Még nincs fiókod?
                <RouterLink to="/regisztracio" class="text-primary fw-semibold">
                  Regisztrálj!
                </RouterLink>
              </p>

            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>