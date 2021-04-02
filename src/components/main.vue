<template>
  <v-main>
    <div class="main">
      <slot></slot>
    </div>
  </v-main>
</template>

<script>
export default {
  name: "main"
}
</script>

<style scoped>
.main {
  margin: 0 auto;
  width: 80%;
  height: 240px;
}
</style>
