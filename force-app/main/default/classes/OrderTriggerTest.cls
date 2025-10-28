
@isTest(SeeAllData=true)
public  class OrderTriggerTest {
    @isTest
    static void testOrderTriggerBeforeAfterUpdate() {

        Account acc = TestDataFactory.createAccount('Test Account');
        Product2 prod = TestDataFactory.createProduct('Chemise Verte', 'Chemise');
        Id pricebookId = TestDataFactory.getStandardPricebookId();
        PricebookEntry pbe = TestDataFactory.createPricebookEntry(prod.Id, pricebookId, 100);

         Order ord = TestDataFactory.createOrder(acc.Id, Date.today(), 'Draft', pricebookId, 20);
         OrderItem oi = TestDataFactory.createOrderItem(ord.Id, pbe.Id, 2, 100);
         // Mise à jour de l'ordre pour déclencher Before update
         ord.ShipmentCost__c = 20;
        Test.startTest();
        update ord;
        
         // Vérifier NetAmount__c (Before Update )
        ord.Status = 'Activated';
        update ord;
        Test.stopTest();
        // Vérification before update
        ord = [SELECT Id,NetAmount__c FROM Order WHERE Id = :ord.Id];
        System.assertEquals(180, ord.NetAmount__c, 'NetAmount__c devrait être TotalAmount - ShipmentCost');
        // Vérification after update
           acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id];
            System.assertEquals(200, acc.Chiffre_d_affaire__c, 'Le chiffre d\'affaire du compte doit être mis à jour après activation');






    }
}