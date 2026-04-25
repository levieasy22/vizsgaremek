<script>
import {createRouter} from "vue-router";
import axios from "@/services/api.js";
export default {
  name: 'AboutView',
  createRouter,
  api: axios
}
</script>

<template>
  <div>
    <!-- Hero szekció -->
    <section class="hero-section text-white py-5">
      <div class="container py-4">
        <div class="row align-items-center">
          <div class="col-lg-6 mb-4 mb-lg-0">
            <h1 class="display-4 fw-bold mb-3">Rólunk</h1>
            <p class="lead">
              2016 óta működő állatmenhely, ahol a szeretet és a szakértelem találkozik.
            </p>
          </div>
          <div class="col-lg-6 text-center">
            <img
                src="https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=500&h=300&fit=crop"
                alt="Menhelyes állatok"
                class="img-fluid rounded shadow-lg"
                style="max-height: 300px; object-fit: cover;"
            >
          </div>
        </div>
      </div>
    </section>

    <!-- Csapatunk -->
    <section class="py-5">
      <div class="container">
        <h2 class="text-center mb-5">
          <i class="bi bi-people text-secondary"></i> Csapatunk
        </h2>
        <div class="row g-4">
          <div class="col-md-4">
            <div class="card border-0 shadow-sm text-center h-100">
              <div class="card-body">
                <div class="rounded-circle bg-secondary text-white d-inline-flex align-items-center justify-content-center mb-3"
                     style="width: 100px; height: 100px; font-size: 3rem;">
                  <i class="bi bi-person-badge"></i>
                </div>
                <h5>Müller Enikő</h5>
                <p class="text-muted mb-0">Vezető állatorvos</p>
              </div>
            </div>
          </div>

          <div class="col-md-4">
            <div class="card border-0 shadow-sm text-center h-100">
              <div class="card-body">
                <div class="rounded-circle bg-success text-white d-inline-flex align-items-center justify-content-center mb-3"
                     style="width: 100px; height: 100px; font-size: 3rem;">
                  <i class="bi bi-person-badge"></i>
                </div>
                <h5>Igli Levente</h5>
                <p class="text-muted mb-0">Menhely vezető</p>
              </div>
            </div>
          </div>

          <div class="col-md-4">
            <div class="card border-0 shadow-sm text-center h-100">
              <div class="card-body">
                <div class="rounded-circle bg-warning text-white d-inline-flex align-items-center justify-content-center mb-3"
                     style="width: 100px; height: 100px; font-size: 3rem;">
                  <i class="bi bi-person-badge"></i>
                </div>
                <h5>Lakner Máté</h5>
                <p class="text-muted mb-0">Menhely vezető</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Küldetésünk -->
    <section class="py-5">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto">
            <h2 class="text-center mb-4">
              <i class="bi bi-heart-fill text-danger"></i> Küldetésünk
            </h2>
            <p class="lead text-center text-muted mb-4">
              Az állatmenhely célja, hogy átmeneti otthont biztosítson az elhagyott,
              gazdátlan kutyák és macskák számára, és új, szerető családot találjon
              mindegyiküknek.
            </p>
            <p class="text-muted">
              Hiszünk abban, hogy minden állatnak joga van a méltó élethez, szeretethez
              és gondoskodáshoz. Munkatársaink nap mint nap azon dolgoznak, hogy
              lakóink a lehető legjobb körülmények között éljenek, amíg meg nem találják
              új otthonukat.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Értékeink -->
    <section class="py-5 bg-light">
      <div class="container">
        <h2 class="text-center mb-5">
          <i class="bi bi-star-fill text-warning"></i> Értékeink
        </h2>
        <div class="row g-4">
          <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm">
              <div class="card-body text-center">
                <i class="bi bi-heart text-danger" style="font-size: 3rem;"></i>
                <h4 class="mt-3 mb-3">Szeretet</h4>
                <p class="text-muted">
                  Minden állatot szeretettel és türelemmel kezelünk,
                  függetlenül korától, fajától vagy fizikai állapotától.
                </p>
              </div>
            </div>
          </div>

          <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm">
              <div class="card-body text-center">
                <i class="bi bi-shield-check text-success" style="font-size: 3rem;"></i>
                <h4 class="mt-3 mb-3">Szakértelem</h4>
                <p class="text-muted">
                  Képzett állatorvosaink és gondozóink biztosítják,
                  hogy minden állat megkapja a szükséges ellátást.
                </p>
              </div>
            </div>
          </div>

          <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm">
              <div class="card-body text-center">
                <i class="bi bi-people text-secondary" style="font-size: 3rem;"></i>
                <h4 class="mt-3 mb-3">Közösség</h4>
                <p class="text-muted">
                  Önkénteseink és támogatóink nélkül nem tudnánk működni.
                  Közösen építjük a jobb világot az állatoknak.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Történetünk -->
    <section class="py-5">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-6 mb-4 mb-lg-0">
            <img
                src="https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=600&h=400&fit=crop"
                alt="Menhelyes kutyák"
                class="img-fluid rounded shadow"
            >
          </div>
          <div class="col-lg-6">
            <h2 class="mb-4">
              <i class="bi bi-book text-info"></i> Történetünk
            </h2>
            <p class="text-muted mb-3">
              Menhelyünk 2016-ben kezdte meg működését néhány elkötelezett
              állatvédő kezdeményezéseként. Kezdetben mindössze 10 kutyának
              tudtunk otthont adni egy kis telken.
            </p>
            <p class="text-muted mb-3">
              Az évek során folyamatosan bővültünk, és ma már több mint 570
              kutyának és 130 macskának biztosítunk átmeneti otthont. Létesítményünk
              modern, tágas és kényelmes kennelekkel, játszóterekkel és
              rehabilitációs helyiségekkel rendelkezik.
            </p>
            <p class="text-muted mb-3">
              Azóta több mint <strong>700 állatot</strong> fogadtak örökbe tőlünk,
              és mindegyikük megtalálta a tökéletes családot.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Statisztikák -->
    <section class="py-5 bg-light">
      <div class="container">
        <h2 class="text-center mb-5">Eredményeink számokban</h2>
        <div class="row text-center g-4">
          <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
              <div class="card-body">
                <i class="bi bi-calendar-check text-primary" style="font-size: 3rem;"></i>
                <h3 class="mt-3 mb-1">10 év</h3>
                <p class="text-muted mb-0">Tapasztalat</p>
              </div>
            </div>
          </div>

          <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
              <div class="card-body">
                <i class="bi bi-heart-fill text-danger" style="font-size: 3rem;"></i>
                <h3 class="mt-3 mb-1">700+</h3>
                <p class="text-muted mb-0">Örökbefogadott állat</p>
              </div>
            </div>
          </div>

          <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
              <div class="card-body">
                <i class="bi bi-house-heart text-success" style="font-size: 3rem;"></i>
                <h3 class="mt-3 mb-1">16+</h3>
                <p class="text-muted mb-0">Jelenlegi lakó</p>
              </div>
            </div>
          </div>

          <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
              <div class="card-body">
                <i class="bi bi-people-fill text-warning" style="font-size: 3rem;"></i>
                <h3 class="mt-3 mb-1">8+</h3>
                <p class="text-muted mb-0">Önkéntes</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA szekció -->
    <section class="py-5 bg-primary text-dark">
      <div class="container text-center">
        <h2 class="display-5 fw-bold mb-3">Csatlakozz hozzánk!</h2>
        <p class="lead mb-4">
          Akár örökbe szeretnél fogadni, akár önkéntesként segítenél,
          várunk szeretettel!
        </p>
        <div class="d-flex gap-3 justify-content-center">
          <router-link to="/orokbefogadas" class="btn btn-dark btn-lg">
            <i class="bi bi-heart-fill"></i> Örökbefogadás
          </router-link>
          <router-link to="/kapcsolat" class="btn btn-secondary btn-lg">
            <i class="bi bi-envelope"></i> Kapcsolatfelvétel
          </router-link>
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