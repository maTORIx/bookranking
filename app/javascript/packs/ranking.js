import Vue from "vue/dist/vue.min.js"
import tools from "./tools.js"
console.log("default.js")

document.addEventListener("DOMContentLoaded", function(){
  var app = new Vue({
    el: "#app",
    data: {
      notifies: [],
    },
    methods: {
      redirect_to : function(url) {
        location.href = url
      },
      to_book_shelf: function(book_id){
        fetch(`/books/${book_id}/bookshelf`, {
          method: "POST",
          credentials: "same-origin",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": tools.getCsrfToken()
          }
        }).then((resp) => {
          if(resp.ok) {
            notifies.push("本棚に追加しました")
          } else {
            if(resp.status == 403) {
              notifies.push("既に本棚に追加しています")
            } else {
              notifie.push("エラーが発生しました")
            }
          }
        }
      }
    }
  })
})
