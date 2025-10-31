trigger OrderTrigger on Order (Before update, After update) {
    if (Trigger.isBefore && Trigger.isUpdate){
     
    for(Order ord: trigger.new){
			Decimal totalAmount = 0;
      Decimal shipmentCost = 0;

      if (ord.TotalAmount != null) {
        totalAmount = ord.TotalAmount;
      }

      if (ord.ShipmentCost__c != null) {
        shipmentCost = ord.ShipmentCost__c;
     }

    ord.NetAmount__c = totalAmount - shipmentCost;
		}
    } 
    if (Trigger.isAfter && Trigger.isUpdate){
        List<Id> orderIds = OrderService.orderStatusChanged(Trigger.new, Trigger.oldMap);
        if (!orderIds.isEmpty()){
        OrderService.updateAccount(orderIds);
        }
   }

}