<template>
  <v-dialog
    max-width="400"
    v-model="dialog"
    id="pickup-modal"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        color="success"
        outlined
        v-bind="attrs"
        v-on="on"
        @click="handlePickupTrack"
      >
        <v-icon>mdi-music-circle-outline</v-icon>
        ピックアップ
      </v-btn>
      <v-fab-transition>
        <v-btn
          v-show="visible"
          color="success"
          fab
          fixed
          bottom
          right
          large
          v-bind="attrs"
          v-on="on"
          @click="handlePickupTrack"
          id="pickup-fab"
        >
          <v-icon>mdi-music-note</v-icon>
        </v-btn>
      </v-fab-transition>
    </template>
    <v-card>
      <v-card-title class="text-h5">
        結果
      </v-card-title>

      <v-divider />

      <div class="d-flex flex-column justify-space-between align-center">
        <v-img
          max-height="250"
          max-width="250"
          :src="this.track.image_url"
        />
        <h3
          class="mt-3 mx-6"
          v-text="this.track.name"
        ></h3>
        <p
          v-text="`${this.track.artist_name} - ${this.track.album_name}`"
          class="mx-6"
        >
        </p>
      </div>

      <v-card-actions>
        <v-btn
          color="primary"
          text
          @click="handleClosePickupModal"
        >
          この曲を歌う！
        </v-btn>
        <v-spacer />
        <v-btn
          color="success"
          text
          :disabled="loading"
          @click="handlePickupTrack"
        >
          もう一度！
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  name: "PickupTrack",

  props: {
    track: {
      type: Object,
      required: true
    },

    loading: {
      type: Boolean,
      required: true
    }
  },

  data() {
    return {
      dialog: false,
      visible: false
    }
  },

  created() {
    window.addEventListener("scroll", this.handleShowButton);
  },

  methods: {
    handlePickupTrack() {
      this.$emit('pickup-track')
    },

    handleClosePickupModal() {
      this.dialog = false
    },

    handleShowButton() {
      if (window.scrollY > 200) {
        this.visible = true
      } else {
        this.visible = false
      }
    }
  }
}
</script>

<style scoped>
</style>