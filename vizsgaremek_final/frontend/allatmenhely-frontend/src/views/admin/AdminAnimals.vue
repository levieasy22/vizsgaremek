<script setup>
import { ref, computed, onMounted } from 'vue'
import { Modal } from 'bootstrap'
import { animalService } from '@/services/animalService'
import AnimalTable from '@/components/admin/AnimalTable.vue'
import AnimalFormModal from '@/components/admin/AnimalFormModal.vue'
import ConfirmModal from '@/components/ui/ConfirmModal.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'
import AlertMessage from '@/components/ui/AlertMessage.vue'
import axios from "@/services/api.js";
import {createRouter} from "vue-router";

// ── STATE ──────────────────────────────────────────────────────────
const animals       = ref([])
const loading       = ref(false)
const saving        = ref(false)
const deleting      = ref(false)
const editingAnimal = ref(null)   // null = létrehozás, object = szerkesztés
const deletingAnimal = ref(null)
const errorMsg      = ref('')
const successMsg    = ref('')
const modalErrorMsg = ref('')
const formErrors    = ref({})
const filterType    = ref('')
const filterStatus  = ref('')
const searchQuery   = ref('')

// ── SZŰRÉS ─────────────────────────────────────────────────────────
const filteredAnimals = computed(() => {
  return animals.value.filter(a => {
    if (filterType.value   && a.type   !== filterType.value)   return false
    if (filterStatus.value && a.status !== filterStatus.value) return false
    if (searchQuery.value) {
      const q = searchQuery.value.toLowerCase()
      if (!a.name.toLowerCase().includes(q)) return false
    }
    return true
  })
})

function resetFilters() {
  filterType.value   = ''
  filterStatus.value = ''
  searchQuery.value  = ''
}

// ── MODAL MŰVELETEK ────────────────────────────────────────────────

function openCreateModal() {
  editingAnimal.value = null
  modalErrorMsg.value = ''
  formErrors.value    = {}
  new Modal(document.getElementById('animalFormModal')).show()
}

function openEditModal(animal) {
  // Betöltjük a képeket is szerkesztéshez
  loadAnimalImages(animal)
  modalErrorMsg.value = ''
  formErrors.value    = {}
  new Modal(document.getElementById('animalFormModal')).show()
}

async function loadAnimalImages(animal) {
  // Részletes lekérés a képekkel együtt
  try {
    const { data } = await animalService.getById(animal.id)
    editingAnimal.value = data
  } catch {
    editingAnimal.value = animal
  }
}

function openDeleteModal(animal) {
  deletingAnimal.value = animal
  new Modal(document.getElementById('deleteAnimalModal')).show()
}

// ── MENTÉS (létrehozás vagy szerkesztés) ──────────────────────────

async function handleSave({ formData, file }) {
  saving.value        = true
  modalErrorMsg.value = ''
  formErrors.value    = {}

  try {
    if (editingAnimal.value) {
      // Szerkesztés
      await animalService.update(editingAnimal.value.id, formData)

      // Ha van új kép, feltöltjük
      if (file) {
        const fd = new FormData()
        fd.append('image', file)
        await animalService.uploadImage(editingAnimal.value.id, fd)
      }

      successMsg.value = `${formData.name} adatai sikeresen frissítve!`
    } else {
      // Létrehozás
      await animalService.create(formData)
      successMsg.value = `${formData.name} sikeresen hozzáadva!`
    }

    // Modal bezárása és lista frissítése
    Modal.getInstance(document.getElementById('animalFormModal'))?.hide()
    await fetchAnimals()

  } catch (err) {
    if (err.response?.status === 422) {
      formErrors.value = err.response.data.errors || {}
    }
    modalErrorMsg.value = err.response?.data?.message || 'Hiba történt a mentés során.'
  } finally {
    saving.value = false
  }
}

// ── TÖRLÉS ─────────────────────────────────────────────────────────

async function handleDelete() {
  if (!deletingAnimal.value) return
  deleting.value = true

  try {
    await animalService.delete(deletingAnimal.value.id)
    successMsg.value = `${deletingAnimal.value.name} sikeresen törölve!`
    Modal.getInstance(document.getElementById('deleteAnimalModal'))?.hide()
    await fetchAnimals()
  } catch (err) {
    errorMsg.value = err.response?.data?.message || 'Hiba történt a törlés során.'
  } finally {
    deleting.value       = false
    deletingAnimal.value = null
  }
}

// ── KÉP TÖRLÉS ─────────────────────────────────────────────────────

async function handleDeleteImage(animalId, imageId) {
  try {
    await animalService.deleteImage(animalId, imageId)
    // Frissítjük az editingAnimal képlistáját
    if (editingAnimal.value?.images) {
      editingAnimal.value.images = editingAnimal.value.images.filter(
          img => img.id !== imageId
      )
    }
  } catch (err) {
    errorMsg.value = 'A kép törlése sikertelen.'
  }
}

// ── ADATOK BETÖLTÉSE ───────────────────────────────────────────────

async function fetchAnimals() {
  loading.value = true
  try {
    const { data } = await animalService.adminGetAll()
    animals.value  = data
  } catch (err) {
    errorMsg.value = 'Az állatok betöltése sikertelen.'
  } finally {
    loading.value = false
  }
}

onMounted(fetchAnimals)
</script>

<template>
  <div>

    <!-- Fejléc -->
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h2 class="fw-bold mb-1">Állatok</h2>
        <p class="text-muted mb-0">{{ animals.length }} állat az adatbázisban</p>
      </div>
      <button class="btn btn-primary" @click="openCreateModal">
        <i class="bi bi-plus-lg me-2"></i>Állat hozzáadása
      </button>
    </div>

    <!-- Szűrők -->
    <div class="card border-0 shadow-sm mb-4">
      <div class="card-body p-3">
        <div class="row g-2">
          <div class="col-md-3">
            <select v-model="filterType" class="form-select form-select-sm">
              <option value="">Minden típus</option>
              <option value="kutya">Kutya</option>
              <option value="macska">Macska</option>
            </select>
          </div>
          <div class="col-md-3">
            <select v-model="filterStatus" class="form-select form-select-sm">
              <option value="">Minden státusz</option>
              <option value="elerheto">Elérhető</option>
              <option value="foglalas_alatt">Foglalás alatt</option>
              <option value="orokbefogadva">Örökbefogadva</option>
            </select>
          </div>
          <div class="col-md-4">
            <input
                v-model="searchQuery"
                type="text"
                class="form-control form-control-sm"
                placeholder="Keresés névre..."
            />
          </div>
          <div class="col-md-2">
            <button
                class="btn btn-outline-secondary btn-sm w-100"
                @click="resetFilters"
            >
              <i class="bi bi-x-lg me-1"></i>Törlés
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Hibaüzenet -->
    <AlertMessage :message="errorMsg" type="danger" @dismiss="errorMsg = ''" />
    <AlertMessage :message="successMsg" type="success" @dismiss="successMsg = ''" />

    <!-- Loading -->
    <LoadingSpinner v-if="loading" text="Állatok betöltése..." />

    <!-- Táblázat komponens -->
    <AnimalTable
        v-else
        :animals="filteredAnimals"
        @edit="openEditModal"
        @delete="openDeleteModal"
    />

    <!-- Hozzáadás / Szerkesztés Modal -->
    <AnimalFormModal
        :animal="editingAnimal"
        :saving="saving"
        :errors="formErrors"
        :error-msg="modalErrorMsg"
        @save="handleSave"
        @delete-image="handleDeleteImage"
    />

    <!-- Törlés megerősítő modal -->
    <ConfirmModal
        modal-id="deleteAnimalModal"
        title="Állat törlése"
        :message="`Biztosan törölni szeretnéd ${deletingAnimal?.name} adatait? Ez a művelet nem vonható vissza!`"
        confirm-text="Igen, törlöm"
        confirm-variant="danger"
        :loading="deleting"
        @confirm="handleDelete"
    />

  </div>
</template>

<style scoped>

</style>