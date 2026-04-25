<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { adminService } from '@/services/adminService'
import StatsCard from '@/components/admin/StatsCard.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'
import AlertMessage from '@/components/ui/AlertMessage.vue'

const auth    = useAuthStore()
const stats   = ref(null)
const loading = ref(false)
const error   = ref('')

const adoptionStatusLabels = {
  fuggoben:   'Függőben',
  elfogadva:  'Elfogadva',
  elutasitva: 'Elutasítva',
}

const appointmentTypeLabels = {
  megtekintes: 'Megtekintés',
  konzultacio: 'Konzultáció',
  esemeny:     'Esemény',
}

function formatDate(dateStr) {
  if (!dateStr) return '–'
  return new Date(dateStr).toLocaleDateString('hu-HU')
}

onMounted(async () => {
  loading.value = true
  try {
    const { data } = await adminService.getStats()
    stats.value   = data
  } catch (err) {
    error.value = 'A statisztikák betöltése sikertelen.'
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <div>

    <!-- Fejléc -->
    <div class="mb-4">
      <h2 class="fw-bold mb-1">Áttekintés</h2>
      <p class="text-muted mb-0">
        Üdvözöljük, <strong>{{ auth.user?.name }}</strong>!
        Itt láthatja a menhely legfontosabb adatait.
      </p>
    </div>

    <!-- Loading -->
    <LoadingSpinner v-if="loading" text="Statisztikák betöltése..." />

    <div v-else-if="stats">

      <!-- ── STAT KÁRTYÁK – 1. sor ─── -->
      <div class="row g-3 mb-3">
        <div class="col-6 col-xl-3">
          <StatsCard
              icon="bi-grid-3x3-gap"
              label="Összes állat"
              :value="stats.animals.total"
              color="#2E7D32"
          />
        </div>
        <div class="col-6 col-xl-3">
          <StatsCard
              icon="bi-check-circle"
              label="Elérhető állat"
              :value="stats.animals.available"
              color="#4CAF50"
          />
        </div>
        <div class="col-6 col-xl-3">
          <StatsCard
              icon="bi-clock-history"
              label="Foglalás alatt"
              :value="stats.animals.reserved"
              color="#FF9800"
          />
        </div>
        <div class="col-6 col-xl-3">
          <StatsCard
              icon="bi-house-heart"
              label="Örökbefogadva"
              :value="stats.animals.adopted"
              color="#9E9E9E"
          />
        </div>
      </div>

      <!-- ── STAT KÁRTYÁK – 2. sor ── -->
      <div class="row g-3 mb-4">
        <div class="col-6 col-xl-3">
          <StatsCard
              icon="bi-heart"
              label="Függőben lévő kérelem"
              :value="stats.adoption_requests.pending"
              color="#E91E63"
          />
        </div>
        <div class="col-6 col-xl-3">
          <StatsCard
              icon="bi-calendar3"
              label="Közelgő időpont"
              :value="stats.appointments.upcoming"
              color="#2196F3"
          />
        </div>
        <div class="col-6 col-xl-3">
          <StatsCard
              icon="bi-envelope"
              label="Olvasatlan üzenet"
              :value="stats.messages.unread"
              color="#F44336"
          />
        </div>
        <div class="col-6 col-xl-3">
          <StatsCard
              icon="bi-people"
              label="Regisztrált felhasználó"
              :value="stats.users.total"
              color="#607D8B"
          />
        </div>
      </div>

      <!-- ── TÁBLÁZATOK ── -->
      <div class="row g-4">

        <!-- Legutóbbi kérelmek -->
        <div class="col-lg-6">
          <div class="card border-0 shadow-sm h-100">
            <div class="card-header bg-white border-0 pt-4 px-4 pb-0">
              <div class="d-flex justify-content-between align-items-center">
                <h6 class="fw-bold mb-0">
                  <i class="bi bi-heart me-2 text-danger"></i>
                  Legutóbbi kérelmek
                </h6>
                <RouterLink
                    :to="{ name: 'AdminAdoptions' }"
                    class="btn btn-outline-primary btn-sm"
                >
                  Összes <i class="bi bi-arrow-right ms-1"></i>
                </RouterLink>
              </div>
            </div>
            <div class="card-body px-4 pt-3">
              <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                  <thead class="text-muted small">
                  <tr>
                    <th class="fw-semibold">Kérelmező</th>
                    <th class="fw-semibold">Állat</th>
                    <th class="fw-semibold">Státusz</th>
                  </tr>
                  </thead>
                  <tbody>
                  <tr
                      v-for="req in stats.recent_adoption_requests"
                      :key="req.id"
                  >
                    <td class="small">{{ req.name }}</td>
                    <td class="small text-muted">{{ req.animal_name ?? '–' }}</td>
                    <td>
                        <span :class="`badge badge-${req.status}`">
                          {{ adoptionStatusLabels[req.status] }}
                        </span>
                    </td>
                  </tr>
                  <tr v-if="!stats.recent_adoption_requests?.length">
                    <td colspan="3" class="text-center text-muted small py-3">
                      Nincs kérelem
                    </td>
                  </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>

        <!-- Közelgő időpontok -->
        <div class="col-lg-6">
          <div class="card border-0 shadow-sm h-100">
            <div class="card-header bg-white border-0 pt-4 px-4 pb-0">
              <div class="d-flex justify-content-between align-items-center">
                <h6 class="fw-bold mb-0">
                  <i class="bi bi-calendar3 me-2 text-primary"></i>
                  Közelgő időpontok
                </h6>
                <RouterLink
                    :to="{ name: 'AdminAppointments' }"
                    class="btn btn-outline-primary btn-sm"
                >
                  Összes <i class="bi bi-arrow-right ms-1"></i>
                </RouterLink>
              </div>
            </div>
            <div class="card-body px-4 pt-3">
              <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                  <thead class="text-muted small">
                  <tr>
                    <th class="fw-semibold">Foglalóval</th>
                    <th class="fw-semibold">Dátum</th>
                    <th class="fw-semibold">Típus</th>
                  </tr>
                  </thead>
                  <tbody>
                  <tr
                      v-for="apt in stats.upcoming_appointments"
                      :key="apt.id"
                  >
                    <td class="small">{{ apt.name }}</td>
                    <td class="small text-muted">
                      {{ formatDate(apt.appointment_date) }}
                      {{ apt.appointment_time?.slice(0,5) }}
                    </td>
                    <td>
                        <span class="badge bg-light text-dark border small">
                          {{ appointmentTypeLabels[apt.type] }}
                        </span>
                    </td>
                  </tr>
                  <tr v-if="!stats.upcoming_appointments?.length">
                    <td colspan="3" class="text-center text-muted small py-3">
                      Nincs közelgő időpont
                    </td>
                  </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>

    <!-- Ha nem sikerült betölteni -->
    <AlertMessage
        :message="error"
        type="danger"
        @dismiss="error = ''"
    />

  </div>
</template>

<style scoped>

</style>