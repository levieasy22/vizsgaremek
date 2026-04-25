<script setup>
const currentYear = new Date().getFullYear()
</script>

<template>
  <footer class="text-white pt-5 pb-3 mt-5" style="background-color: #171717;">
    <div class="container">
      <div class="row g-4 mb-4">

        <!-- Bal: menhely leírás -->
        <div class="col-md-4">
          <h5 class="fw-bold mb-3">
            <i class="bi bi-heart-fill text-warning me-2"></i>Mancs Menhely
          </h5>
          <p class="text-white-50 small">
            Küldetésünk, hogy minden kóbor és gazdátlan állatnak
            szerető otthont találjunk. Örökbefogadással Te is
            változtathatsz egy állat életén!
          </p>
        </div>

        <!-- Közép: gyors linkek -->
        <div class="col-md-4">
          <h6 class="fw-bold mb-3">Gyors linkek</h6>
          <ul class="list-unstyled">
            <li class="mb-2">
              <RouterLink to="/" class="text-white-50 text-decoration-none small">
                <i class="bi bi-chevron-right me-1"></i>Kezdőlap
              </RouterLink>
            </li>
            <li class="mb-2">
              <RouterLink
                  to="/orokbefogadas?type=kutya"
                  class="text-white-50 text-decoration-none small"
              >
                <i class="bi bi-chevron-right me-1"></i>Kutyák örökbefogadása
              </RouterLink>
            </li>
            <li class="mb-2">
              <RouterLink
                  to="/orokbefogadas?type=macska"
                  class="text-white-50 text-decoration-none small"
              >
                <i class="bi bi-chevron-right me-1"></i>Macskák örökbefogadása
              </RouterLink>
            </li>
            <li class="mb-2">
              <RouterLink to="/rolunk" class="text-white-50 text-decoration-none small">
                <i class="bi bi-chevron-right me-1"></i>Rólunk
              </RouterLink>
            </li>
            <li class="mb-2">
              <RouterLink to="/kapcsolat" class="text-white-50 text-decoration-none small">
                <i class="bi bi-chevron-right me-1"></i>Kapcsolat
              </RouterLink>
            </li>
          </ul>
        </div>

        <!-- Jobb: elérhetőség -->
        <div class="col-md-4">
          <h6 class="fw-bold mb-3">Elérhetőség</h6>
          <ul class="list-unstyled text-white-50 small">
            <li class="mb-2">
              <i class="bi bi-geo-alt-fill me-2"></i>1234 Budapest, Állat utca 1.
            </li>
            <li class="mb-2">
              <i class="bi bi-telephone-fill me-2"></i>+36 1 234 5678
            </li>
            <li class="mb-2">
              <i class="bi bi-envelope-fill me-2"></i>info@mancsmenhely.hu
            </li>
            <li class="mb-2">
              <i class="bi bi-clock-fill me-2"></i>H–P: 9:00–17:00
            </li>
            <li class="mb-2">
              <i class="bi bi-clock me-2"></i>Szo: 10:00–14:00
            </li>
          </ul>
        </div>

      </div>

      <hr class="border-secondary">

      <div class="text-center text-white-50 small">
        © {{ currentYear }} Mancs Menhely – Minden jog fenntartva.
      </div>
    </div>
  </footer>
</template>

<style scoped>

</style>