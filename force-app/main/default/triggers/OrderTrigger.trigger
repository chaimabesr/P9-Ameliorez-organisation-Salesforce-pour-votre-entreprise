trigger OrderTrigger on Order (Before update, After update) {
    if (Trigger.isBefore && Trigger.isUpdate){
     
    for(Order ord: trigger.new){
				ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
		}
    }
    if (Trigger.isAfter && Trigger.isUpdate){
        List<Id> orderIds = OrderService.orderStatusChanged(Trigger.new, Trigger.oldMap);
        if (!orderIds.isEmpty()){
        OrderService.updateAccount(orderIds);
        }
   }

}