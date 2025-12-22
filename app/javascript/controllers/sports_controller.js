import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"


export default class extends Controller {
  static targets = ["teamSelect"]
  change(event) {
    let sport = event.target.selectedOptions[0].value
    let target = this.teamSelectTarget.id
    
    get(`/player_profile/sign_up/equipas?target=${target}&sport=${sport}`, {
      responseKind: "turbo-stream"
    })
  }
}
