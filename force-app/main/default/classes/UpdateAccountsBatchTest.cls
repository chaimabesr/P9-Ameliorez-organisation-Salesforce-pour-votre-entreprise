@isTest(SeeAllData=true)
public class UpdateAccountsBatchTest {


    @isTest
    static void testBatchUpdatesAccounts() {
         
       
        Account acc = new Account(
        Name = 'Compte Test',
        Chiffre_d_affaire__c = 0  // Initialisé à zéro
);
        insert acc;

     Id pbId = TestDataFactory.getStandardPricebookId();
     Product2 prod = TestDataFactory.createProduct('Test Product', 'Software');
      
        PricebookEntry pbe = TestDataFactory.createPricebookEntry(prod.Id, pbId, 100);
        Order ord = TestDataFactory.createOrder(acc.Id, Date.today(), 'Draft', pbId, 10);

         OrderItem oi1 = TestDataFactory.createOrderItem(ord.Id, pbe.Id, 2, 50);   // Total 100
        OrderItem oi2 = TestDataFactory.createOrderItem(ord.Id, pbe.Id, 3, 200);  // Total 600
        ord.Status = 'Activated';
        update ord;
        Test.startTest();
        UpdateAccountsBatch batch = new UpdateAccountsBatch();
        Database.executeBatch(batch, 200);
        Test.stopTest();


     
        Account updatedAcc = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id];


        System.assertEquals(700, updatedAcc.Chiffre_d_affaire__c, 'Le Chiffre d\'affaire devrait être 700');
    }
}


