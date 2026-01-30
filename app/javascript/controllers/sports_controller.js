import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["teamSelect"]
  
  connect() {
    this.loadTeams()
  }
  
  change(event) {
    this.loadTeams()
  }
  
  loadTeams() {
    let sportSelect = document.getElementById("sport_select")
    let sport = sportSelect.selectedOptions[0].value
    let target = this.teamSelectTarget.id 
    
    if (sport) {
      get(`/player_profile/sign_up/equipas?target=${target}&sport=${sport}`, {
        responseKind: "turbo-stream"
      })
    }
  }
}