<template>
  <v-app>
    <TheHeader />
    <router-view />
  </v-app>
</template>

<script>
import TheHeader from 'components/TheHeader'

export default {
  components: {
    TheHeader
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
