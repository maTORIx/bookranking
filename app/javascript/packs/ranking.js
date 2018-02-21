import Vue from "vue/dist/vue.min.js"
import tools from "./tools.js"
console.log("default.js")

document.addEventListener("DOMContentLoaded", function(){
  var app = new Vue({
    el: "#app",
    data: {
      condition_form: {kind: "", name: ""},
      condition: this.getCondition(),
      condition_kind: {"著者": "authors", "カテゴリ": "categories", "タグ": "tags"}
    },
    methods: {
      addCondition: function() {
        event.preventDefault()
        var kind = this.condition_kind[app.condition_form.kind]
        var name = this.condition_form.name
        this.condition[kind].push(name)
        this.condition_form = {kind: "", name: ""}
      },
      getCondition: function() {
        var condition = {tags: [], authors: [], categories: [], order_param: "score", order: "desc"}
        location.search.substring(1).split('&').forEach((param) => {
          var params = param.split("=")
          condition[params[0]] = params[1].split(",")
        })
        return condition
      }
    }
  })
})
