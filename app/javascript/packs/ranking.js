import Vue from "vue/dist/vue.min.js"
import tools from "./tools.js"
console.log("default.js")

document.addEventListener("DOMContentLoaded", function(){
  var app = new Vue({
    el: "#app",
    data: {
      condition_edit: false,
      condition_form: {kind: "タグ", name: ""},
      condition: getCondition(),
      condition_kind: {"著者": "authors", "カテゴリ": "categories", "タグ": "tags"}
    },
    methods: {
      addCondition: function() {
        event.preventDefault()
        var kind = this.condition_kind[app.condition_form.kind]
        var name = this.condition_form.name
        if(!this.condition[kind].includes(name)) {
          this.condition[kind].push(name)
        }
        this.condition_form["name"] = ""
      },
      searchCondition: function() {
        var params = `order=${this.condition.order}&order_param=${this.condition.order_param}`
        if(this.condition.tags.length > 0) {
          params = params + `&tags=${this.condition.tags.join("+")}`
        }
        if(this.condition.authors.length > 0) {
          params = params + `&authors=${this.condition.authors.join("+")}`
        }
        if(this.condition.categories.length > 0) {
          params = params + `&categories=${this.condition.categories.join("+")}`
        }
        var url = `/rankings?${params}`
        location.href = url
      },
      deleteCondition: function(kind, name) {
        this.condition[kind].splice(this.condition[kind].indexOf(name), 1)
      }
    }
  })

  function getCondition() {
    var condition = {tags: [], authors: [], categories: [], order_param: "score", order: "desc"}
    location.search.substring(1).split('&').forEach((param) => {
      var params = param.split("=")
      if(["tags", "authors", "categories"].includes(params[0])) {
        condition[params[0]] = params[1].split("+").map((cond) => {
          return decodeURI(cond)
        })
      } else {
        condition[params[0]] = params[1]
      }
    })
    return condition
  }
})
