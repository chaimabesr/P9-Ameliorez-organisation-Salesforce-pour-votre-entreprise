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
        Order ord = new Order(
            AccountId = accountId,
            Status = status,
            Pricebook2Id = pricebookId,
            ShipmentCost__c = shipmentCost,
            EffectiveDate = date.today(),
           
            Name = 'Test Order'
        );
        insert ord;
        return ord;
    }
    public static OrderItem createOrderItem(Id orderId, Id pricebookEntryId, Integer quantity, Decimal unitPrice) {
        OrderItem oi = new OrderItem(
            OrderId = orderId,
            PricebookEntryId = pricebookEntryId,
            Quantity = quantity,
            UnitPrice = unitPrice
        );
        insert oi;
        return oi;
    }
}