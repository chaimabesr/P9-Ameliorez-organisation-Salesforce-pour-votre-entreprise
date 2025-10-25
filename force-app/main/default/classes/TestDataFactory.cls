public with sharing class TestDataFactory {
    public static Account createAccount(String name){
        Account acc = new Account(
            Name = name
            
        );
        insert acc;
        return acc;
    }
    public static Product2 createProduct(String name, String family) {
        Product2 prod = new Product2(
            Name = name,
            Family = family,
            IsActive = true
        );
        insert prod;
        return prod;
    }
       public static PricebookEntry createPricebookEntry(Id productId, Id pricebookId, Decimal unitPrice) {
        PricebookEntry pbe = new PricebookEntry(
            Product2Id = productId,
            Pricebook2Id = pricebookId,
            UnitPrice = unitPrice,
            IsActive = true
        );
        insert pbe;
        return pbe;
    }
    public static Order createOrder(Id accountId, Date effectiveDate ,  String status,  Id pricebookId,Decimal shipmentCost) {
         if (pricebookId == null) {
        pricebookId = getStandardPricebookId();
    }
        Order ord = new Order(
            AccountId = accountId,
            Status = status,
            Pricebook2Id = pricebookId,
            ShipmentCost__c = shipmentCost,
            EffectiveDate = effectiveDate,
           
            Name = 'Test Order'
        );
        insert ord;
         System.assertNotEquals(null, ord.Pricebook2Id, ' Le Pricebook2Id doit être défini sur l’ordre');
        return ord;
    }
    public static OrderItem createOrderItem(Id orderId, Id pricebookEntryId, Integer quantity, Decimal unitPrice) {
    //  On recharge l’ordre depuis la base pour être sûr qu’il a bien son Pricebook 
    Order ord = [SELECT Id, Pricebook2Id FROM Order WHERE Id = :orderId LIMIT 1];
    System.assertNotEquals(null, ord.Pricebook2Id, 'Erreur : l’Order n’a pas de Pricebook2Id avant la création du OrderItem');

    OrderItem oi = new OrderItem(
        OrderId = ord.Id,
        PricebookEntryId = pricebookEntryId,
        Quantity = quantity,
        UnitPrice = unitPrice
    );
    insert oi;
    return oi;
}
    Pricebook2 pb;
    public static Id getStandardPricebookId() {
    //  On récupère le Pricebook standard
    Pricebook2 pb = [SELECT Id, IsActive FROM Pricebook2 WHERE IsStandard = true LIMIT 1];
    
    //  On vérifie qu’il est bien actif
    if (!pb.IsActive) {
        pb.IsActive = true;
        update pb;
    }
    
    //  On retourne son Id
    return pb.Id;
}

    
}