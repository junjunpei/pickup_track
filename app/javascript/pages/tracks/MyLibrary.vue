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
      <TracksListCard
        :tracks="searchedTracks"
        :library="myLibrary"
        :submitting="submitting"
        @create-track="handleCreateTrack"
        @delete-track="handleDeleteTrack"
      >
      </TracksListCard>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import TracksListCard from "./components/TracksListCard"

export default {
  name: "MyLibrary",

  data() {
    return {
      myLibraryTracks: [],
      search: '',
      submitting: false
    }
  },

  components: {
    TracksListCard
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
      "createTrack",
      "deleteTrack",
    ]),

    async handleCreateTrack(trackId) {
      this.submitting = true
      try {
        await this.createTrack(trackId)
        this.submitting = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "マイライブラリに追加しました",
            type: "blue lighten-1",
            status: true
          }
        )
      } catch(error) {
        this.submitting = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "追加に失敗しました",
            type: "error",
            status: true
          }
        )
        console.log(error)
      }
    },

    async handleDeleteTrack(trackId) {
      this.submitting = true
      try {
        await this.deleteTrack(trackId)
        this.submitting = false
        this.$store.dispatch("flashMessages/showMessage",
          {
            message: "マイライブラリから削除しました",
            type: "pink lighten-1",
            status: true
          }
        )
      } catch(error) {
        this.submitting = false
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