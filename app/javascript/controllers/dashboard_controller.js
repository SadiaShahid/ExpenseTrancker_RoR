import { Controller } from 'stimulus';
import axios from "axios";
export default class extends Controller {
    static targets = ['transactionForm',
                      'category',
                      'transferType',
                      'fromAccount',
                      'toAccount',
                      'account',
                      'fromtheAccount',
                      'totheAccount',
                      'dashActive',
                      'transActive',
                      'catReq',
                      'transReq',
                      'date',
                      'addBtn',
                      'transactions',
                      'amount'

                    ]
  connect() {
    console.log("hello from StimulusJS")
  }

  show(event)
  {
    this.addBtnTarget.classList.remove('d-none')
    console.log(event.target.dataset.value)
    const formatYmd = date => date.toISOString().slice(0, 10);
    var d = formatYmd(new Date(event.target.dataset.value));  
    console.log(this.dateTarget.value)
    this.dateTarget.value = event.target.dataset.value
    console.log(this.dateTarget.value)

  }
  income(event) {

    this.transactionFormTarget.classList.remove('d-none')

    if(event.currentTarget.innerText == "Income") {
      this.categoryTarget.classList.add('d-none')
      this.accountTarget.classList.remove('d-none')
      this.transferTypeTarget.value = 'Income'
      this.fromAccountTarget.classList.add('d-none')
      this.toAccountTarget.classList.add('d-none')
      this.catReqTarget.removeAttribute('required')
      this.fromtheAccountTarget.removeAttribute('required')
      this.totheAccountTarget.removeAttribute('required')
      
    } else if (event.currentTarget.innerText == "Expense") {
      this.categoryTarget.classList.remove('d-none')
      this.accountTarget.classList.remove('d-none')
      this.transferTypeTarget.value = 'Expense'
      this.fromAccountTarget.classList.add('d-none')
      this.toAccountTarget.classList.add('d-none')
      this.catReqTarget.setAttribute('required','required')
      this.fromtheAccountTarget.removeAttribute('required')
      this.totheAccountTarget.removeAttribute('required')
      
    } else {
      this.categoryTarget.classList.add('d-none')
      this.transferTypeTarget.value = 'BankTransfer'
      this.accountTarget.classList.add('d-none')
      this.fromAccountTarget.classList.remove('d-none')
      this.toAccountTarget.classList.remove('d-none')
      this.catReqTarget.removeAttribute('required')
      this.categoryTarget.disabled = true
      this.transReqTarget.removeAttribute('required')
      this.fromtheAccountTarget.setAttribute('required','required')
      this.totheAccountTarget.setAttribute('required','required')
    }

  }

  handleChange ()
  {
    if(this.fromtheAccountTarget.options[1].selected)
    {
      this.totheAccountTarget.options[1].hidden = true
    }
  }
  activeTab()
  {
    console.log("hello from activeTab")
    this.dashActiveTarget.classList.remove('active')
    this.transActiveTarget.classList.add('active')
  }

  hideForm()
  {
    this.transactionFormTarget.classList.add('d-none')
  }


  submitform(){
    this.transactionsTarget.innerHTML +='<tr><th scope="row">'+this.dateTarget.value+'</th><td scope="row">'+this.amountTarget.value+'</td><td scope="row">'+this.transferTypeTarget.value+'</td><td scope="row"></td></tr>'
  }

  makeTransaction(){
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common["X-CSRF-Token"] = csrfToken
    axios({
      method: 'post',
      url: 'http://localhost:3000/transactions',
      data: {
        date: this.dateTarget.value,
        type: this.transferTypeTarget.value,
        amount: this.amountTarget.value,
        category: this.catReqTarget.value,
        transactionable_type: this.transReqTarget.value,
        transfer_from_type: this.fromtheAccountTarget.value,
        transfer_to_type: this.totheAccountTarget.value
      }
      })
      .then(function (response) {
      })
      .catch(function (error) {
        console.log(error);
      });
     

  }
}
