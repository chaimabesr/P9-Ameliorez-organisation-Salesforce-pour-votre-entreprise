public with sharing class AccountSelector {
   
    // Méthode pour récupérer les comptes liés aux IDs de commandes donnés

    @AuraEnabled
    public static List<Account> getAccountByOrderIds(List<Id> orderIds) {

        return [SELECT Id, Name, Chiffre_d_affaire__c 
                FROM Account 
                WHERE Id IN (SELECT AccountId FROM Order WHERE Id IN :orderIds)];
    }
}