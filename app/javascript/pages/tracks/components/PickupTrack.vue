<template>
  <v-dialog
    max-width="500"
    v-model="dialog"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        color="success"
        outlined
        v-bind="attrs"
        v-on="on"
        @click="handlePickupTrack"
      >
        ピックアップ
      </v-btn>
    </template>
    <v-card>
      <v-card-title class="text-h5">
        ピックアップ結果
      </v-card-title>

      <v-divider />

      <div class="d-flex flex-column justify-space-between align-center">
        <v-img
          max-height="300"
          max-width="300"
          :src="this.track.album.images[0].url"
        />
        <h3
          class="mt-7"
          v-text="this.track.name"
        ></h3>
        <p v-text="`${this.track.artists[0].name} - ${this.track.album.name}`"></p>
      </div>

      <v-card-actions>
        <v-spacer />
        <v-btn
          color="primary"
          text
          @click="handleClosePickupModal"
        >
          この曲を歌う！
        </v-btn>
        <v-btn
          color="success"
          text
          :disabled="loading"
          @click="handlePickupTrack"
        >
          再ピックアップ
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
      dialog: false
    }
  },

  methods: {
    handlePickupTrack() {
      this.$emit('pickup-track')
    },

    handleClosePickupModal() {
      this.dialog = false
    }
  }
}
</script>

<style scoped>
</style>