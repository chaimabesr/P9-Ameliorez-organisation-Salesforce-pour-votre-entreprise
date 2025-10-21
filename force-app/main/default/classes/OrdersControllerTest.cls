
@isTest
public with sharing class OrdersControllerTest {
    @isTest
    static void testGetSumOrdersByAccount() {


        Account acc1 = TestDataFactory.createAccount('Test Account 1');
        Product2 prod = TestDataFactory.createProduct('Produit Test', 'Famille Test');
         Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry pbe = TestDataFactory.createPricebookEntry(prod.Id, pricebookId, 100);
        Order ord1 = TestDataFactory.createOrder(acc1.Id, Date.today(), 'Draft', pricebookId,50);
        OrderItem oi1 = TestDataFactory.createOrderItem(ord1.Id, pbe.Id, 2, 100); 
        OrderItem oi2 = TestDataFactory.createOrderItem(ord1.Id, pbe.Id, 1, 500); 
        ord1.Status = 'Activated';
        update ord1;

           List<Id> accIds = new List<Id>{ acc1.Id };

           Test.startTest();
              List<AggregateResult> results = OrdersController.getSumOrdersByAccount(accIds);
           Test.stopTest();

           Decimal total = (Decimal)results[0].get('total');
              System.assertEquals(700, total, 'Le montant total des commandes devrait être 700');
}
}