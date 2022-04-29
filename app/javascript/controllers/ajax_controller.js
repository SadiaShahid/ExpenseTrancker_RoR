import { Controller } from 'stimulus';
import axios from "axios";
export default class extends Controller {
    static targets = [ 
                      'table',
                      'transactions',
                      'notification',
                      'badge'
                    ]
  connect() {
    console.log("hello from ajax")
  }

  show(){
    axios({
      method: 'get',
      url: 'http://localhost:3000/api/v1/transactions.json',
      responseType: 'JSON'
    })
      .then(function(response) {
        var data = response.data
        var table=document.getElementById('table')
        table.innerHTML+='<thead><tr><th scope="col">Date</th><th scope="col">Amount</th><th scope="col">From</th><th scope="col">To</th><th scope="col">Type</th><th colspan="3"></th></tr></thead><tbody>'
        for(var i=0;i<data.length;i++)
        {
          table.innerHTML+='<tr><th scope="row">'+data[i].date+'</th><td scope="row">'+data[i].amount+'</td><td scope="row">'+data[i].transfer_from_type+'</td><td scope="row">'+data[i].transfer_to_type+'</td><td scope="row">'+data[i].type+'</td></tr>'
          
        }
        table.innerHTML+='</tbody></table>'
        var fetch = document.getElementById('fetch')
        fetch.classList.add('disabled')
    });
  }
  notify(){
    // getting transactions unread notifications
    var list=document.getElementById('list')
    axios({
      method: 'get',
      url: 'http://localhost:3000/notifications.json',
      responseType: 'JSON'
    })
      .then(function(response) {
        var notifications = response.data
        for(var i=0;i<notifications.length;i++)
        {
          list.innerHTML += '<li class="border-bottom"><p class="mx-2">Transaction of $'+notifications[i].transaction.amount+'&nbsp was created</p></li>'
        }
    });

    // mark notification read and setting count to 0
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common["X-CSRF-Token"] = csrfToken
    axios({
      method: 'post',
      url: 'http://localhost:3000/notifications/mark_as_read',
      })
      .then(function (response) {
        var bad=document.getElementById('bad')
        bad.innerHTML = 0
      })
      .catch(function (error) {
        console.log(error);
      });
  }
  notification()
  {
    axios({
      method: 'get',
      url: 'http://localhost:3000/notifications.json',
      responseType: 'JSON'
    })
      .then(function(response) {
        var notifications = response.data
        var bad=document.getElementById('bad')
        bad.innerHTML = notifications.length+1
      });
  }
  makeTransaction(){
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common["X-CSRF-Token"] = csrfToken
    axios({
      method: 'post',
      url: 'http://localhost:3000/transactions',
      data: {
        date: this.dateTarget.value,
        type: this.transferTypeTarget.value
      }
      })
      .then(function (response) {
        var amount = document.getElementById("transaction_amount");
        var category = document.getElementById("transaction_category");
        var account = document.getElementById("transaction_transactionable_type");
        var from = document.getElementById("transaction_transfer_from_type");
        var to = document.getElementById("transaction_transfer_to_type");
        amount.value = '';
        category.value = '';
        account.value = '';
        from.value = '';
        to.value = '';
        amount.focus();
      })
      .catch(function (error) {
        console.log(error);
      });
  }
}
