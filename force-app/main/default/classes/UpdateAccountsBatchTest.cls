@isTest
public class UpdateAccountsBatchTest {

    @isTest
    static void testBatchUpdatesAccounts() {
       
        Account acc = new Account(
        Name = 'Compte Test',
        Chiffre_d_affaire__c = 0  // Initialisé à zéro
);
        insert acc;

       
        Order ord = new Order(
            AccountId = acc.Id,
            Status = 'Draft',
            EffectiveDate=Date.today(),
            Name = 'Commande Test'
        );
        insert ord;
        ord.Status = 'Activated';
        update ord;
        Test.startTest();
        UpdateAccountsBatch batch = new UpdateAccountsBatch();
        Database.executeBatch(batch, 200);
        Test.stopTest();

      
        Account updatedAcc = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id = :acc.Id];

        System.assertNotEquals(null, updatedAcc.Chiffre_d_affaire__c, 'Le champ Chiffre_d_affaire__c ne doit pas être null');
    }
}
