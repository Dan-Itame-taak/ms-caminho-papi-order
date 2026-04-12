%dw 2.0
import * from Modules::orderFunctions
var groupedPayload = payload groupBy $.numeroOs
var pluckedPayload = groupedPayload pluck ((value, key, index) -> value[0] )
var finalMap = pluckedPayload map ((value, index) -> {
    attributes:{
        "type": "WorkOrder"
    },
    ExternalId__c: value.numeroOs,
    SchedulingExternalId__c: value.codigoAgendamento,
    Store__r: {
        ExternalId__c: mapStore(value.nomeEmpresa)
    },
    CurrentMileage__c: value.kmVeiculo,
    DealerNetStatus__c: value.statusOs,
    LiftInspection__c: value.inspecaoElevador default false,
    ExpressService__c: value.servicoRapido  default false,
    CustomerNeedsTransport__c: value.clienteDesejaTransporte  default false,
    RequiresWashing__c: value.exigeLavagem  default false,
    CustomerWaiting__c: value.clienteEspera  default false
} )
output application/json
---
{
	allOrNone: false,
	records: finalMap
}