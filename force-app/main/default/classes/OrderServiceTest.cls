@isTest
public with sharing class OrderServiceTest {
    @isTest
    static void testUpdateAccount() {
        // Create test data
        Account acc = TestDataFactory.createAccount('Test Account');
        Product2 prod = TestDataFactory.createProduct('Test Product', 'Test Family');
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry pbe = TestDataFactory.createPricebookEntry(prod.Id, pricebookId, 100);
        

         Order oldOrder = new Order(
            AccountId = acc.Id,
            Status = 'Draft',
            Pricebook2Id = pricebookId,
            ShipmentCost__c = 50,
            EffectiveDate = Date.today(),
            Name = 'Old Order'
        );
        insert oldOrder;
        OrderItem oi1 = TestDataFactory.createOrderItem(oldOrder.Id, pbe.Id, 2, 100); // Total 200
        OrderItem oi2 = TestDataFactory.createOrderItem(oldOrder.Id, pbe.Id, 3, 150); // Total 450
        
        Order newOrder = new Order(
            Id = oldOrder.Id,
            Status = 'Activated'
        );
        update newOrder;

        
         List<Order> newOrders = new List<Order>{ newOrder };
        Map<Id, Order> oldOrderMap = new Map<Id, Order>{ oldOrder.Id => oldOrder };



         Test.startTest();
         
        List <Id> orderUpdated = OrderService.orderStatusChanged(newOrders, oldOrderMap);
       System.debug('Order IDs mis à jour : ' + orderUpdated);
        OrderService.updateAccount(orderUpdated );
         Test.stopTest();
        // Verify the account's Chiffre_d_affaire__c is updated correctly 
        Account updatedAcc = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(650, updatedAcc.Chiffre_d_affaire__c, 'Le Chiffre d\'affaire devrait être mis à jour à 650');





    }
    
}