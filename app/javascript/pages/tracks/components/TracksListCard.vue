<template>
  <v-card
    class="mx-auto"
    id="tracks-list"
  >
    <v-list subheader>
      <slot
        name="subheader"
      ></slot>
      <div v-if="this.$route.name === 'Search'">
        <v-list-item
          v-for="(track, index) in this.tracks"
          :key="index"
        >
          <v-list-item-avatar class="ml-1 mr-3">
            <v-img
              alt="Track image"
              :src="track.album.images[2].url"
            ></v-img>
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title v-text="track.name"></v-list-item-title>
            <v-list-item-subtitle v-text="`${track.artists[0].name} - ${track.album.name}`"></v-list-item-subtitle>
          </v-list-item-content>

          <v-list-item-icon class="mr-1">
            <v-icon
              v-if="added(track.id)"
              @click="handleDeleteTrack(track)"
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
      </div>
      <div v-else-if="this.$route.name === 'MyLibrary'">
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
              v-if="added(track.track_id)"
              @click="handleDeleteTrack(track)"
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
      </div>
    </v-list>
  </v-card>
</template>

<script>
export default {
  name: "TracksListCard",

  props: {
    tracks: {
      type: Array,
      required: true
    },

    library: {
      type: Array,
      required: true
    },

    submitting: {
      type: Boolean,
      required: true
    }
  },

  computed: {
    added() {
      return function(trackId) {
        return this.library.some(myTrack => {
          return myTrack.track_id == trackId
        })
      }
    }
  },

  methods: {
    handleAddTrack(addTrack) {
      this.$emit('add-track', addTrack)
    },

    handleDeleteTrack(deleteTrack) {
      this.$emit('delete-track', deleteTrack)
    }
  }
}
</script>