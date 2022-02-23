<template>
  <v-card
    class="mx-auto"
    id="tracks-list"
  >
    <v-tabs
      v-model="tab"
      color="green accent-3"
      grow
    >
      <v-tab
        v-for="item in items"
        :key="item"
      >
        {{ item }}
      </v-tab>
    </v-tabs>

    <v-list subheader>

      <v-tabs-items v-model="tab">
        <v-tab-item>
          <slot
            name="subheader"
          ></slot>
          <v-list-item
            v-for="(track, index) in this.tracks"
            :key="index"
          >
            <v-list-item-avatar class="ml-1 mr-3">
              <v-img
                alt="Track image"
                :src="track.image_url"
              >
                <template v-slot:placeholder>
                  <v-row
                    class="fill-height ma-0"
                    align="center"
                    justify="center"
                  >
                    <v-progress-circular
                      indeterminate
                      color="white"
                    ></v-progress-circular>
                  </v-row>
                </template>
              </v-img>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title v-text="track.name"></v-list-item-title>
              <v-list-item-subtitle v-text="`${track.artist_name} - ${track.album_name}`"></v-list-item-subtitle>
            </v-list-item-content>

            <v-list-item-icon class="mr-1">
              <v-icon
                @click="handleDeleteTrack(track)"
                color="white"
                :disabled="submitting"
                id="delete-icon"
              >
                mdi-delete
              </v-icon>
            </v-list-item-icon>
          </v-list-item>
        </v-tab-item>

        <v-tab-item>
          <v-list-item
            v-for="(track, index) in this.recommendTracks"
            :key="index"
          >
            <v-list-item-avatar class="ml-1 mr-3">
              <v-img
                alt="Track image"
                :src="track.album.images[2].url"
              >
                <template v-slot:placeholder>
                  <v-row
                    class="fill-height ma-0"
                    align="center"
                    justify="center"
                  >
                    <v-progress-circular
                      indeterminate
                      color="white"
                    ></v-progress-circular>
                  </v-row>
                </template>
              </v-img>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title v-text="track.name"></v-list-item-title>
              <v-list-item-subtitle v-text="`${track.artists[0].name} - ${track.album.name}`"></v-list-item-subtitle>
            </v-list-item-content>

            <v-list-item-icon class="mr-1">
              <v-icon
                v-if="added(track.id)"
                @click="handleDeleteRecommendTrack(track)"
                color="white"
                :disabled="submitting"
                id="delete-icon"
              >
                mdi-delete
              </v-icon>
              <v-icon
                v-else
                @click="handleAddTrack(track)"
                color="white"
                :disabled="submitting"
                id="create-icon"
              >
                mdi-plus
              </v-icon>
            </v-list-item-icon>
          </v-list-item>
        </v-tab-item>
      </v-tabs-items>
    </v-list>
  </v-card>
</template>

<script>
export default {
  name: "TracksListCard",

  data() {
    return {
      items: ["ライブラリ", "おすすめ曲"],
      tab: 0
    }
  },

  props: {
    tracks: {
      type: Array,
      required: true
    },

    myLibrary: {
      type: Array,
      required: true
    },

    submitting: {
      type: Boolean,
      required: true
    },

    recommendTracks: {
      type: Array,
      required: true
    }
  },

  computed: {
    added() {
      return function(trackId) {
        return this.myLibrary.some(myTrack => {
          return myTrack.track_id == trackId
        })
      }
    }
  },

  watch: {
    tab: function() {
      this.$emit('tab-change', this.tab)
    }
  },

  methods: {
    handleAddTrack(addTrack) {
      this.$emit('add-track', addTrack)
    },

    handleDeleteTrack(deleteTrack) {
      this.$emit('delete-track', deleteTrack)
    },

    handleDeleteRecommendTrack(deleteTrack) {
      this.$emit('delete-recommend-track', deleteTrack)
    }
  }
}
</script>

<style scoped>
</style>