public with sharing class OrderService {
  // séléctionner les orders qui ont changer les status  vers activated
    //  extraire les accounts liés à ces orders
    //  mettre à jour le CA de ces accounts

    public static List <Id> orderStatusChanged (List<Order> newOrders, Map<Id, Order> oldOrderMap ){
    List <Id> OrdersId = new List <Id>();
    for (Order ord:newOrders)
    {
        if (ord.Status == 'Activated' &&  oldOrderMap.get(ord.Id).Status != 'Activated'){
            OrdersId.add(ord.Id);    
        }
    }
    return OrdersId;
}
   @AuraEnabled(cacheable=true)
public static void updateAccount (List<Id> orderIds){
    List<Account> accToUpdate = AccountSelector.getAccountByOrderIds(orderIds);
    Set<Id> accIdSet= new Map <Id,Account>(accToUpdate).keySet();
    List<AggregateResult> totalResults = OrdersController.getSumOrdersByAccount(new List<Id>(accIdSet));
    List<Account> accUpdated = new List<Account>();
    for (Account acc:accToUpdate){
         Decimal sumTotalAmount = 0;
        for (AggregateResult ar:totalResults){
            if (acc.Id == (Id)ar.get('AccountId')){
                 sumTotalAmount = (Decimal) ar.get('total');
               
            }
        }

       acc.Chiffre_d_affaire__c = sumTotalAmount;
        accUpdated.add(acc);
    }
    if (!accUpdated.isEmpty()){
        update accUpdated;
    }


}
}