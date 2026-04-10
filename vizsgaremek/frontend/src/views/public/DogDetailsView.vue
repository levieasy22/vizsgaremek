<script>
import { http } from "@/utils/http";
import { onMounted, ref } from "vue";
import { useRoute } from "vue-router";

export default {
  name: "DogDetailsView",
  setup() {
    const route = useRoute();
    const dog = ref(null);
    const health = ref(null);
    const loading = ref(true);
    const error = ref(null);

    const fetchDogDetails = async () => {
      try {
        const dogId = route.params.id;
        const dogResponse = await http.get(`/allatok/${dogId}`);
        dog.value = dogResponse.data;

        // Fetch health record if exists
        try {
          const healthResponse = await http.get(`/egeszsegugy/${dogId}`);
          health.value = healthResponse.data;
        } catch (healthError) {
          // Health record might not exist
          console.log('No health record found');
        }

        loading.value = false;
      } catch (err) {
        error.value = 'Failed to load dog details';
        loading.value = false;
        console.error('Error fetching dog details:', err);
      }
    };

    const submitAdoption = async () => {
      try {
        const adoptionData = {
          felhasznalo_id: 1, // Assuming user ID 1 for now (implement auth later)
          allat_id: parseInt(route.params.id),
          statusz: 'elbiralas_alatt'
        };
        await http.post('/orokbefogadasi-kerelmek', adoptionData);
        alert('Örökbefogadási kérelem elküldve!');
        // Optionally refresh the animal status or redirect
      } catch (error) {
        console.error('Error submitting adoption:', error);
        alert('Hiba történt a kérelem elküldésekor.');
      }
    };

    onMounted(() => {
      fetchDogDetails();
    });

    return {
      dog,
      health,
      loading,
      error,
      submitAdoption
    };
  }
}
</script>

<template>
  <section class="py-5">
    <div class="container">
      <div v-if="loading" class="text-center">
        <div class="spinner-border" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
      </div>
      <div v-else-if="error" class="alert alert-danger">
        {{ error }}
      </div>
      <div v-else-if="dog" class="row">
        <div class="col-md-6">
          <img :src="dog.faj === 'kutya' ? '../../imgs/kiskutya.kicsi_.webp' : '../../imgs/macska.jpg'"
               class="img-fluid rounded" alt="Animal" />
        </div>
        <div class="col-md-6">
          <h1 class="mb-4">{{ dog.nev }}</h1>
          <div class="mb-3">
            <strong>Faj:</strong> {{ dog.faj === 'kutya' ? 'Kutya' : 'Macska' }}
          </div>
          <div class="mb-3">
            <strong>Életkor:</strong> {{ dog.eletkor }} éves
          </div>
          <div class="mb-3">
            <strong>Nem:</strong> {{ dog.nem === 'him' ? 'Hím' : 'Nőstény' }}
          </div>
          <div class="mb-3">
            <strong>Állapot:</strong> {{ dog.orokbefogadasi_statusz }}
          </div>
          <div v-if="health" class="mt-4">
            <h3>Egészségügyi adatok</h3>
            <div class="mb-2"><strong>Ivar:</strong> {{ health.ivar }}</div>
            <div class="mb-2"><strong>Oltás:</strong> {{ health.oltas }}</div>
            <div class="mb-2"><strong>Gyógyszer:</strong> {{ health.gyogyszer }}</div>
            <div class="mb-2"><strong>Hátrányok:</strong> {{ health.hatranyok }}</div>
          </div>
          <button class="btn btn-primary mt-4" v-if="dog.orokbefogadasi_statusz === 'szabad'" @click="submitAdoption">
            Örökbefogadom
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>

</style>