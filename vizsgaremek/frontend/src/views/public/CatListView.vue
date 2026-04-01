<script>
export default {
  name: "AnimalDetailsView"
}
</script>

<template>
  <div class="card shadow-sm border-0">
    <div class="card-header bg-info text-white d-flex justify-content-between align-items-center">
      <h2 class="h4 mb-0">Állat adatlap</h2>
    </div>
    <div class="card-body">
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Azonosító:</div>
        <div class="col-sm-8">{{ allatok.id }}</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Faj azonosító:</div>
        <div class="col-sm-8">{{ allatok.faj_id }}</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Név:</div>
        <div class="col-sm-8">{{ allatok.nev }}</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Életkor</div>
        <div class="col-sm-8">{{ allatok.eletkor }}</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Nem:</div>
        <div class="col-sm-8">{{ allatok.nem }}</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Örökbefogadási státusz:</div>
        <div class="col-sm-8">{{ allatok.orokbefogadasi_statusz }}</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Max sebesség</div>
        <div class="col-sm-8">{{ ship.maxSpeed }} csomó</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Személyzet:</div>
        <div class="col-sm-8">{{ ship.crew }}</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Utasok száma:</div>
        <div class="col-sm-8">{{ ship.passengers }}</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Hossz:</div>
        <div class="col-sm-8">{{ ship.length }}</div>
      </div>
      <div class="row mb-2">
        <div class="col-sm-4 fw-bold">Státusz:</div>
        <div class="col-sm-8"><span class="badge bg-secondary">{{ ship.status }}</span></div>
      </div>
      <hr>
      <h3 class="h6">Leírás</h3>
      <p class="mb-0">{{ ship.description }}</p>
    </div>
  </div>
</template>

<style scoped>

</style>