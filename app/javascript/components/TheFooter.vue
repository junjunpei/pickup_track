<template>
  <v-footer
    app
    absolute
    color="#292929"
    padless
    height="80"
  >
    <v-row
      align="center"
      no-gutters
    >
      <div class="d-flex justify-content-around">
        <v-btn
          color="white"
          text
          rounded
          small
        >
          利用規約
        </v-btn>
        <v-btn
          color="white"
          text
          rounded
          small
        >
          プライバシーポリシー
        </v-btn>
        <v-btn
          color="white"
          text
          rounded
          small
          :to="{ name: 'ContactForm' }"
        >
          お問い合わせ
        </v-btn>
      </div>
      <v-col
        class="text-center white--text"
        cols="12"
      >
        {{ (new Date()).getFullYear() }} — <strong>Pickup Track</strong> —
      </v-col>
    </v-row>
  </v-footer>
</template>

<script>
export default {
  name: "TheFooter"
}
</script>

<style scoped>
</style>
