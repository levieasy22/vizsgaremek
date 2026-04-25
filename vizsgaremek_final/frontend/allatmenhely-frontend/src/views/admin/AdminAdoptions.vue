<script>
import { Modal } from 'bootstrap'
import { adoptionService } from '@/services/adoptionService'
import AdoptionTable from '@/components/admin/AdoptionTable.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'
import AlertMessage from '@/components/ui/AlertMessage.vue'

export default {
  name: 'AdminAdoptions',
  components: {
    AdoptionTable,
    LoadingSpinner,
    AlertMessage,
  },
  data() {
    return {
      requests: [],
      loading: false,
      processing: false,
      errorMsg: '',
      successMsg: '',
      selectedReq: null,
      filterStatus: '',
      filterType: '',
    }
  },
  computed: {
    filteredRequests() {
      return this.requests.filter(r => {
        if (this.filterStatus && r.status !== this.filterStatus) return false
        if (this.filterType && r.animal?.type !== this.filterType) return false
        return true
      })
    },
  },
  mounted() {
    this.fetchRequests()
  },
  methods: {
    async fetchRequests() {
      this.loading = true
      try {
        const { data } = await adoptionService.adminGetAll()
        this.requests = data.data ?? data
      } catch (err) {
        this.errorMsg = 'A kérelmek betöltése sikertelen.'
      } finally {
        this.loading = false
      }
    },

    openMotivationModal(req) {
      this.selectedReq = req
      new Modal(document.getElementById('motivationModal')).show()
    },

    async updateStatus(req, status) {
      this.processing = true
      try {
        await adoptionService.updateStatus(req.id, status)
        req.status = status

        const statusNames = {
          elfogadva: 'elfogadva',
          elutasitva: 'elutasítva',
        }
        this.successMsg = `A kérelem sikeresen ${statusNames[status]}!`
      } catch (err) {
        this.errorMsg = err.response?.data?.message || 'Hiba történt a státusz módosításakor.'
      } finally {
        this.processing = false
      }
    },

    async handleAccept(req) {
      await this.updateStatus(req, 'elfogadva')
    },

    async handleReject(req) {
      await this.updateStatus(req, 'elutasitva')
    },

    async handleAcceptFromModal() {
      if (!this.selectedReq) return
      await this.updateStatus(this.selectedReq, 'elfogadva')
      Modal.getInstance(document.getElementById('motivationModal'))?.hide()
    },

    async handleRejectFromModal() {
      if (!this.selectedReq) return
      await this.updateStatus(this.selectedReq, 'elutasitva')
      Modal.getInstance(document.getElementById('motivationModal'))?.hide()
    },
  },
}
</script>

<template>
  <div>

    <!-- Fejléc -->
    <div class="mb-4">
      <h2 class="fw-bold mb-1">Örökbefogadások</h2>
      <p class="text-muted mb-0">Kérelmek kezelése és státuszok módosítása</p>
    </div>

    <!-- Szűrők -->
    <div class="card border-0 shadow-sm mb-4">
      <div class="card-body p-3">
        <div class="row g-2">
          <div class="col-md-4">
            <select v-model="filterStatus" class="form-select form-select-sm">
              <option value="">Minden státusz</option>
              <option value="fuggoben">Függőben</option>
              <option value="elfogadva">Elfogadva</option>
              <option value="elutasitva">Elutasítva</option>
            </select>
          </div>
          <div class="col-md-4">
            <select v-model="filterType" class="form-select form-select-sm">
              <option value="">Minden állatfajta</option>
              <option value="kutya">Kutya</option>
              <option value="macska">Macska</option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <!-- Hibaüzenet -->
    <AlertMessage :message="errorMsg"   type="danger"  @dismiss="errorMsg = ''" />
    <AlertMessage :message="successMsg" type="success" @dismiss="successMsg = ''" />

    <!-- Loading -->
    <LoadingSpinner v-if="loading" text="Kérelmek betöltése..." />

    <!-- Táblázat komponens -->
    <AdoptionTable
        v-else
        :requests="filteredRequests"
        @view="openMotivationModal"
        @accept="handleAccept"
        @reject="handleReject"
    />

    <!-- Motiváció megtekintő modal -->
    <div class="modal fade" id="motivationModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">

          <div class="modal-header border-0">
            <h5 class="modal-title fw-bold">
              {{ selectedReq?.last_name }} {{ selectedReq?.first_name }}
              – Motiváció
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>

          <div class="modal-body">
            <!-- Motiváció szöveg -->
            <p style="line-height: 1.7" class="mb-4">
              {{ selectedReq?.motivation }}
            </p>

            <hr>

            <!-- Elérhetőségek -->
            <div class="small text-muted">
              <div class="mb-1">
                <i class="bi bi-envelope me-2"></i>
                <strong>Email:</strong> {{ selectedReq?.email }}
              </div>
              <div class="mb-1">
                <i class="bi bi-telephone me-2"></i>
                <strong>Telefon:</strong> {{ selectedReq?.phone }}
              </div>
              <div class="mb-1">
                <i class="bi bi-geo-alt me-2"></i>
                <strong>Lakcím:</strong> {{ selectedReq?.address }}
              </div>
              <div class="mb-1">
                <i class="bi bi-tree me-2"></i>
                <strong>Van kert:</strong>
                {{ selectedReq?.has_garden ? 'Igen' : 'Nem' }}
              </div>
              <div>
                <i class="bi bi-emoji-smile me-2"></i>
                <strong>Van más állat:</strong>
                {{ selectedReq?.has_other_pets ? 'Igen' : 'Nem' }}
              </div>
            </div>
          </div>

          <div class="modal-footer border-0">
            <!-- Gyors elfogadás / elutasítás a modalból is -->
            <template v-if="selectedReq?.status === 'fuggoben'">
              <button
                  class="btn btn-success btn-sm fw-bold"
                  @click="handleAcceptFromModal"
                  :disabled="processing"
              >
                <span v-if="processing" class="spinner-border spinner-border-sm me-1"></span>
                <i class="bi bi-check-lg me-1"></i>Elfogadás
              </button>
              <button
                  class="btn btn-danger btn-sm fw-bold"
                  @click="handleRejectFromModal"
                  :disabled="processing"
              >
                <i class="bi bi-x-lg me-1"></i>Elutasítás
              </button>
            </template>
            <button class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
              Bezárás
            </button>
          </div>

        </div>
      </div>
    </div>

  </div>
</template>

<style scoped>

</style>