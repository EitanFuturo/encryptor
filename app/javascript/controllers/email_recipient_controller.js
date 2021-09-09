 import { Controller } from 'stimulus'

 export default class extends Controller {
    static targets = ['input']

    showEmailRecipient() {
        const input = this.inputTarget
        input.classList.toggle('hidden')
    }
 }