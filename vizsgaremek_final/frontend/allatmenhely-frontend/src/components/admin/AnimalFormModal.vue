<script>
import AlertMessage from '@/components/ui/AlertMessage.vue'
import defaultDogImg from '@/assets/images/dog2d.jpg'
import defaultCatImg from '@/assets/images/cat2d.jpg'
export default {
  name: 'AnimalFormModal',
  components: {
    AlertMessage,
  },
  props: {
    animal: { type: Object, default: null },
    saving: { type: Boolean, default: false },
    errors: { type: Object, default: () => ({}) },
    errorMsg: { type: String, default: '' },
  },
  emits: ['save', 'delete-image', 'dismiss'],
  data() {
    return {
      storageUrl: import.meta.env.VITE_STORAGE_URL || 'http://localhost:8000/storage',
      emptyForm: {
        name: '', type: '', breed: '', gender: '',
        age: 1, description: '', status: 'elerheto',
        is_vaccinated: false, is_neutered: false,
      },
      form: null,
      errorMsg: this.errorMsg,
      selectedFile: null,
      defaultDogImg,
      defaultCatImg,
    }
  },
  watch: {
    animal: {
      immediate: true,
      handler(newAnimal) {
        if (newAnimal) {
          this.form = {
            name: newAnimal.name,
            type: newAnimal.type,
            breed: newAnimal.breed || '',
            gender: newAnimal.gender,
            age: newAnimal.age,
            description: newAnimal.description || '',
            status: newAnimal.status,
            is_vaccinated: newAnimal.is_vaccinated,
            is_neutered: newAnimal.is_neutered,
          }
        } else {
          this.form = { ...this.emptyForm }
        }
      }
    }
  },
  methods: {
    onFileSelected(e) {
      this.selectedFile = e.target.files[0] || null
    },
    handleSave() {
      this.$emit('save', {
        formData: this.form,
        file: this.selectedFile,
      })
    },
  },
}
</script>

<template>
  <div class="modal fade" id="animalFormModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content border-0 shadow">

        <div class="modal-header">
          <h5 class="modal-title fw-bold">
            {{ animal ? 'Állat szerkesztése' : 'Új állat hozzáadása' }}
          </h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>

        <div class="modal-body">
          <AlertMessage :message="errorMsg" type="danger" @dismiss="errorMsg = ''" />

          <form id="animalFormModalForm" @submit.prevent="handleSave">
            <div class="row g-3">

              <div class="col-md-6">
                <label class="form-label fw-semibold">Név *</label>
                <input
                    v-model="form.name"
                    type="text"
                    class="form-control"
                    :class="{ 'is-invalid': errors.name }"
                    required
                />
                <div class="invalid-feedback">{{ errors.name?.[0] }}</div>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Fajta</label>
                <input
                    v-model="form.breed"
                    type="text"
                    class="form-control"
                    placeholder="pl. Labrador, Keverék"
                />
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Típus *</label>
                <select
                    v-model="form.type"
                    class="form-select"
                    :class="{ 'is-invalid': errors.type }"
                    required
                >
                  <option value="">Válassz...</option>
                  <option value="kutya">🐶 Kutya</option>
                  <option value="macska">🐱 Macska</option>
                </select>
                <div class="invalid-feedback">{{ errors.type?.[0] }}</div>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Nem *</label>
                <select v-model="form.gender" class="form-select" required>
                  <option value="">Válassz...</option>
                  <option value="him">♂ Hím</option>
                  <option value="nosteny">♀ Nőstény</option>
                </select>
              </div>

              <div class="col-md-4">
                <label class="form-label fw-semibold">Kor (év) *</label>
                <input
                    v-model.number="form.age"
                    type="number"
                    min="0"
                    max="30"
                    class="form-control"
                    required
                />
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Státusz *</label>
                <select v-model="form.status" class="form-select" required>
                  <option value="elerheto">Elérhető</option>
                  <option value="foglalas_alatt">Foglalás alatt</option>
                  <option value="orokbefogadva">Örökbefogadva</option>
                </select>
              </div>

              <div class="col-md-3 d-flex align-items-end pb-2">
                <div class="form-check form-switch">
                  <input
                      v-model="form.is_vaccinated"
                      class="form-check-input"
                      type="checkbox"
                      id="modalVaccinated"
                  />
                  <label class="form-check-label" for="modalVaccinated">Oltott</label>
                </div>
              </div>

              <div class="col-md-3 d-flex align-items-end pb-2">
                <div class="form-check form-switch">
                  <input
                      v-model="form.is_neutered"
                      class="form-check-input"
                      type="checkbox"
                      id="modalNeutered"
                  />
                  <label class="form-check-label" for="modalNeutered">Ivartalanított</label>
                </div>
              </div>

              <div class="col-12">
                <label class="form-label fw-semibold">Leírás</label>
                <textarea
                    v-model="form.description"
                    class="form-control"
                    rows="4"
                    placeholder="Az állat személyisége, előélete..."
                ></textarea>
              </div>

              <!-- Képfeltöltés – csak szerkesztésnél jelenik meg -->
              <div v-if="animal" class="col-12">
                <label class="form-label fw-semibold">Új kép feltöltése</label>
                <input
                    type="file"
                    class="form-control"
                    accept="image/jpeg,image/png,image/webp"
                    @change="onFileSelected"
                />
                <div class="form-text">Max. 2MB – jpg, png vagy webp formátum</div>

                <!-- Meglévő képek listája -->
                <div v-if="animal" class="mt-3">
                  <div class="small fw-semibold mb-2 text-muted">Meglévő képek:</div>
                  <div class="d-flex flex-wrap gap-2">

                    <!-- Ha vannak valódi képek, azokat mutatja -->
                    <template v-if="animal.images && animal.images.length > 0">
                      <div
                          v-for="img in animal.images" :key="img.id" class="position-relative"
                      >
                        <img
                            :src="`${storageUrl}/${img.image_path}`"
                            style="width: 70px; height: 70px; object-fit: cover; border-radius: 8px;"
                            @error="e => e.target.src = animal.type === 'kutya' ? defaultDogImg : defaultCatImg"
                        />
                        <span v-if="img.is_primary" class="badge bg-success position-absolute bottom-0 start-0"
                            style="font-size: 9px;"
                        >
          Fő
        </span>
                        <button type="button" class="btn btn-danger position-absolute top-0 end-0"
                            style="padding: 1px 5px; font-size: 10px; line-height: 1.5;"
                            @click="$emit('delete-image', animal.id, img.id)"
                        >
                          <i class="bi bi-x"></i>
                        </button>
                      </div>
                    </template>

                    <!-- Ha nincs kép, az alapértelmezett képet mutatja -->
                    <template v-else>
                      <div class="position-relative">
                        <img
                            :src="animal.type === 'kutya' ? defaultDogImg : defaultCatImg"
                            style="width: 70px; height: 70px; object-fit: cover; border-radius: 8px; opacity: 0.6;"/>
                        <span class="badge bg-secondary position-absolute bottom-0 start-0" style="font-size: 9px;"
                        >Alapért.</span>
                      </div>
                      <div class="d-flex align-items-center ms-2">
                        <small class="text-muted fst-italic">Nincs feltöltött kép</small>
                      </div>
                    </template>

                  </div>
                </div>
              </div>

            </div>
          </form>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            Mégse
          </button>
          <button
              type="submit"
              form="animalFormModalForm"
              class="btn btn-primary fw-bold"
              :disabled="saving"
          >
            <span v-if="saving" class="spinner-border spinner-border-sm me-1"></span>
            {{ animal ? 'Mentés' : 'Hozzáadás' }}
          </button>
        </div>

      </div>
    </div>
  </div>
</template>

<style scoped>

</style>