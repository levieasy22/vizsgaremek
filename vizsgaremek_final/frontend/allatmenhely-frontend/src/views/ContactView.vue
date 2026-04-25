<script>
import ContactForm from '@/components/forms/ContactForm.vue'
import {createRouter} from "vue-router";
import axios from "@/services/api.js";

export default {
  name: 'ContactView',
  components: {
    ContactForm,
    createRouter,
    api: axios
  }
}
</script>

<template>
  <div>
    <!-- Hero szekció -->
    <section class="hero-section text-white py-5">
      <div class="container py-4">
        <div class="text-center">
          <h1 class="display-4 fw-bold mb-3">Kapcsolat</h1>
          <p class="lead">
            Keress minket bátran! Szívesen válaszolunk minden kérdésedre.
          </p>
        </div>
      </div>
    </section>

    <!-- Kapcsolatfelvételi szekció -->
    <section class="py-5">
      <div class="container">
        <div class="row">
          <!-- Bal oldal: Kapcsolatfelvételi űrlap -->
          <div class="col-lg-7 mb-4">
            <ContactForm />
          </div>

          <!-- Jobb oldal: Elérhetőségek -->
          <div class="col-lg-5">
            <!-- Elérhetőségek kártya -->
            <div class="card shadow-sm mb-4">
              <div class="card-body">
                <h4 class="card-title mb-4">
                  <i class="bi bi-geo-alt-fill text-danger"></i>
                  Elérhetőségeink
                </h4>

                <!-- Cím -->
                <div class="mb-4">
                  <h6 class="text-muted mb-2">
                    <i class="bi bi-house-door"></i> Cím
                  </h6>
                  <p class="mb-0">
                    1234 Budapest<br>
                    Állatmentő utca 12.<br>
                    Magyarország
                  </p>
                </div>

                <!-- Telefon -->
                <div class="mb-4">
                  <h6 class="text-muted mb-2">
                    <i class="bi bi-telephone"></i> Telefon
                  </h6>
                  <p class="mb-0">
                    <a href="tel:+36301234567" class="text-decoration-none">
                      +36 30 123 4567
                    </a>
                  </p>
                </div>

                <!-- Email -->
                <div class="mb-4">
                  <h6 class="text-muted mb-2">
                    <i class="bi bi-envelope"></i> Email
                  </h6>
                  <p class="mb-0">
                    <a href="mailto:info@allatmenhely.hu" class="text-decoration-none">
                      info@allatmenhely.hu
                    </a>
                  </p>
                </div>

                <!-- Közösségi média -->
                <div class="mb-0">
                  <h6 class="text-muted mb-2">
                    <i class="bi bi-share"></i> Közösségi média
                  </h6>
                  <div class="d-flex gap-2">
                    <a href="#" class="btn btn-outline-primary btn-sm">
                      <i class="bi bi-facebook"></i>
                    </a>
                    <a href="#" class="btn btn-outline-danger btn-sm">
                      <i class="bi bi-instagram"></i>
                    </a>
                    <a href="#" class="btn btn-outline-info btn-sm">
                      <i class="bi bi-twitter"></i>
                    </a>
                  </div>
                </div>
              </div>
            </div>

            <!-- Nyitvatartás kártya -->
            <div class="card shadow-sm">
              <div class="card-body">
                <h4 class="card-title mb-4">
                  <i class="bi bi-clock-fill text-secondary"></i>
                  Nyitvatartás
                </h4>

                <table class="table table-sm mb-0">
                  <tbody>
                  <tr>
                    <td><strong>Hétfő - Péntek:</strong></td>
                    <td class="text-end">9:00 - 17:00</td>
                  </tr>
                  <tr>
                    <td><strong>Szombat:</strong></td>
                    <td class="text-end">10:00 - 14:00</td>
                  </tr>
                  <tr>
                    <td><strong>Vasárnap:</strong></td>
                    <td class="text-end text-danger">Zárva</td>
                  </tr>
                  </tbody>
                </table>

                <hr>

                <p class="text-muted mb-0">
                  <small>
                    <i class="bi bi-info-circle"></i>
                    Látogatáshoz előzetes időpontfoglalás szükséges!
                  </small>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- GYIK szekció -->
    <section class="py-5">
      <div class="container">
        <h3 class="text-center mb-5">
          <i class="bi bi-question-circle text-warning"></i>
          Gyakran Ismételt Kérdések
        </h3>

        <div class="row">
          <div class="col-lg-8 mx-auto">
            <div class="accordion" id="faqAccordion">
              <!-- GYIK 1 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="faq1">
                  <button
                      class="accordion-button"
                      type="button"
                      data-bs-toggle="collapse"
                      data-bs-target="#collapse1"
                  >
                    Mibe kerül az örökbefogadás?
                  </button>
                </h2>
                <div
                    id="collapse1"
                    class="accordion-collapse collapse show"
                    data-bs-parent="#faqAccordion"
                >
                  <div class="accordion-body">
                    Az örökbefogadás adminisztrációs díja kutyák esetén 25.000 Ft,
                    macskák esetén 15.000 Ft. Ez az összeg fedezi az oltások,
                    ivartalanítás és mikrochip beültetés költségeit.
                  </div>
                </div>
              </div>

              <!-- GYIK 2 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="faq2">
                  <button
                      class="accordion-button collapsed"
                      type="button"
                      data-bs-toggle="collapse"
                      data-bs-target="#collapse2"
                  >
                    Mennyi időbe telik az örökbefogadási folyamat?
                  </button>
                </h2>
                <div
                    id="collapse2"
                    class="accordion-collapse collapse"
                    data-bs-parent="#faqAccordion"
                >
                  <div class="accordion-body">
                    A kérelem beérkezését követően 2-3 munkanapon belül felvesszük veled
                    a kapcsolatot. Az ismerkedési időpont után, ha minden rendben van,
                    általában 1 héten belül hazaviheted új társadat.
                  </div>
                </div>
              </div>

              <!-- GYIK 3 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="faq3">
                  <button
                      class="accordion-button collapsed"
                      type="button"
                      data-bs-toggle="collapse"
                      data-bs-target="#collapse3"
                  >
                    Kötelező az előzetes időpontfoglalás?
                  </button>
                </h2>
                <div
                    id="collapse3"
                    class="accordion-collapse collapse"
                    data-bs-parent="#faqAccordion"
                >
                  <div class="accordion-body">
                    Igen, kérjük, hogy minden esetben foglalj előre időpontot,
                    hogy megfelelő időt tudjunk számodra biztosítani és segíteni
                    a legjobb társat megtalálni.
                  </div>
                </div>
              </div>

              <!-- GYIK 4 -->
              <div class="accordion-item">
                <h2 class="accordion-header" id="faq4">
                  <button
                      class="accordion-button collapsed"
                      type="button"
                      data-bs-toggle="collapse"
                      data-bs-target="#collapse4"
                  >
                    Hogyan támogathatok más módon?
                  </button>
                </h2>
                <div
                    id="collapse4"
                    class="accordion-collapse collapse"
                    data-bs-parent="#faqAccordion"
                >
                  <div class="accordion-body">
                    Örülünk minden segítségnek! Támogathatsz pénzadománnyal,
                    táppal, játékokkal vagy akár önkéntes munkával is.
                    Írj nekünk a kapcsolatfelvételi űrlapon keresztül!
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
.hero-section {
  background: linear-gradient(130deg, #574A38 30%, #F2D0A4 100%);
}
</style>