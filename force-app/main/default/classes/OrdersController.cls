public with sharing class OrdersController {
    
    // TODO - Corriger l'erreur ici, nous retournons le montant TOTAL de tous les "Orders" 
    // mais nous souhaitons retourner le montant TOTAL des orders  aux status = 'Activated' du compte sur lequel le composant LWC se situe
    @AuraEnabled(cacheable=true)
    public static List<AggregateResult> getSumOrdersByAccount(List<Id> accountIds) {
        List<AggregateResult> groupedResults = [SELECT SUM(TotalAmount) total,AccountId FROM Order WHERE Status = 'Activated'AND AccountId IN :accountIds Group By AccountId];
        return groupedResults;
    }
    
}