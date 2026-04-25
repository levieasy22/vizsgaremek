<script>
import { Modal } from 'bootstrap'
import { useAuthStore } from '@/stores/auth'
import { adminService } from '@/services/adminService'
import { contactService } from '@/services/contactService'
import ConfirmModal from '@/components/ui/ConfirmModal.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'
import AlertMessage from '@/components/ui/AlertMessage.vue'

export default {
  name: 'AdminAccount',
  components: {
    ConfirmModal,
    LoadingSpinner,
    AlertMessage,
  },
  data() {
    return {
      auth: useAuthStore(),
      activeTab: 'profile',

      // Profil tab
      profileForm: {
        name: useAuthStore().user?.name || '',
        phone: useAuthStore().user?.phone || '',
      },
      savingProfile: false,
      profileSuccess: '',
      profileError: '',

      // Jelszó tab
      passwordForm: {
        current_password: '',
        password: '',
        password_confirmation: '',
      },
      savingPassword: false,
      passwordSuccess: '',
      passwordError: '',
      passwordErrors: {},

      // Felhasználók tab
      users: [],
      loadingUsers: false,
      userErrorMsg: '',
      userSuccessMsg: '',
      deletingUser: null,
      deletingUserLoading: false,

      // Üzenetek tab
      messages: [],
      loadingMessages: false,
      messageErrorMsg: '',
    }
  },
  computed: {
    unreadCount() {
      return this.messages.filter(m => !m.is_read).length
    },
  },
  mounted() {
    this.fetchMessages()
  },
  methods: {
    switchTab(tab) {
      this.activeTab = tab
      if (tab === 'users' && this.users.length === 0) this.fetchUsers()
      if (tab === 'messages' && this.messages.length === 0) this.fetchMessages()
    },

    async handleProfileUpdate() {
      this.savingProfile = true
      this.profileSuccess = ''
      this.profileError = ''
      try {
        await this.auth.updateProfile(this.profileForm)
        this.profileSuccess = 'Adatok sikeresen mentve!'
      } catch (err) {
        this.profileError = err.response?.data?.message || 'Hiba történt a mentés során.'
      } finally {
        this.savingProfile = false
      }
    },

    async handlePasswordChange() {
      this.savingPassword = true
      this.passwordSuccess = ''
      this.passwordError = ''
      this.passwordErrors = {}
      try {
        await this.auth.changePassword(this.passwordForm)
        this.passwordSuccess = 'Jelszó sikeresen módosítva!'
        this.passwordForm = {
          current_password: '',
          password: '',
          password_confirmation: '',
        }
      } catch (err) {
        if (err.response?.status === 422) {
          this.passwordErrors = err.response.data.errors || {}
        }
        this.passwordError = err.response?.data?.message || 'Hiba történt a jelszó módosításakor.'
      } finally {
        this.savingPassword = false
      }
    },

    async fetchUsers() {
      this.loadingUsers = true
      try {
        const { data } = await adminService.getUsers()
        this.users = data.data ?? data
      } catch (err) {
        this.userErrorMsg = 'A felhasználók betöltése sikertelen.'
      } finally {
        this.loadingUsers = false
      }
    },

    confirmDeleteUser(user) {
      this.deletingUser = user
      new Modal(document.getElementById('deleteUserModal')).show()
    },

    async handleDeleteUser() {
      if (!this.deletingUser) return
      this.deletingUserLoading = true
      try {
        await adminService.deleteUser(this.deletingUser.id)
        this.users = this.users.filter(u => u.id !== this.deletingUser.id)
        this.userSuccessMsg = `${this.deletingUser.name} sikeresen törölve!`
        Modal.getInstance(document.getElementById('deleteUserModal'))?.hide()
      } catch (err) {
        this.userErrorMsg = err.response?.data?.message || 'Hiba történt a törlés során.'
      } finally {
        this.deletingUserLoading = false
        this.deletingUser = null
      }
    },

    async fetchMessages() {
      this.loadingMessages = true
      try {
        const { data } = await contactService.adminGetAll()
        this.messages = data.data ?? data
      } catch (err) {
        this.messageErrorMsg = 'Az üzenetek betöltése sikertelen.'
      } finally {
        this.loadingMessages = false
      }
    },

    async handleMarkRead(msg) {
      try {
        await contactService.markRead(msg.id)
        msg.is_read = true
      } catch (err) {
        this.messageErrorMsg = 'Az olvasottnak jelölés sikertelen.'
      }
    },

    async handleDeleteMessage(msg) {
      try {
        await contactService.delete(msg.id)
        this.messages = this.messages.filter(m => m.id !== msg.id)
      } catch (err) {
        this.messageErrorMsg = 'Az üzenet törlése sikertelen.'
      }
    },

    formatDate(dateStr) {
      if (!dateStr) return '–'
      return new Date(dateStr).toLocaleDateString('hu-HU')
    },
  },
}
</script>

<template>
  <div>

    <!-- Fejléc -->
    <div class="mb-4">
      <h2 class="fw-bold mb-1">Fiók</h2>
      <p class="text-muted mb-0">Saját adatok, felhasználók és üzenetek kezelése</p>
    </div>

    <!-- Bootstrap Tabs -->
    <ul class="nav nav-tabs mb-4 border-bottom">
      <li class="nav-item">
        <button
            class="nav-link"
            :class="{ active: activeTab === 'profile' }"
            @click="activeTab = 'profile'"
        >
          <i class="bi bi-person me-2"></i>Saját fiók
        </button>
      </li>
      <li class="nav-item">
        <button
            class="nav-link"
            :class="{ active: activeTab === 'users' }"
            @click="switchTab('users')"
        >
          <i class="bi bi-people me-2"></i>Felhasználók
        </button>
      </li>
      <li class="nav-item">
        <button
            class="nav-link"
            :class="{ active: activeTab === 'messages' }"
            @click="switchTab('messages')"
        >
          <i class="bi bi-envelope me-2"></i>Üzenetek
          <span
              v-if="unreadCount > 0"
              class="badge bg-danger ms-1"
          >
            {{ unreadCount }}
          </span>
        </button>
      </li>
    </ul>

    <!-- TAB 1: SAJÁT FIÓK-->
    <div v-if="activeTab === 'profile'">
      <div class="row g-4">

        <!-- Profil szerkesztése -->
        <div class="col-md-6">
          <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
              <h5 class="fw-bold mb-4">
                <i class="bi bi-person-circle me-2 text-secondary"></i>
                Személyes adatok
              </h5>

              <AlertMessage
                  :message="profileSuccess"
                  type="success"
                  @dismiss="profileSuccess = ''"
              />
              <AlertMessage
                  :message="profileError"
                  type="danger"
                  @dismiss="profileError = ''"
              />

              <form @submit.prevent="handleProfileUpdate">

                <div class="mb-3">
                  <label class="form-label fw-semibold">Teljes név</label>
                  <input
                      v-model="profileForm.name"
                      type="text"
                      class="form-control"
                      required
                  />
                </div>

                <div class="mb-3">
                  <label class="form-label fw-semibold">Email cím</label>
                  <input
                      :value="auth.userEmail"
                      type="email"
                      class="form-control bg-light"
                      disabled
                  />
                  <div class="form-text">Az email cím nem módosítható.</div>
                </div>

                <div class="mb-4">
                  <label class="form-label fw-semibold">Telefonszám</label>
                  <input
                      v-model="profileForm.phone"
                      type="tel"
                      class="form-control"
                      placeholder="+36 70 123 4567"
                  />
                </div>

                <button
                    type="submit"
                    class="btn btn-primary fw-bold"
                    :disabled="savingProfile"
                >
                  <span v-if="savingProfile"
                        class="spinner-border spinner-border-sm me-1">
                  </span>
                  <i class="bi bi-save me-1"></i>Adatok mentése
                </button>

              </form>
            </div>
          </div>
        </div>

        <!-- Jelszó módosítása -->
        <div class="col-md-6">
          <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
              <h5 class="fw-bold mb-4">
                <i class="bi bi-lock me-2 text-warning"></i>
                Jelszó módosítása
              </h5>

              <AlertMessage
                  :message="passwordSuccess"
                  type="success"
                  @dismiss="passwordSuccess = ''"
              />
              <AlertMessage
                  :message="passwordError"
                  type="danger"
                  @dismiss="passwordError = ''"
              />

              <form @submit.prevent="handlePasswordChange">

                <div class="mb-3">
                  <label class="form-label fw-semibold">Jelenlegi jelszó</label>
                  <input
                      v-model="passwordForm.current_password"
                      type="password"
                      class="form-control"
                      :class="{ 'is-invalid': passwordErrors.current_password }"
                      required
                  />
                  <div class="invalid-feedback">
                    {{ passwordErrors.current_password?.[0] }}
                  </div>
                </div>

                <div class="mb-3">
                  <label class="form-label fw-semibold">Új jelszó</label>
                  <input
                      v-model="passwordForm.password"
                      type="password"
                      class="form-control"
                      :class="{ 'is-invalid': passwordErrors.password }"
                      placeholder="Minimum 8 karakter"
                      required
                  />
                  <div class="invalid-feedback">
                    {{ passwordErrors.password?.[0] }}
                  </div>
                </div>

                <div class="mb-4">
                  <label class="form-label fw-semibold">
                    Új jelszó megerősítése
                  </label>
                  <input
                      v-model="passwordForm.password_confirmation"
                      type="password"
                      class="form-control"
                      required
                  />
                </div>

                <button
                    type="submit"
                    class="btn btn-warning fw-bold"
                    :disabled="savingPassword"
                >
                  <span v-if="savingPassword"
                        class="spinner-border spinner-border-sm me-1">
                  </span>
                  <i class="bi bi-key me-1"></i>Jelszó módosítása
                </button>

              </form>
            </div>
          </div>
        </div>

      </div>
    </div>

    <!-- TAB 2: FELHASZNÁLÓK-->
    <div v-if="activeTab === 'users'">

      <AlertMessage :message="userErrorMsg"   type="danger"  @dismiss="userErrorMsg = ''" />
      <AlertMessage :message="userSuccessMsg" type="success" @dismiss="userSuccessMsg = ''" />

      <LoadingSpinner v-if="loadingUsers" text="Felhasználók betöltése..." />

      <div v-else class="card border-0 shadow-sm">
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
              <thead class="bg-light">
              <tr>
                <th class="px-4 py-3">Felhasználó</th>
                <th>Telefon</th>
                <th>Kérelmek</th>
                <th>Foglalások</th>
                <th>Regisztrált</th>
                <th class="text-end px-4">Műveletek</th>
              </tr>
              </thead>
              <tbody>
              <tr v-for="user in users" :key="user.id">

                <td class="px-4">
                  <div class="fw-semibold small">{{ user.name }}</div>
                  <div class="text-muted" style="font-size: 11px;">
                    {{ user.email }}
                  </div>
                </td>

                <td class="small text-muted">
                  {{ user.phone ?? '–' }}
                </td>

                <td class="small">
                  {{ user.adoption_requests_count ?? 0 }}
                </td>

                <td class="small">
                  {{ user.appointments_count ?? 0 }}
                </td>

                <td class="small text-muted">
                  {{ formatDate(user.created_at) }}
                </td>

                <td class="text-end px-4">
                  <button
                      class="btn btn-outline-danger btn-sm"
                      @click="confirmDeleteUser(user)"
                      title="Felhasználó törlése"
                  >
                    <i class="bi bi-trash"></i>
                  </button>
                </td>

              </tr>
              <tr v-if="users.length === 0">
                <td colspan="6" class="text-center text-muted py-5">
                  Nincs regisztrált felhasználó.
                </td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Felhasználó törlés megerősítő modal -->
      <ConfirmModal
          modal-id="deleteUserModal"
          title="Felhasználó törlése"
          :message="`Biztosan törölni szeretnéd ${deletingUser?.name} fiókját?`"
          confirm-text="Igen, törlöm"
          confirm-variant="danger"
          :loading="deletingUserLoading"
          @confirm="handleDeleteUser"
      />

    </div>

    <!-- TAB 3: ÜZENETEK-->
    <div v-if="activeTab === 'messages'">

      <AlertMessage
          :message="messageErrorMsg"
          type="danger"
          @dismiss="messageErrorMsg = ''"
      />

      <LoadingSpinner v-if="loadingMessages" text="Üzenetek betöltése..." />

      <div v-else class="d-flex flex-column gap-3">

        <div
            v-for="msg in messages"
            :key="msg.id"
            class="card border-0 shadow-sm"
            :class="!msg.is_read ? 'border-start border-primary border-3' : ''"
        >
          <div class="card-body p-4">

            <!-- Fejléc -->
            <div class="d-flex justify-content-between align-items-start mb-2 flex-wrap gap-2">
              <div>
                <span class="fw-bold">{{ msg.name }}</span>
                <span class="text-muted small ms-2">{{ msg.email }}</span>
                <span v-if="!msg.is_read" class="badge bg-primary ms-2 small">
                  Új
                </span>
              </div>
              <div class="d-flex gap-2 align-items-center">
                <span class="text-muted small">{{ formatDate(msg.created_at) }}</span>
                <!-- Olvasottnak jelöl -->
                <button
                    v-if="!msg.is_read"
                    class="btn btn-outline-success btn-sm"
                    @click="handleMarkRead(msg)"
                    title="Olvasottnak jelöl"
                >
                  <i class="bi bi-check-lg"></i>
                </button>
                <!-- Törlés -->
                <button
                    class="btn btn-outline-danger btn-sm"
                    @click="handleDeleteMessage(msg)"
                    title="Törlés"
                >
                  <i class="bi bi-trash"></i>
                </button>
              </div>
            </div>

            <!-- Tárgy -->
            <div class="fw-semibold mb-1">{{ msg.subject }}</div>

            <!-- Üzenet szöveg -->
            <p class="text-muted small mb-0" style="line-height: 1.6">
              {{ msg.message }}
            </p>

          </div>
        </div>

        <!-- Üres állapot -->
        <div v-if="messages.length === 0" class="text-center text-muted py-5">
          <div class="display-4 mb-2">📭</div>
          <p>Nincs megjeleníthető üzenet.</p>
        </div>

      </div>
    </div>

  </div>
</template>

<style scoped>

</style>