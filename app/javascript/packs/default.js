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
      }
    }
  })
})

