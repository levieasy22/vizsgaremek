<script>
import { RouterLink } from 'vue-router'

export default {
  name: "FooterLayout",
  components: {
    RouterLink
  }
}
</script>

<template>
<footer class="bg-dark text-light mt-5 pt-5 pb-3">
  <div class="container">
    <div class="row mb-4">
      <!-- Logo and About Section -->
      <div class="col-md-4 mb-4 mb-md-0">
        <div class="mb-3">
          <img src="@/imgs/mancs_allatmenhely_logo.png" alt="Logo" style="max-height: 80px; width: auto;">
        </div>
        <p class="text-muted">Az állati menhely missziója az, hogy szeretetre méltó otthont találjunk minden rászoruló állat számára.</p>
      </div>

      <!-- Quick Links -->
      <div class="col-md-2 mb-4 mb-md-0">
        <h5 class="mb-3">Menü</h5>
        <ul class="list-unstyled">
          <li class="mb-2">
            <RouterLink to="/" class="text-decoration-none text-light">Kezdőlap</RouterLink>
          </li>
          <li class="mb-2">
            <RouterLink to="/adoption" class="text-decoration-none text-light">Örökbefogadás</RouterLink>
          </li>
          <li class="mb-2">
            <RouterLink to="/about" class="text-decoration-none text-light">Rólunk</RouterLink>
          </li>
          <li class="mb-2">
            <RouterLink to="/contact" class="text-decoration-none text-light">Kapcsolat</RouterLink>
          </li>
          <li class="nav-item">
            <RouterLink class="nav-link" to="/auth/login">Bejelentkezés</RouterLink>
          </li>
        </ul>
      </div>

      <!-- Policies -->
      <div class="col-md-2 mb-4 mb-md-0">
        <h5 class="mb-3">Irányelvek</h5>
        <ul class="list-unstyled">
          <li class="mb-2">
            <RouterLink to="/policies/privacy" class="text-decoration-none text-light">Adatvédelmi Irányelvek</RouterLink>
          </li>
          <li class="mb-2">
            <RouterLink to="/policies/aszf" class="text-decoration-none text-light">Általános Szerződési Feltételek</RouterLink>
          </li>
          <li class="mb-2">
            <RouterLink to="/policies/cookie" class="text-decoration-none text-light">Cookie</RouterLink>
          </li>
          <li class="mb-2">
            <RouterLink to="/policies/impressum" class="text-decoration-none text-light">Impresszum</RouterLink>
          </li>
        </ul>
      </div>

      <!-- Contact Details -->
      <div class="col-md-4 mb-4 mb-md-0">
        <h5 class="mb-3">Kapcsolatfelvétel</h5>
        <ul class="list-unstyled text-muted">
          <li class="mb-2">
            <strong class="text-light">Cím:</strong><br>
            <p class="text-decoration-none text-light">1032 Budapest, Bécsi út</p>
          </li>
          <li class="mb-2">
            <strong class="text-light">Telefon:</strong><br>
            <a href="tel:+36204091502" class="text-decoration-none text-light">+36 20 409 1502</a>
          </li>
          <li class="mb-2">
            <strong class="text-light">E-mail:</strong><br>
            <a href="mailto:mancsallatmenhely@gmail.com" class="text-decoration-none text-light">mancsallatmenhely@gmail.com</a>
          </li>
        </ul>
      </div>
    </div>

    <hr class="bg-secondary">

    <!-- Bottom Section -->
    <div class="row align-items-center">
      <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
        <p class="text-muted mb-0">&copy; 2026 Mancs Állatmenhely. Minden jog fenntartva.</p>
      </div>
      <div class="justify-content-center justify-content-md-start">
        <p>&copy; 2026 Mancs Állatmenhely</p>
      </div>
    </div>
  </div>
</footer>
</template>

<style scoped>
footer {
  margin-top: auto;
}
</style>