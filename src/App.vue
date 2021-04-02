<template>
  <v-app id="inspire">
    <v-header :name=1></v-header>
    <router-view/>
    <v-footer></v-footer>
  </v-app>
</template>

<script>
import header from './components/header'
import footer from './components/footer'

export default {
  name: 'App',
  components: {
    'v-header': header,
    'v-footer': footer,
  }
}
</script>

<style>
@import "ress";

#inspire {

}
</style>
