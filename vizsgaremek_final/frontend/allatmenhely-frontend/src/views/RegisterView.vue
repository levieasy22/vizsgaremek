<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import AlertMessage from '@/components/ui/AlertMessage.vue'

const router = useRouter()
const auth   = useAuthStore()

const form = ref({
  name:                  '',
  email:                 '',
  phone:                 '',
  password:              '',
  password_confirmation: '',
})
const loading  = ref(false)
const errorMsg = ref('')
const errors   = ref({})

async function handleRegister() {
  loading.value  = true
  errorMsg.value = ''
  errors.value   = {}

  try {
    await auth.register(form.value)
    // Regisztráció után a főoldalra irányítunk
    router.push({ name: 'Home' })

  } catch (err) {
    if (err.response?.status === 422) {
      errors.value = err.response.data.errors || {}
    }
    errorMsg.value = err.response?.data?.message || 'Hiba történt a regisztráció során.'
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="min-vh-100 d-flex align-items-center py-5 bg-light">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">

          <div class="card shadow border-0 rounded-4">
            <div class="card-body p-5">

              <!-- Fejléc -->
              <div class="text-center mb-4">
                <div class="display-4 mb-2">🐾</div>
                <h2 class="fw-bold">Regisztráció</h2>
                <p class="text-muted small">Hozz létre egy fiókot!</p>
              </div>

              <!-- Hibaüzenet -->
              <AlertMessage
                  :message="errorMsg"
                  type="danger"
                  @dismiss="errorMsg = ''"
              />

              <form @submit.prevent="handleRegister">

                <div class="mb-3">
                  <label class="form-label fw-semibold">Teljes név</label>
                  <input
                      v-model="form.name"
                      type="text"
                      class="form-control"
                      :class="{ 'is-invalid': errors.name }"
                      placeholder="Kovács Anna"
                      required
                  />
                  <div class="invalid-feedback">{{ errors.name?.[0] }}</div>
                </div>

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

                <div class="mb-3">
                  <label class="form-label fw-semibold">
                    Telefonszám
                    <span class="text-muted fw-normal">(opcionális)</span>
                  </label>
                  <input
                      v-model="form.phone"
                      type="tel"
                      class="form-control"
                      placeholder="+36 70 123 4567"
                  />
                </div>

                <div class="mb-3">
                  <label class="form-label fw-semibold">Jelszó</label>
                  <input
                      v-model="form.password"
                      type="password"
                      class="form-control"
                      :class="{ 'is-invalid': errors.password }"
                      placeholder="Minimum 8 karakter"
                      required
                  />
                  <div class="invalid-feedback">{{ errors.password?.[0] }}</div>
                </div>

                <div class="mb-4">
                  <label class="form-label fw-semibold">Jelszó megerősítése</label>
                  <input
                      v-model="form.password_confirmation"
                      type="password"
                      class="form-control"
                      placeholder="••••••••"
                      required
                  />
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
                  Regisztráció
                </button>

              </form>

              <hr class="my-4">

              <p class="text-center text-muted small mb-0">
                Már van fiókod?
                <RouterLink to="/bejelentkezes" class="text-primary fw-semibold">
                  Jelentkezz be!
                </RouterLink>
              </p>

            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>