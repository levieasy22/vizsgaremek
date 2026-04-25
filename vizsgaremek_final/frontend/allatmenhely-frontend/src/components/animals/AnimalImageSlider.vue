<script>
export default {
  name: 'AnimalImageSlider',
  props: {
    images: { type: Array, default: () => [] },
    animalName: { type: String, default: '' },
  },
  data() {
    const primaryImage = this.images.find(i => i.is_primary) || this.images[0]
    return {
      storageUrl: import.meta.env.VITE_STORAGE_URL || 'http://localhost:8000/storage',
      selectedImagePath: primaryImage?.image_path || null,
    }
  },
  computed: {
    selectedImageUrl() {
      return this.selectedImagePath
          ? this.getImageUrl(this.selectedImagePath)
          : '/placeholder-animal.jpg'
    },
  },
  methods: {
    getImageUrl(path) {
      return path ? `${this.storageUrl}/${path}` : '/placeholder-animal.jpg'
    },
    onImageError(e) {
      e.target.src = '/placeholder-animal.jpg'
    },
    onThumbError(e) {
      e.target.src = '/placeholder-animal.jpg'
    },
  },
}
</script>

<template>
  <div>
    <!-- Fő kép -->
    <div
        style="height: 400px; overflow: hidden; border-radius: 12px;"
        class="mb-3 shadow-sm"
    >
      <img
          :src="selectedImageUrl"
          :alt="animalName"
          style="width: 100%; height: 100%; object-fit: cover; transition: opacity 0.3s ease;"
          @error="onImageError"
      />
    </div>

    <!-- Thumbnail csík (ha több kép van) -->
    <div v-if="images.length > 1" class="d-flex gap-2 flex-wrap">
      <img
          v-for="img in images"
          :key="img.id"
          :src="getImageUrl(img.image_path)"
          :alt="animalName"
          class="rounded"
          :class="{ 'border border-3 border-primary': selectedImagePath === img.image_path }"
          style="width: 75px; height: 75px; object-fit: cover; cursor: pointer; transition: all 0.2s ease;"
          @click="selectedImagePath = img.image_path"
          @error="onThumbError"
      />
    </div>
  </div>
</template>

<style scoped>

</style>