import Vue from "vue/dist/vue.min.js"
console.log("books.js")

document.addEventListener("DOMContentLoaded", function(){
  var app = new Vue({
    el: "#app",
    data: {
      judged_star: "",
      rated_star: document.getElementById("star"),
      message: "Hello world !!!!!!!!!!"
      },
    methods: {
      judgeStar : function(e) {
        this.rated_star.style.display = "none"
        var X = e.layerX;
        var rating = Math.floor((X - 1) / 21) + 1
        console.log(X, rating) 
        var result = ""
        for(var i = 0; i < rating; i++) {
          result += "★"
        }
        this.judged_star = result
      },
      stopJudge : function() {
        this.rated_star.style.display = "block"
        this.judged_star = ""
      },
      sendStar: function(stars){
        console.log(`${document.URL}/stars`)
      },
      redirect_to: function(url) {
        location.href = url
      }
    }
  })
  //var star_back = document.getElementById("star-back")
  //var star = document.getElementById("star-rating")

  //star_back.addEventListener("mouseover", function(e) {
  //  star.style.visibility = "visible"
  //  var X = e.layerX;
  //  var rating = Math.floor((X - 1) / 21) + 1
  //  console.log(X, rating) 
  //  star.style.width = `${rating * 21}px`
  //})

  //star.addEventListener("mouseout", function(e) {
  //  star.style.visibility = "hidden"
  // })
})

