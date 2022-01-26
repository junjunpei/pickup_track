<template>
  <v-card
    class="mx-auto"
    id="tracks-list"
  >
    <v-list>
      <slot
        name="subheader"
      ></slot>
      <v-col cols="7" lg="4" md="4" sm="4">
        <v-select
          v-model="orderStatus"
          outlined
          dense
          :items="order"
          class="mb-n5"
        ></v-select>
      </v-col>

      <div v-if="orderStatus == '新着順'">
        <v-list-item
          v-for="(track, index) in this.tracks"
          :key="index"
        >
          <v-list-item-avatar class="ml-1 mr-3">
            <v-img
              alt="Track image"
              :src="track.image_url"
            ></v-img>
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title v-text="track.name"></v-list-item-title>
            <v-list-item-subtitle v-text="`${track.artist_name} - ${track.album_name}`"></v-list-item-subtitle>
          </v-list-item-content>

          <v-list-item-icon class="mr-1">
            <v-icon
              @click="handleDeleteHistoryTrack(track)"
              :disabled="submitting"
              id="delete-history-icon"
            >
              mdi-delete-clock
            </v-icon>
          </v-list-item-icon>
        </v-list-item>
      </div>

      <div v-else-if="orderStatus == '回数が多い順'">
        <v-list-item
          v-for="(track, index) in this.tracksTimes"
          :key="index"
        >
          <v-list-item-avatar class="ml-1 mr-3">
            <v-img
              alt="Track image"
              :src="track[0][4]"
            ></v-img>
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title v-text="track[0][1]"></v-list-item-title>
            <v-list-item-subtitle v-text="`${track[0][2]} - ${track[0][3]}`"></v-list-item-subtitle>
          </v-list-item-content>

          <p>{{ track[1] }}回</p>
        </v-list-item>
      </div>
    </v-list>
  </v-card>
</template>

<script>
export default {
  name: "HistoryTracksList",

  data() {
    return {
      order: ["新着順", "回数が多い順"],
      orderStatus: "新着順"
    }
  },

  props: {
    tracks: {
      type: Array,
      required: true
    },

    submitting: {
      type: Boolean,
      required: true
    },

    tracksTimes: {
      type: [Array, String],
      requred: true
    }
  },

  methods: {
    handleDeleteHistoryTrack(deleteTrack) {
      this.$emit("delete-history-track", deleteTrack)
    }
  }
}
</script>

<style scoped>
</style>