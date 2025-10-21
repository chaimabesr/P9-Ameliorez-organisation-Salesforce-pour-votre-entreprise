trigger CalculMontant on Order (Before update) {


	
		for(Order ord: trigger.new){
			Decimal totalAmount = ord.TotalAmount != null ? ord.TotalAmount : 0;
			 Decimal shipmentCost = ord.ShipmentCost__c != null ? ord.ShipmentCost__c : 0;
				ord.NetAmount__c = ord.totalAmount - ord.ShipmentCost__c;
		}
}
