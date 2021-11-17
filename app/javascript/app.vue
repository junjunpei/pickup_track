<template>
  <v-app>
    <TheHeader />
    <v-main>
      <TheFlashMessages />
      <router-view />
    </v-main>
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from 'components/TheHeader.vue'
import TheFooter from 'components/TheFooter.vue'
import TheFlashMessages from 'components/TheFlashMessages.vue'

export default {
  components: {
    TheHeader,
    TheFooter,
    TheFlashMessages
  }
}
</script>

<style scoped>
</style>
