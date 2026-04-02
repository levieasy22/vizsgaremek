<script>
import {RouterLink} from "vue-router";

export default {
  name: "DogListView",
  components: {
    RouterLink
  }
  // Replace this with backend data
  // Replace with backend fetch in mounted or setup
}
</script>

<template>
  <section>
    <div class="container py-4">
      <div class="row g-4">
        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
          <div class="card h-100 shadow-sm">
            <img src="../../imgs/kiskutya.kicsi_.webp" class="card-img-top object-fit-cover" style="height: 220px; object-fit: cover;" />
            <div class="card-body d-flex flex-column justify-content-between">
              <div>
                <h4 class="card-title fw-bold mb-2">név</h4>
                <div class="mb-2 d-flex align-items-center gap-2">
                  <i class="bi bi-calendar3" style="font-size: 1.2rem;"></i>
                  <span>születés</span>
                </div>
                <div class="mb-3 d-flex align-items-center gap-2">
                  <i class="bi bi-gender-male"></i>
                  <i class="bi bi-gender-female"></i>
                  <span>nem</span>
                </div>
              </div>
              <button class="btn btn-outline-primary mt-auto w-100">
                További részletek <i class="bi bi-arrow-right"></i>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.card-title {
  font-size: 1.6rem;
}
.card {
  transition: box-shadow 0.2s;
}
.card:hover {
  box-shadow: 0 0 0.5rem #aaa;
}
.card-img-top.object-fit-cover {
  object-fit: cover;
}
</style>