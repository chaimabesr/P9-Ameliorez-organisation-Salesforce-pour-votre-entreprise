trigger UpdateAccountCA on Order (after update) {
	
    if (Trigger.isAfter && Trigger.isUpdate){
        List<Id> orderIds = OrderService.orderStatusChanged(Trigger.new, Trigger.oldMap);
        if (!orderIds.isEmpty()){
        OrderService.updateAccount(orderIds);
        }
   }
}