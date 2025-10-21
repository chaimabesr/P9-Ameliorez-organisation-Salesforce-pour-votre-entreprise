import { LightningElement, api, track } from 'lwc';
import getSumOrdersByAccount from '@salesforce/apex/OrdersController.getSumOrdersByAccount';

// TODO - récupérer la méthode apex permettant de faire ce calcul

export default class Orders extends LightningElement {

    @track sumOrdersOfCurrentAccount;
    @api recordId;

    connectedCallback() {
        this.fetchSumOrders();
    }

    fetchSumOrders() {
        // TODO - récupérer le montant total des Orders sur le compte avec la méthode apex
        getSumOrdersByAccount({accountId: this.recordId})
        .then(result => {
            this.sumOrdersOfCurrentAccount = result;
        })
        .catch(error => {
            console.error('Erreur récupération montant total des Orders :', error);
            this.sumOrdersOfCurrentAccount = null;
        });
    }
    
}