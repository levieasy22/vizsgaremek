<script>
import {RouterLink} from "vue-router";

export default {
  name: "HomeView",
  components: {
    RouterLink
  }
}
</script>

<template>
<main>
  <!-- Hero -->
  <section class="py-5 bg-primary text-white text-left align-items-center align-content-center" id="hero">
    <div class="container m-lg-3">
      <h1 class="mb-2 h6">Állatmenhely</h1>
      <h2 class="mb-3">Fogadj örökbe egy állatot!</h2>
      <p class="lead mb-3">Böngéssz a menhelyünkön található állataink közül, és találd meg az új ideális családtagod!</p>
      <RouterLink to="/adoption" class="btn btn-light btn-lg">Kezdjük az örökbefogadást</RouterLink>
    </div>
  </section>

  <!-- Problem Section -->
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
          <img src="@/imgs/menhelykutyajpg.jpg" alt="Szomorú állat" class="img-fluid rounded">
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

  <!-- Portfolio/Available Animals Section -->
  <section class="py-5">
    <div class="container">
      <h3 class="text-center mb-5">Várják új családjukat</h3>
      <div class="row cards-row">
        <div class="col-md-6 col-lg-5">
          <div class="card">
            <img src="../../imgs/kiskutya.kicsi_.webp" class="card-img-top" alt="Kutya">
            <div class="card-body">
              <h5 class="card-title">Kutyák</h5>
              <p class="card-text">Nézd meg kutyáinkat akik várják következő és egyetlen családjukat!</p>
              <RouterLink :to="{name: 'dogs'}" class="btn btn-primary">Kutyák megnézése</RouterLink>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-5">
          <div class="card">
            <img src="../../imgs/macska.jpg" class="card-img-top" alt="Macska">
            <div class="card-body">
              <h5 class="card-title">Macskák</h5>
              <p class="card-text">Nézd meg macskáinkat akik várják következő és egyetlen családjukat!</p>
              <RouterLink :to="{name: 'cats'}" class="btn btn-primary">Macskák megnézése</RouterLink>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Testimonials Section -->
  <section class="py-5">
    <h2 class="text-center mb-5">Sikeres örökbefogadások</h2>
    <div id="carouselExample" class="carousel slide">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <div class="row g-4">
            <div class="col-md-4">
              <div class="card h-100">
                <div class="card-body">
                  <p class="card-text mb-3">"Az örökbefogadott kutyám megváltoztatta az életemet. Nem tudom, mit csináltam volna nélküle!"</p>
                  <p class="fw-bold">- János és családja</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card h-100">
                <div class="card-body">
                  <p class="card-text mb-3">"Az egész szülőség fantasztikus volt. Ajánlom mindenkinek az örökbefogadást!"</p>
                  <p class="fw-bold">- Mária és Péter</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card h-100">
                <div class="card-body">
                  <p class="card-text mb-3">"A menhely csapata olyan támogató volt. Szeretünk egy macskát választani!"</p>
                  <p class="fw-bold">- Anya és gyerekei</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel-item">
          <div class="row g-4">
            <div class="col-md-4">
              <div class="card h-100">
                <div class="card-body">
                  <p class="card-text mb-3">"Az örökbefogadott kutyám megváltoztatta az életemet. Nem tudom, mit csináltam volna nélküle!"</p>
                  <p class="fw-bold">- Mari és családja</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card h-100">
                <div class="card-body">
                  <p class="card-text mb-3">"Az egész szülőség fantasztikus volt. Ajánlom mindenkinek az örökbefogadást!"</p>
                  <p class="fw-bold">- Alex és anyukája</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card h-100">
                <div class="card-body">
                  <p class="card-text mb-3">"A menhely csapata olyan támogató volt. Szeretünk egy macskát választani!"</p>
                  <p class="fw-bold">- Judit és apukája</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel-item">
          <div class="row g-4">
            <div class="col-md-4">
              <div class="card h-100">
                <div class="card-body">
                  <p class="card-text mb-3">"Az örökbefogadott kutyám megváltoztatta az életemet. Nem tudom, mit csináltam volna nélküle!"</p>
                  <p class="fw-bold">- Olivér és Maja</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card h-100">
                <div class="card-body">
                  <p class="card-text mb-3">"Az egész szülőség fantasztikus volt. Ajánlom mindenkinek az örökbefogadást!"</p>
                  <p class="fw-bold">- László</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card h-100">
                <div class="card-body">
                  <p class="card-text mb-3">"A menhely csapata olyan támogató volt. Szeretünk egy macskát választani!"</p>
                  <p class="fw-bold">- Márk</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
  </section>

  <!-- About Us Section -->
  <section class="py-5">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-lg-6 mb-4 mb-lg-0">
          <h2 class="mb-4">Rólunk</h2>
          <p class="mb-3">A mi missziónk az, hogy minden állatnak megadunk egy második esélyt az életre. Évek óta dolgozunk azon, hogy az utcára kerülő és elhagyott állatokat megmentjük.</p>
          <p class="mb-3">A csapatunk a szeretőből és elkötelezett önkéntesekből áll, akik mindent megtesznek az állatok jólléte érdekében.</p>
          <p>Hiszünk, hogy az örökbefogadás az egyik legjobb megoldás az állatok krízisére.</p>
          <RouterLink to="/about" class="btn btn-primary mt-3">Tudj meg többet</RouterLink>
        </div>
        <div class="col-lg-6">
          <img src="@/imgs/mancs_allatmenhely_logo.png" alt="Rólunk" class="img-fluid rounded">
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

  <!-- Final Call to Action -->
  <section class="py-5 bg-primary text-white text-center">
    <div class="container">
      <h2 class="mb-4">Készen vagy arra, hogy megváltoztatsd egy állat életét?</h2>
      <p class="lead mb-4">Kezdjük az örökbefogadási folyamatot, és találd meg az ideális társat!</p>
      <RouterLink to="/adoption" class="btn btn-light btn-lg">Böngéssz az állatokat</RouterLink>
      <RouterLink to="/contact" class="btn btn-outline-light btn-lg ms-2">Kapcsolatfelvétel</RouterLink>
    </div>
  </section>
</main>
</template>

<style scoped>
#hero{
  height: 80vh;
}

.cards-container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 2rem 0;
}

.cards-row {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 2.5rem;
}

.card {
  width: 100%;
  max-width: 700px;
  height: 500px;
  display: flex;
  flex-direction: column;
}

.card-img-top {
  height: 320px;
  object-fit: cover;
}

.card-body {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.card-text {
  flex: 1;
  margin-bottom: 1rem;
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
  filter: invert(1);
}

.carousel-control-prev {
  left: -120px;
}

.carousel-control-next {
  right: -120px;
}
</style>