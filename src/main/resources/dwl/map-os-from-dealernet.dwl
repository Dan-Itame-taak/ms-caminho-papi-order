%dw 2.0
import * from Modules::orderFunctions
var groupedPayload = payload groupBy $.numeroOs
var pluckedPayload = groupedPayload pluck ((value, key, index) -> value[0] )
var finalMap = pluckedPayload map ((value, index) -> {
    attributes:{
        "type": "WorkOrder"
    },
    ExternalId__c: value.numeroOs,
    Account: {
        ExternalId__c: value.codigoCliente
    },
    Store__r: {
        ExternalId__c: mapStore(value.nomeEmpresa)
    },
    Asset__r: {
        ExternalId__c: value.codigoVeiculo
    },
    Type__c: value.codigoTipoOs,
    CurrentMileage__c: value.kmVeiculo,
    RecordTypeId: vars.recordTypePosVenda,
    DealerNetStatus__c: value.statusOs,
    AdditionalNote__c: value.observacaoServico ,
    Priority: value.prioritario  default false,
    LiftInspection__c: value.inspecaoElevador default false,
    ExpressService__c: value.servicoRapido  default false,
    CustomerNeedsTransport__c: value.entregaDomicilio  default false,
    RequiresWashing__c: value.exigeLavagem  default false,
    CustomerWaiting__c: value.clienteEspera  default false
} )
output application/json
---
{
	allOrNone: false,
	records: finalMap
}