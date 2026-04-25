<script>
import AnimalCard from '@/components/animals/AnimalCard.vue'
import axios from '@/services/api.js'
import {createRouter} from "vue-router";

export default {
  name: 'HomeView',
  components: {
    AnimalCard,
    createRouter
  },
  data() {
    return {
      featuredAnimals: [],
      stats: {
        adopted: 0,
        available: 0
      },
      loading: false,
      error: ''
    }
  },
  mounted() {
    this.fetchFeaturedAnimals()
    this.fetchStats()
  },
  methods: {
    async fetchFeaturedAnimals() {
      this.loading = true
      this.error = ''

      try {
        // Kiemelt állatok lekérése (első 9 elérhető állat)
        const response = await axios.get('/animals', {
          params: {
            status: 'elerheto',
            limit: 9
          }
        })

        const animals = response.data.data || response.data
        this.featuredAnimals = animals.slice(0, 9)
      } catch (err) {
        this.error = 'Hiba történt az állatok betöltése során.'
        console.error('Fetch animals error:', err)
      } finally {
        this.loading = false
      }
    },

    async fetchStats() {
      try {
        // Statisztikák lekérése
        const response = await axios.get('/animals/stats')
        this.stats = response.data
      } catch (err) {
        console.error('Fetch stats error:', err)
        // Ha nincs stats endpoint, beállítunk alapértelmezett értékeket
        this.stats = { adopted: 700, available: 20 }
      }
    }
  }
}
</script>

<template>
  <div>
    <!-- HERO SECTION -->
    <section class="hero-section bg-primary text-white py-5">
      <div class="container py-5">
        <div class="row align-items-center">
          <div class="col-lg-6 mb-4 mb-lg-0">
            <h1 class="display-4 fw-bold mb-3">Adj otthont egy hűséges társnak!</h1>
            <p class="lead mb-4">
              Állatmenhelyünk több száz kutya és macska számára biztosít átmeneti otthont.
              Segíts nekik találni új, szerető családot!</p>
            <div class="d-flex gap-2">
              <router-link to="/orokbefogadas" class="btn btn-light btn-lg">
                <i class="bi bi-heart-fill"></i> Örökbefogadás
              </router-link>
              <router-link to="/kapcsolat" class="btn btn-outline-light btn-lg">
                <i class="bi bi-envelope"></i> Kapcsolat
              </router-link>
            </div>
          </div>
          <div class="col-lg-6 text-center">
            <img
                src="https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=600&h=400&fit=crop"
                alt="Kutyák és macskák"
                class="img-fluid rounded shadow-lg" style="max-height: 400px; object-fit: cover;">
          </div>
        </div>
      </div>
    </section>

    <!-- STATISZTIKA SZEKCIÓ -->
    <section class="py-5 bg-light">
      <div class="container">
        <div class="row text-center">
          <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
              <div class="card-body">
                <i class="bi bi-house-heart text-secondary" style="font-size: 3rem;"></i>
                <h3 class="mt-3 mb-1">700+</h3>
                <p class="text-muted mb-0">Örökbefogadott állat</p>
              </div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
              <div class="card-body">
                <i class="bi bi-check-circle text-success" style="font-size: 3rem;"></i>
                <h3 class="mt-3 mb-1">{{ stats.available || 0 }}</h3>
                <p class="text-muted mb-0">Elérhető állat</p>
              </div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
              <div class="card-body">
                <i class="bi bi-shield-check text-info" style="font-size: 3rem;"></i>
                <h3 class="mt-3 mb-1">100%</h3>
                <p class="text-muted mb-0">Oltva és ivartalanítva</p>
              </div>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
              <div class="card-body">
                <i class="bi bi-heart text-danger" style="font-size: 3rem;"></i>
                <h3 class="mt-3 mb-1">24/7</h3>
                <p class="text-muted mb-0">Gondoskodás és szeretet</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="py-5">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-6 mb-4 mb-lg-0">
            <h2 class="mb-4">Az állatok nehéz helyzete</h2>
            <p class="mb-3">Minden nap rengeteg állat kerül az utcára, azért mert nincs otthonuk. Sokan közülük betegek, traumatizáltak, és szükségük van szeretetre és gondoskodásra.</p>
            <p class="mb-3">A menhely az egyik legjobb megoldás ezek az állatok számára, de csak akkor, ha vannak olyan emberek, akik hajlandóak örökbe fogadni őket.</p>
            <p>Az örökbefogadás nem csak az állatnak segít, hanem az egész családodnak is boldogabbá teszi az életet.</p>
          </div>
          <div class="col-lg-6">
            <img src="@/assets/images/menhelykutyajpg.jpg" alt="Szomorú állat" class="img-fluid rounded">
          </div>
        </div>
      </div>
    </section>

    <!-- Solution/Services Section -->
    <section class="py-5 bg-light">
      <div class="container">
        <h3 class="text-center mb-5">Mit kínálunk?</h3>
        <div class="row g-4">
          <div class="col-md-6 col-lg-3">
            <div class="card h-100 text-center">
              <div class="card-body">
                <h5 class="card-title">Szűrés és Orvosi Ellátás</h5>
                <p class="card-text">Minden állat alapos szűrésen megy keresztül és kapja meg az összes szükséges orvosi ellátást.</p>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
            <div class="card h-100 text-center">
              <div class="card-body">
                <h5 class="card-title">Szocializáció</h5>
                <p class="card-text">Segítünk az állatoknak szokni az emberekhez és más állatokhoz a sikeres örökbefogadás érdekében.</p>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
            <div class="card h-100 text-center">
              <div class="card-body">
                <h5 class="card-title">Tanácsadás</h5>
                <p class="card-text">Útmutatást adunk az örökbefogadás előtt és után az új családok számára.</p>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
            <div class="card h-100 text-center">
              <div class="card-body">
                <h5 class="card-title">Támogatás</h5>
                <p class="card-text">Mindig elérhető vagyunk, ha kérdésed van az örökbefogadott állat gondozásáról.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- KIEMELT ÁLLATOK SZEKCIÓ -->
    <section class="py-5">
      <div class="container">
        <div class="text-center mb-5">
          <h2 class="display-5 fw-bold mb-3">
            Várják az új gazdijukat
          </h2>
          <p class="lead text-muted">
            Ismerd meg legújabb lakóinkat, akik szerető családra várnak
          </p>
        </div>

        <!-- Loading state -->
        <div v-if="loading" class="text-center py-5">
          <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Betöltés...</span>
          </div>
          <p class="mt-3 text-muted">Állatok betöltése...</p>
        </div>

        <!-- Error state -->
        <div v-else-if="error" class="alert alert-danger" role="alert">
          <i class="bi bi-exclamation-triangle-fill"></i>
          {{ error }}
        </div>

        <!-- Állatok megjelenítése -->
        <div v-else class="row">
          <div
              v-for="animal in featuredAnimals"
              :key="animal.id"
              class="col-md-6 col-lg-4 mb-4"
          >
            <AnimalCard :animal="animal" />
          </div>
        </div>

        <!-- Több állat megtekintése gomb -->
        <div class="text-center mt-4" v-if="!loading && !error">
          <router-link to="/orokbefogadas" class="btn btn-lg text-light" style="background-color: #574A38;">
            <i class="bi bi-arrow-right-circle"></i>
            Összes állat megtekintése
          </router-link>
        </div>
      </div>
    </section>

    <!-- HOGYAN MŰKÖDIK SZEKCIÓ -->
    <section class="py-5 bg-light">
      <div class="container">
        <div class="text-center mb-5">
          <h2 class="display-5 fw-bold mb-3">Hogyan működik?</h2>
          <p class="lead text-muted">Az örökbefogadás egyszerű, 3 lépésben</p>
        </div>

        <div class="row">
          <div class="col-md-4 mb-4">
            <div class="text-center">
              <div class="rounded-circle text-white d-inline-flex align-items-center justify-content-center mb-3"
                   style="width: 80px; height: 80px; font-size: 2rem; background-color: #017FD9">
                <i class="bi bi-search"></i>
              </div>
              <h4>1. Válassz</h4>
              <p class="text-muted">
                Böngéssz az örökbefogadható állatok között, és találd meg azt,
                aki a legjobban illik hozzád.
              </p>
            </div>
          </div>

          <div class="col-md-4 mb-4">
            <div class="text-center">
              <div class="rounded-circle bg-success text-white d-inline-flex align-items-center justify-content-center mb-3"
                   style="width: 80px; height: 80px; font-size: 2rem;">
                <i class="bi bi-calendar-check"></i>
              </div>
              <h4>2. Ismerkedj</h4>
              <p class="text-muted">
                Foglalj időpontot egy személyes találkozóra az állattal a menhelyen.
              </p>
            </div>
          </div>

          <div class="col-md-4 mb-4">
            <div class="text-center">
              <div class="rounded-circle bg-danger text-white d-inline-flex align-items-center justify-content-center mb-3"
                   style="width: 80px; height: 80px; font-size: 2rem;">
                <i class="bi bi-heart-fill"></i>
              </div>
              <h4>3. Fogadj örökbe</h4>
              <p class="text-muted">
                Töltsd ki az örökbefogadási kérelmet, és vidd haza új családtagodat!
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ Section -->
    <section class="py-5 bg-light">
      <div class="container">
        <h2 class="text-center mb-5">Gyakran Ismételt Kérdések</h2>
        <div class="row">
          <div class="col-lg-8 offset-lg-2">
            <div class="accordion" id="faqAccordion">
              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                    Milyen feltételek vannak az örökbefogadásra?
                  </button>
                </h2>
                <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">
                    Az örökbefogadáshoz legyen egy megfelelő otthon, elég idő és anyagi lehetőség az állat gondozására. Végigmegyünk egy rövid interjún és döntésünk alapján meghatározzuk, melyik állat lenne az ideális számodra.
                  </div>
                </div>
              </div>
              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                    Melyek az örökbefogadás költségei?
                  </button>
                </h2>
                <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">
                    Az örökbefogadási díj általában alacsony, és magában foglalja az orvosi vizsgálatokat, az oltásokat és a chipezést. Ez azért van, hogy biztosítsuk az állat egészségét az új otthonában.
                  </div>
                </div>
              </div>
              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                    Mit kell tudnom az örökbefogadás után?
                  </button>
                </h2>
                <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">
                    Az örökbefogadás után biztosítunk támogatást és tanácsadást. Az állatnak időre lesz szüksége, hogy szokjon az új otthonhoz. Ajánljuk, hogy tartsál kapcsolatot velünk az első hetekben.
                  </div>
                </div>
              </div>
              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">
                    Mi van, ha az örökbefogadott állat nem működik?
                  </button>
                </h2>
                <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                  <div class="accordion-body">
                    Érezzük, hogy az örökbefogadás sikere fontos. Ha bármilyen probléma van, kérjük, lépj kapcsolatba velünk. Segítünk a problémamegoldásban, vagy ha szükséges, visszavesszük az állatot.
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA SZEKCIÓ -->
    <section class="py-5 text-dark bg-primary">
      <div class="container text-center">
        <h2 class="display-5 fw-bold mb-3">Szeretnél örökbefogadni?</h2>
        <p class="lead mb-4">
          Vedd fel velünk a kapcsolatot!
        </p>
        <router-link to="/kapcsolat" class="btn btn-lg text-light" style="background-color: #574A38;">
          <i class="bi bi-envelope-heart"></i> Kapcsolatfelvétel
        </router-link>
      </div>
    </section>
  </div>
</template>

<style scoped>
.hero-section {
  background: linear-gradient(130deg, #574A38 30%, #F2D0A4 100%);
}
</style>