<script>
import { RouterLink } from "vue-router";
import { http } from "@/utils/http";
import { onMounted, ref } from "vue";

export default {
  name: "CatListView",
  components: {
    RouterLink
  },
  setup() {
    const cats = ref([]);

    const fetchCats = async () => {
      try {
        const response = await http.get('/allatok');
        cats.value = response.data.filter(animal => animal.faj === 'macska');
      } catch (error) {
        console.error('Error fetching cats:', error);
      }
    };

    onMounted(() => {
      fetchCats();
    });

    return {
      cats
    };
  }
}
</script>

<template>
  <section>
    <div class="container py-4">
      <div class="row g-4">
        <div class="col-12 col-sm-6 col-md-4 col-lg-3" v-for="cat in cats" :key="cat.id">
          <div class="card h-100 shadow-sm">
            <img src="../../imgs/macska.jpg" class="card-img-top object-fit-cover" style="height: 220px; object-fit: cover;" />
            <div class="card-body d-flex flex-column justify-content-between">
              <div>
                <h4 class="card-title fw-bold mb-2">{{ cat.nev }}</h4>
                <div class="mb-2 d-flex align-items-center gap-2">
                  <i class="bi bi-calendar3" style="font-size: 1.2rem;"></i>
                  <span>{{ cat.eletkor }} éves</span>
                </div>
                <div class="mb-3 d-flex align-items-center gap-2">
                  <i class="bi" :class="cat.nem === 'him' ? 'bi-gender-male' : 'bi-gender-female'"></i>
                  <span>{{ cat.nem === 'him' ? 'Hím' : 'Nőstény' }}</span>
                </div>
              </div>
              <RouterLink :to="'/cats/' + cat.id" class="btn btn-outline-primary mt-auto w-100">
                További részletek <i class="bi bi-arrow-right"></i>
              </RouterLink>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>

</style>