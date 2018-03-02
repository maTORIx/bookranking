import Vue from "vue/dist/vue.min.js"
import tools from "./tools.js"
console.log("books.js")

document.addEventListener("DOMContentLoaded", function(){
  var app = new Vue({
    el: "#app",
    data: {
      notifies: [],
      judged_star: "",
      rated_star: document.getElementById("star"),
    },
    methods: {
      judgeStar : function(e) {
        var X = e.layerX;
        var rating = Math.floor((X - 1) / 21) + 1
        var result = ""
        for(var i = 0; i < rating; i++) {
          result += "★"
        }
        this.judged_star = result
      },
      stopJudge : function() {
        this.judged_star = ""
      },
      sendStar: function(stars){
        fetch(`${document.URL}/easy_reviews`, {
          method: "POST",
          credentials: "same-origin",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": tools.getCsrfToken()
          },
          body: JSON.stringify({"point": stars.length})
        }).then((resp) => {
          if (resp.status >= 200 && resp.status <= 300) {
            this.notifies.push("投票しました")
            return
          } else if(resp.status == 403) {
            throw "すでに投票しています"
          } else {
            throw "エラーが発生しました"
          }
        }).catch((e) => {
          console.error(e)
          this.notifies.push(e)
        })
      },
      redirect_to: function(url) {
        location.href = url
      }
    }
  })
})

