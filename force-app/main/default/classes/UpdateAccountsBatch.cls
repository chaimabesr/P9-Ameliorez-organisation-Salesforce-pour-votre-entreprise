global class UpdateAccountsBatch implements Database.Batchable<sObject>,Schedulable{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Activated'
        return Database.getQueryLocator([SELECT Id,(SELECT Id FROM Orders) FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Activated' )]);
 
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){
        Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
        // Appeler une class qui va faire la logique du code;
        List<Order> relatedOrders=[ SELECT Id FROM Order WHERE Status ='Activated' AND AccountId IN :setAccountIds];

        List<Id>orderIds =new List<Id>();
        for(Order ord:relatedOrders){
            orderIds.add(ord.Id);
        }   
        if (!orderIds.isEmpty()){
            OrderService.updateAccount(orderIds);
        }

    }
    global void finish(Database.BatchableContext info){     
        
    } 
    global void execute(SchedulableContext sc) {
       UpdateAccountsBatch   batch = new UpdateAccountsBatch ();
        Database.executeBatch(batch, 200);
    }
 }