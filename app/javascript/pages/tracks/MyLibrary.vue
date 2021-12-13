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
        @delete-track="handleDeleteTrack"
      >
        <template
          v-if="myLibrary.length === 0"
          v-slot:subheader
        >
          <v-subheader>
            まだ追加された曲はありません
          </v-subheader>
        </template>
        <template
          v-else
          v-slot:subheader
        >
          <v-subheader>
            {{ searchedTracks.length }}曲
          </v-subheader>
        </template>
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
      // myLibraryTracks: [],
      search: '',
      submitting: false
    }
  },

  components: {
    TracksListCard
  },

  computed: {
    ...mapGetters("myLibrary", ["myLibrary"]),

    // sortTracks() {
    //   return this.myLibraryTracks.sort((a,b) => a.index - b.index)
    // },

    searchedTracks() {
      return this.myLibrary.filter(track => {
        return track.name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.artist_name.toLowerCase().indexOf(this.search.toLowerCase()) != -1 || track.album_name.toLowerCase().indexOf(this.search.toLowerCase()) != -1
      })
    }
  },

  // watch: {
  //   // myLibrary() {
  //   //   const added = this.myLibraryTracks.some(myLibraryTrack => {
  //   //     return this.myLibrary.indexOf(myLibraryTrack.id)
  //   //   })

  //   //   this.myLibrary.forEach((myTrack, index) => {
  //   //     this.$axios.post("tracks/my-library",{ track_id: myTrack.track_id })
  //   //       .then(response => {
  //   //         if (!added) {
  //   //           response.data["index"] = index
  //   //           this.myLibraryTracks.push(response.data)
  //   //         }
  //   //       })
  //   //       .catch(error => {
  //   //         this.$store.dispatch("flashMessages/showMessage",
  //   //           {
  //   //             message: "ライブラリの読み込みに失敗しました",
  //   //             type: "error",
  //   //             status: true
  //   //           }
  //   //         )
  //   //         console.log(error)
  //   //       })
  //   //   })
  //   // }
  // },

  created() {
    this.fetchTracks()
  },

  methods: {
    ...mapActions("myLibrary", [
      "fetchTracks",
      // "addTrack",
      "deleteTrack",
    ]),

    // async handleAddTrack(addTrack) {
    //   this.submitting = true
    //   try {
    //     await this.addTrack(addTrack)
    //     this.submitting = false
    //     this.$store.dispatch("flashMessages/showMessage",
    //       {
    //         message: "マイライブラリに追加しました",
    //         type: "blue lighten-1",
    //         status: true
    //       }
    //     )
    //   } catch(error) {
    //     this.submitting = false
    //     this.$store.dispatch("flashMessages/showMessage",
    //       {
    //         message: "追加に失敗しました",
    //         type: "error",
    //         status: true
    //       }
    //     )
    //     console.log(error)
    //   }
    // },

    async handleDeleteTrack(deleteTrack) {
      this.submitting = true
      try {
        await this.deleteTrack(deleteTrack)
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