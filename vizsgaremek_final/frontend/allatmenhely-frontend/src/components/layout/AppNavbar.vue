<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'

const auth   = useAuthStore()
const router = useRouter()

const dropdownOpen = ref(false)

function toggleDropdown() {
  dropdownOpen.value = !dropdownOpen.value
}

function closeDropdown() {
  dropdownOpen.value = false
}

// Close dropdown when clicking anywhere outside
function handleClickOutside(e) {
  if (!e.target.closest('.dropdown')) {
    dropdownOpen.value = false
  }
}

// Close dropdown on route change
router.afterEach(() => {
  dropdownOpen.value = false
})

onMounted(() => {
  document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside)
})

async function handleLogout() {
  await auth.logout()
  router.push({ name: 'Home' })
}
</script>

<template>
  <nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background-color: #FFFFFF;">
    <div class="container">

      <!-- Brand / Logo -->
      <RouterLink class="navbar-brand d-flex align-items-center gap-2" to="/">
        <i class="bi bi-heart-fill text-warning"></i>
        Mancs Menhely
      </RouterLink>

      <!-- Hamburger gomb (mobilon) -->
      <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarMain"
          aria-controls="navbarMain"
          aria-expanded="false"
      >
        <span class="navbar-toggler-icon"></span>
      </button>

      <!-- Nav linkek -->
      <div class="collapse navbar-collapse" id="navbarMain">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">

          <li class="nav-item">
            <RouterLink class="nav-link" to="/">Kezdőlap</RouterLink>
          </li>

          <!-- Örökbefogadás dropdown -->
          <li class="nav-item dropdown" ref="dropdownItem">
            <a
                class="nav-link dropdown-toggle"
                href="#"
                role="button"
                @click.prevent="toggleDropdown"
            >
              Örökbefogadás
            </a>

            <ul class="dropdown-menu" :class="{ show: dropdownOpen }">
              <li>
                <RouterLink
                    class="dropdown-item"
                    to="/orokbefogadas?type=kutya"
                    @click="closeDropdown"
                >Kutyák
                </RouterLink>
              </li>
              <li>
                <RouterLink
                    class="dropdown-item"
                    to="/orokbefogadas?type=macska"
                    @click="closeDropdown"
                >Macskák
                </RouterLink>
              </li>
            </ul>
          </li>

          <li class="nav-item">
            <RouterLink class="nav-link" to="/rolunk">Rólunk</RouterLink>
          </li>

          <li class="nav-item">
            <RouterLink class="nav-link" to="/kapcsolat">Kapcsolat</RouterLink>
          </li>

          <!-- Admin link – csak admin role esetén jelenik meg -->
          <li v-if="auth.isAdmin" class="nav-item text-light">
            <RouterLink class="nav-link text-warning fw-bold" to="/admin">
              <i class="bi bi-shield-lock me-1"></i>Admin
            </RouterLink>
          </li>

        </ul>

        <!-- Jobb oldali rész -->
        <div class="d-flex align-items-center gap-2">

          <!-- Bejelentkezett állapot -->
          <template v-if="auth.isLoggedIn">
            <span class="navbar-text text-black small me-1">
              <i class="bi bi-person-circle me-1"></i>{{ auth.user.name }}
            </span>
            <button
                class="btn btn-outline-dark btn-sm"
                @click="handleLogout"><i class="bi bi-box-arrow-right me-1"></i>Kijelentkezés
            </button>
          </template>

          <!-- Kijelentkezett állapot -->
          <template v-else>
            <RouterLink class="btn btn-outline-dark btn-sm" to="/bejelentkezes">Bejelentkezés</RouterLink>
            <RouterLink class="btn btn-warning btn-sm fw-bold" to="/regisztracio">Regisztráció</RouterLink>
          </template>

        </div>
      </div>

    </div>
  </nav>
</template>