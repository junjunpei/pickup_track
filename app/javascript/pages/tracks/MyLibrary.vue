<template>
  <div
    id="my-library"
    class="col-lg-6 offset-lg-3"
  >
    <v-container>
      <div class="h2 mt-1 mb-5">
        マイライブラリ
      </div>
      <v-text-field
        v-model="search"
        type="text"
        filled
        clearable
        label="Search"
        clear-icon="mdi-close-thick"
        @click:clear="clearSearch"
      >
        <template v-slot:prepend-inner>
          <v-icon>mdi-magnify</v-icon>
        </template>
      </v-text-field>
      <v-card
        class="mx-auto"
        id="tracks-list"
      >
        <v-list subheader>
          <v-subheader
            v-if="this.myLibrary.length == 0"
          >
            まだ追加された曲がありません
          </v-subheader>
          <v-list-item
            v-else
            v-for="(myTrack, index) in searchedTracks"
            :key="index"
          >

            <v-list-item-avatar class="mr-3">
              <v-img
                alt="Track image"
                :src="myTrack.album.images[2].url"
              ></v-img>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title v-text="myTrack.name"></v-list-item-title>
              <v-list-item-subtitle v-text="`${myTrack.artists[0].name} - ${myTrack.album.name}`"></v-list-item-subtitle>
            </v-list-item-content>

            <v-list-item-icon class="mr-4">
              <v-icon
                @click="handleDeleteTrack(myTrack.id)"
                color="white"
              >
                mdi-delete
              </v-icon>
            </v-list-item-icon>

          </v-list-item>
        </v-list>
      </v-card>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "MyLibrary",

  data() {
    return {
      myLibraryTracks: [],
      search: ''
    }
  },

  computed: {
    ...mapGetters("myLibrary", ["myLibrary"]),

    sortTracks() {
      return this.myLibraryTracks.sort((a,b) => a.index - b.index)
    },

    searchedTracks() {
      return this.sortTracks.filter(track => {
        return track.name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.artists[0].name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.album.name.toLowerCase().indexOf(this.search.toLowerCase()) != -1
      })
    }
  },

  watch: {
    myLibrary() {
      const added = this.myLibraryTracks.some(myLibraryTrack => {
        return this.myLibrary.indexOf(myLibraryTrack.id)
      })

      this.myLibrary.forEach((myTrack, index) => {
        this.$axios.post("tracks/my-library",{ track_id: myTrack.track_id })
          .then(response => {
            if (!added) {
              response.data["index"] = index
              this.myLibraryTracks.push(response.data)
            }
          })
          .catch(error => {
            console.log(error)
          })
      })
    }
  },

  created() {
    this.fetchTracks()
  },

  methods: {
    ...mapActions("myLibrary", [
      "fetchTracks",
      "deleteTrack",
    ]),

    async handleDeleteTrack(trackId) {
      try {
        await this.deleteTrack(trackId)
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "マイライブラリから削除しました",
            type: "pink lighten-1",
            status: true
          }
        )
      } catch(error) {
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "削除に失敗しました",
            type: "error",
            status: true
          }
        )
        console.log(error)
      }
    },

    clearSearch() {
      this.search = ''
    }
  }
}
</script>

<style scoped>
</style>