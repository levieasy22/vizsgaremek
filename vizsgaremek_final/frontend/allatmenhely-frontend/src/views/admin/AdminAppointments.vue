<script setup>
import { ref, computed, onMounted } from 'vue'
import { appointmentService } from '@/services/appointmentService'
import AppointmentTable from '@/components/admin/AppointmentTable.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'
import AlertMessage from '@/components/ui/AlertMessage.vue'

// ── STATE ──────────────────────────────────────────────────────────
const appointments = ref([])
const loading      = ref(false)
const processing   = ref(false)
const errorMsg     = ref('')
const successMsg   = ref('')
const filterStatus = ref('')
const filterType   = ref('')
const filterDate   = ref('')

// ── SZŰRÉS ─────────────────────────────────────────────────────────
const filteredAppointments = computed(() => {
  return appointments.value.filter(a => {
    if (filterStatus.value && a.status !== filterStatus.value) return false
    if (filterType.value   && a.type   !== filterType.value)   return false
    if (filterDate.value   && a.appointment_date !== filterDate.value) return false
    return true
  })
})

function resetFilters() {
  filterStatus.value = ''
  filterType.value   = ''
  filterDate.value   = ''
}

// ── STÁTUSZ MÓDOSÍTÁS ──────────────────────────────────────────────

async function updateStatus(apt, status) {
  processing.value = true
  try {
    await appointmentService.updateStatus(apt.id, status)
    apt.status = status

    const statusNames = {
      megerositett: 'megerősítve',
      lemondott:    'lemondva',
    }
    successMsg.value = `Az időpont sikeresen ${statusNames[status]}!`
  } catch (err) {
    errorMsg.value = err.response?.data?.message || 'Hiba történt a státusz módosításakor.'
  } finally {
    processing.value = false
  }
}

async function handleConfirm(apt) {
  await updateStatus(apt, 'megerositett')
}

async function handleCancel(apt) {
  await updateStatus(apt, 'lemondott')
}

// ── ADATOK BETÖLTÉSE ───────────────────────────────────────────────

onMounted(async () => {
  loading.value = true
  try {
    const { data } = await appointmentService.adminGetAll()
    appointments.value = data.data ?? data
  } catch (err) {
    errorMsg.value = 'Az időpontok betöltése sikertelen.'
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <div>

    <!-- Fejléc -->
    <div class="mb-4">
      <h2 class="fw-bold mb-1">Időpontfoglalások</h2>
      <p class="text-muted mb-0">Foglalások kezelése és visszaigazolása</p>
    </div>

    <!-- Szűrők -->
    <div class="card border-0 shadow-sm mb-4">
      <div class="card-body p-3">
        <div class="row g-2">
          <div class="col-md-3">
            <select v-model="filterStatus" class="form-select form-select-sm">
              <option value="">Minden státusz</option>
              <option value="fuggoben">Függőben</option>
              <option value="megerositett">Megerősített</option>
              <option value="lemondott">Lemondott</option>
            </select>
          </div>
          <div class="col-md-3">
            <select v-model="filterType" class="form-select form-select-sm">
              <option value="">Minden típus</option>
              <option value="megtekintes">Megtekintés</option>
              <option value="konzultacio">Konzultáció</option>
              <option value="esemeny">Esemény</option>
            </select>
          </div>
          <div class="col-md-3">
            <input
                v-model="filterDate"
                type="date"
                class="form-control form-control-sm"
            />
          </div>
          <div class="col-md-3">
            <button
                class="btn btn-outline-secondary btn-sm w-100"
                @click="resetFilters"
            >
              <i class="bi bi-x-lg me-1"></i>Szűrők törlése
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Hibaüzenetek -->
    <AlertMessage :message="errorMsg"   type="danger"  @dismiss="errorMsg = ''" />
    <AlertMessage :message="successMsg" type="success" @dismiss="successMsg = ''" />

    <!-- Loading -->
    <LoadingSpinner v-if="loading" text="Időpontok betöltése..." />

    <!-- Táblázat komponens -->
    <AppointmentTable
        v-else
        :appointments="filteredAppointments"
        @confirm="handleConfirm"
        @cancel="handleCancel"
    />

  </div>
</template>

<style scoped>

</style>