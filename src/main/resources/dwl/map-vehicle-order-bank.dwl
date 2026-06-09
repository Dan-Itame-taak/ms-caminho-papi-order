%dw 2.0
var bancoPedido = payload.compositeResponse.body[0].records[0]
output application/json
---
{
	BancoPedido_Ano: bancoPedido.YearModel__r.ManufacturingYear__c,
	BancoPedido_Semana: 99, 
	BancoPedido_EmpresaCod: bancoPedido.Order__r.Store__r.DealerNetExternalId__c, 
	BancoPedido_ModeloVeiculoCod: bancoPedido.VehicleModelCode__c, 
	BancoPedido_CorExternaCod: bancoPedido.ExteriorColorCode__c,
	BancoPedido_CorInternaCod: bancoPedido.InternalColor__c,
	BancoPedido_Observacao: bancoPedido.OptionalDescription__c, 
	BancoPedido_NroPedidoComercial: bancoPedido.CommercialOrderNumber__c, 
	BancoPedido_NroPedidoComercialOriginal: bancoPedido.CommercialOrderNumber__c,  
	BancoPedido_Status: "AUT", 
	TipoBancoPedido_Codigo: 3, 
	BancoPedido_VeiculoAnoCod: (bancoPedido.YearModel__r.ExternalId__c splitBy  "_")[0], 
	BancoPedido_AdaptacaoVeiculoCod: bancoPedido.VehicleAdaptation__c, 
	BancoPedido_Quantidade: 1,
	BancoPedidoCodVinculado: bancoPedido.BancoPedidoCodVinculado,
	BancoPedido_DataMontage: bancoPedido.AssemblyDate__c
}