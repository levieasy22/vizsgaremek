<script>
import {RouterLink} from "vue-router";

export default {
  name: "ContactView",
  components: {
    RouterLink
  }
}
</script>

<template>
  <div class="container">
    <h1 class="text-center">Kapcsolat</h1>
  </div>
  <div class="container pt-5">
    <div class="row">
      <div class="col">
        <p><strong>Írj nekünk üzenetet</strong> ha bármilyen kérdésed van, segítségre van szükséged, vagy csak meg szeretnéd osztani a tapasztalataid. Fordulj hozzánk bizalommal!</p>
        <hr>
        <p><strong>Ügyfélszolgálat:</strong><br>
        mancsallatmenhely@gmail.com<br>
        +36 20 409 1502</p>
        <hr>
        <p><strong>Nyitvatartás:</strong><br>
        Hétfő-Péntek: 08:00-17:00<br>
        Szombat: 09:00-15:00</p>
        <hr>
        <div class="accordion" id="accordionExample">

          <div class="accordion-item">
            <h2 class="accordion-header">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                Mennyi idő amíg válaszoltok?
              </button>
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
              <div class="accordion-body">
                Igyekszünk minden beérkezett kérdésre 24 órán belül válaszolni.
              </div>
            </div>
          </div>

          <div class="accordion-item">
            <h2 class="accordion-header">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                Hogyan érlek el titeket a leggyorsabban?
              </button>
            </h2>
            <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
              <div class="accordion-body">
                Az űrlap kitöltése a leggyorsabb módja, de akár telefonon is elérsz minket. Amennyiben épp nem vennénk fel, biztosan visszahívunk.              </div>
            </div>
          </div>

          <div class="accordion-item">
            <h2 class="accordion-header">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                Mit tegyek, ha elutasították a kérelmem?
              </button>
            </h2>
            <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
              <div class="accordion-body">
                Amennyiben elutasítottuk a kérelmed, kérjük, vedd fel velünk a kapcsolatot az űrlapon keresztül, hogy meg tudjuk beszélni a részleteket és esetleg újra tudjuk értékelni a helyzetet.
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col">
        <form>
          <div class="row">
            <p>Add meg a teljes neved</p>
            <div class="col">
              <input type="text" class="form-control" placeholder="Keresztnév" aria-label="First name">
            </div>
            <div class="col">
              <input type="text" class="form-control" placeholder="Vezetéknév" aria-label="Last name">
            </div>
          </div>
          <div class="mb-4 mt-4">
            <label for="exampleInputEmail1" class="form-label">E-mail címed</label>
            <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
            <div id="emailHelp" class="form-text">Soha nem osztjuk meg az e-mail címed senkivel!</div>
          </div>
          <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">Üzenet</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
          </div>
          <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="exampleCheck1">
            <label class="form-check-label" for="exampleCheck1">Elfogadom az <RouterLink to="/privacy-policy"><strong>adatvédelmi tájékoztatót</strong></RouterLink></label>
          </div>
          <button type="submit" class="btn btn-primary mt-2">Küldés</button>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>