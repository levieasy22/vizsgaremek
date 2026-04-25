<script>
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { useAdminStore } from '@/stores/admin'

export default {
  name: 'AdminSidebar',
  data() {
    return {
      auth: useAuthStore(),
      admin: useAdminStore(),
      router: useRouter(),
    }
  },
  computed: {
    unreadMessages() {
      return this.admin.stats?.messages?.unread ?? 0
    },
    pendingAdoptions() {
      return this.admin.stats?.adoption_requests?.pending ?? 0
    },
  },
  mounted() {
    this.admin.fetchStats()
  },
  methods: {
    async handleLogout() {
      await this.auth.logout()
      this.router.push({ name: 'Login' })
    },
  },
  emits: ['close'],
}
</script>

<template>
  <nav
      class="d-flex flex-column p-3 text-white"
      style="width: 260px; min-height: 100vh; background-color: #303030; flex-shrink: 0;">

    <!-- Logo és admin neve -->
    <div class="text-center py-3 mb-2">
      <div class="fw-bold fs-5">Admin Panel</div>
      <div class="text-white-50 small">{{ auth.user?.name }}</div>
    </div>

    <hr class="border-secondary">

    <!-- Navigációs elemek -->
    <ul class="nav nav-pills flex-column gap-1 flex-grow-1">

      <li class="nav-item">
        <RouterLink
            :to="{ name: 'AdminDashboard' }"
            class="nav-link text-white d-flex align-items-center gap-2"
            active-class="active"
            exact-active-class="active"
        >
          <i class="bi bi-speedometer2 fs-5"></i>
          <span>Áttekintés</span>
          <!-- Olvasatlan üzenet badge -->
          <span
              v-if="unreadMessages > 0"
              class="badge bg-danger ms-auto"
          >
            {{ unreadMessages }}
          </span>
        </RouterLink>
      </li>

      <li class="nav-item">
        <RouterLink
            :to="{ name: 'AdminAnimals' }"
            class="nav-link text-white d-flex align-items-center gap-2"
            active-class="active"
        >
          <i class="bi bi-grid-3x3-gap fs-5"></i>
          <span>Állatok</span>
        </RouterLink>
      </li>

      <li class="nav-item">
        <RouterLink
            :to="{ name: 'AdminAdoptions' }"
            class="nav-link text-white d-flex align-items-center gap-2"
            active-class="active"
        >
          <i class="bi bi-heart fs-5"></i>
          <span>Örökbefogadások</span>
          <!-- Függőben lévő kérelmek badge -->
          <span
              v-if="pendingAdoptions > 0"
              class="badge bg-warning text-dark ms-auto"
          >
            {{ pendingAdoptions }}
          </span>
        </RouterLink>
      </li>

      <li class="nav-item">
        <RouterLink
            :to="{ name: 'AdminAppointments' }"
            class="nav-link text-white d-flex align-items-center gap-2"
            active-class="active"
        >
          <i class="bi bi-calendar3 fs-5"></i>
          <span>Időpontfoglalások</span>
        </RouterLink>
      </li>

      <li class="nav-item">
        <RouterLink
            :to="{ name: 'AdminAccount' }"
            class="nav-link text-white d-flex align-items-center gap-2"
            active-class="active"
        >
          <i class="bi bi-people fs-5"></i>
          <span>Fiók</span>
        </RouterLink>
      </li>

    </ul>

    <hr class="border-secondary">

    <!-- Lent: Főoldalra + Kijelentkezés -->
    <div class="d-flex flex-column gap-2">
      <RouterLink to="/" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-house me-1"></i>Vissza a főoldalra
      </RouterLink>
      <button class="btn btn-outline-danger btn-sm" @click="handleLogout">
        <i class="bi bi-box-arrow-right me-1"></i>Kijelentkezés
      </button>
    </div>

    <!-- Bezárás gomb – csak mobilon -->
    <button
        class="btn btn-outline-secondary btn-sm d-lg-none mb-2"
        @click="$emit('close')"
    >
      <i class="bi bi-x-lg me-1"></i>Bezárás
    </button>

  </nav>
</template>

<style scoped>
.nav-link {
  border-radius: 8px;
  padding: 10px 14px;
  transition: background-color 0.2s ease;
  color: #a0a0b0 !important;
}

.nav-link:hover {
  background-color: rgba(255, 255, 255, 0.08);
  color: #ffffff !important;
}

.nav-link.active {
  background-color: #F5E9DC !important;
  color: #000000 !important;
}
</style>