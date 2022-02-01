<template>
  <div>
    <v-btn
      color="green accent-3"
      outlined
      @click.stop="handlePickupTrack"
    >
      <v-icon>mdi-music-circle-outline</v-icon>
      ピックアップ
    </v-btn>
    <v-fab-transition>
      <v-btn
        v-show="visible"
        color="green accent-3"
        fab
        fixed
        bottom
        right
        large
        @click.stop="handlePickupTrack"
        class="mb-13"
        id="pickup-fab"
      >
        <v-icon>mdi-music-note</v-icon>
      </v-btn>
    </v-fab-transition>
    <v-dialog
      max-width="400"
      v-model="dialog"
      id="pickup-modal"
    >
      <v-card v-if="this.tracks.length >= 1">
        <v-card-title class="text-h5">
          結果
        </v-card-title>

        <v-divider />

        <div class="d-flex flex-column justify-space-between align-center mt-7 mb-4">
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
            class="mt-1 mx-6"
          >
          </p>
        </div>

        <v-card-actions>
          <v-btn
            color="green accent-3"
            class="px-0"
            text
            :disabled="loading"
            @click="handlePickupTrack"
          >
            もう一度！
          </v-btn>
          <v-btn
            color="light-blue accent-3"
            class="px-0"
            text
            :disabled="loading"
            @click="handleAddHistory"
          >
            この曲を歌う！
          </v-btn>
          <v-spacer />
          <v-btn
            color="error"
            text
            @click="handleClosePickupModal"
          >
            キャンセル
          </v-btn>
        </v-card-actions>
      </v-card>

      <v-card v-else>
        <v-card-title>楽曲を追加してからピックアップしてください</v-card-title>
        <div class="text-center my-5">
          <v-btn
            color="green accent-3"
            :to="{ name: 'Search' }"
            outlined
          >
            <v-icon>mdi-magnify</v-icon>
            楽曲検索画面へ
          </v-btn>
        </div>

        <v-card-actions>
          <v-spacer />
          <v-btn
            color="error"
            text
            @click="handleClosePickupModal"
          >
            閉じる
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  name: "PickupTrack",

  props: {
    track: {
      type: [Object, String]
    },

    loading: {
      type: Boolean,
      required: true
    },

    tracks: {
      type: Array,
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
    window.addEventListener("scroll", this.handleShowButton)
  },

  methods: {
    handlePickupTrack() {
      this.dialog = true
      this.$emit('pickup-track')
    },

    handleAddHistory() {
      this.$emit('history-track', this.track)
      this.dialog = false
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