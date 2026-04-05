<script>
import {RouterLink} from "vue-router";

export default {
  name: "LoginView",
  components: {
    RouterLink
  }
}
</script>

<template>
<section class="d-flex justify-content-center align-items-center">
  <div class="card mt-5">
    <div class="card-body">
      <form>
        <!-- Email input -->
        <div data-mdb-input-init class="form-outline mb-4">
          <label class="form-label" for="form2Example1">E-mail cím</label>
          <input type="email" id="form2Example1" class="form-control" />
        </div>

        <!-- Password input -->
        <div data-mdb-input-init class="form-outline mb-4">
          <label class="form-label" for="form2Example2">Jelszó</label>
          <input type="password" id="form2Example2" class="form-control" />
        </div>

        <!-- Submit button -->
        <button  type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-block mb-4">Bejelentkezés</button>

        <!-- Register buttons -->
        <div class="text-center">
          <p>Nincs fiókod? <RouterLink to="/auth/register">Regisztráció</RouterLink></p>
        </div>
      </form>
    </div>
  </div>
</section>
</template>

<style scoped>
.card{
  width: 500px;
}
</style>