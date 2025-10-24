import { LightningElement, api, track } from 'lwc';
import getSumOrdersByAccount from '@salesforce/apex/OrdersController.getSumOrdersByAccount';

// TODO - récupérer la méthode apex permettant de faire ce calcul

export default class OrdersSummary extends LightningElement {

    @track sumOrdersOfCurrentAccount  ;
    @api recordId;
    @track isLoading = true;

    connectedCallback() {
        this.fetchSumOrders();
    }

    fetchSumOrders() {
        // TODO - récupérer le montant total des Orders sur le compte avec la méthode apex
        getSumOrdersByAccount({accountIds: [this.recordId]})
        .then(result => {
            if (result && result.length > 0) {
            this.sumOrdersOfCurrentAccount = result[0].total;
            } else {
                this.sumOrdersOfCurrentAccount = 0;
            }

        })
        .catch(error => {
            console.error('Erreur récupération montant total des Orders :', error);
            this.sumOrdersOfCurrentAccount = 0;
        })
    
               
         .finally(() => {
             this.isLoading = false;
        });
    }
   get hasOrders() {
        return this.sumOrdersOfCurrentAccount  > 0;
    }
} 
