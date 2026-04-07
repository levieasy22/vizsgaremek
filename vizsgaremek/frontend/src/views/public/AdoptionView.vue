<script>
import {RouterLink} from "vue-router";

export default {
  name: "AdoptionView",
  components: {
    RouterLink
  }
}
</script>

<template>
<section class="container">
  <div class="container py-4">
    <h2 class="text-center">Találd meg új családtagod</h2>
  </div>
  <div class="container">
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
</template>

<style scoped>
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
</style>