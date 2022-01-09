<template>
  <v-app>
    <TheHeader />
    <v-main>
      <TheFlashMessages />
      <router-view />
    </v-main>
    <TheFooter :class="{'mb-14':isActive}" class="footer" />
    <TheBottomNavigation v-if="$vuetify.breakpoint.smAndDown" />
  </v-app>
</template>

<script>
import TheHeader from './components/TheHeader.vue'
import TheFooter from './components/TheFooter.vue'
import TheFlashMessages from './components/TheFlashMessages.vue'
import TheBottomNavigation from './components/TheBottomNavigation.vue'

export default {
  components: {
    TheHeader,
    TheFooter,
    TheFlashMessages,
    TheBottomNavigation
  },

  data() {
    return {
      isActive: true
    }
  },

  created() {
    window.addEventListener('resize', this.handleShowFooterMargin)
    this.handleShowFooterMargin()
  },

  methods: {
    handleShowFooterMargin() {
      if (window.innerWidth < 960) {
        this.isActive = true
      } else {
        this.isActive = false
      }
    }
  }
}
</script>

<style scoped>
.footer {
  position: static;
}
</style>
