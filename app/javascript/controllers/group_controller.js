import { Controller } from 'stimulus';
export default class extends Controller {
    static targets = [ 
                      'payers',
                      'amount',
                      'payable',
                      'user',
                      'payersFields',
                      'radio',
                      'paid',
                      'btn',
                      'type'
                    ]
  connect() {
    console.log("hello from group")
  }
  
  check(){
    let ch = this.payersTargets
    
    let c = this.payersTargets.filter(checkbox => checkbox.checked)
    
    for (let i = 0; i < ch.length; i++){
      // debugger
      if (ch[i].checked)
      { 
        if(this.typeTarget.options[1].selected)
        {
          // debugger
          this.payableTargets[i].value = this.amountTarget.value/c.length
          this.payableTargets[i].setAttribute('readonly','readonly')

        }
        else
        {
          
          this.payableTargets[i].removeAttribute('readonly')
        }
        this.paidTargets[i].removeAttribute('readonly')
      }
      else
      {
        
        this.payableTargets[i].value = 0.0
        this.payableTargets[i].setAttribute('readonly','readonly')
        this.paidTargets[i].setAttribute('readonly','readonly')
      }
    }
  }
  confirm(){
    this.check()
    
    var sum=0
    var sum_pay=0
    if(this.typeTarget.options[3].selected)
    {
      for (let i = 0; i < this.paidTargets.length; i++){
        sum+=parseFloat(this.paidTargets[i].value)
        sum_pay+=parseFloat(this.payableTargets[i].value)
      }
      if(sum == 100 && sum_pay == 100){
        this.btnTarget.removeAttribute('disabled')
      }
      else
        this.btnTarget.setAttribute('disabled','disabled')
    }
    else
    {
      for (let i = 0; i < this.paidTargets.length; i++){
        sum+=parseFloat(this.paidTargets[i].value)
        sum_pay+=parseFloat(this.payableTargets[i].value)

      }
      console.log(sum_pay)
      if(this.amountTarget.value == sum && this.amountTarget.value == sum_pay){
        this.btnTarget.removeAttribute('disabled')
      }
      else
        this.btnTarget.setAttribute('disabled','disabled')
    }
  }
  
}