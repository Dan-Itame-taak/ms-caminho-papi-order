%dw 2.0
import * from Modules::orderFunctions
import * from dw::core::Periods
var TMOe = vars.vPayload map (value,index) -> {
	code: if(!isBlank(value.codModeloVeiculo)) 
(value.codigoTMO ++ "_" ++ value.codModeloVeiculo)
else 
value.codigoTMO
}
var chave = vars.vPayload map ((value, index) -> value ++ {"chave": value.codigoOS ++ "_" ++ value.codigoServico })
var groupedPayload = chave groupBy $.chave
var pluckedPayload = groupedPayload pluck ((value, key, index) -> value[0] )
var finalMap = pluckedPayload map ((value, index) -> {
	"attributes": {
		"type": "WorkOrderLineItem"
	},
    ExternalId__c: value.codigoServico,
    (StartDate: (value.horaAgendadaProdutivo as DateTime + |PT3H|)[0 to 18] as String) if !isBlank(value.horaAgendadaProdutivo),
    (EndDate: ((value.horaAgendadaProdutivo as DateTime + |PT3H|)[0 to 18] as String + duration({ minutes: (value.horasDuracaoServico/60)}))[0 to 18]) if !isBlank(value.horaAgendadaProdutivo),
    DurationTime__c: (value.horasDuracaoServico / 3600),
    TmoExecutes__c: value.executa,
    TmoRequiresTest__c: value.exigeTeste default false,
    TmoPrioritario__c: value.prioritario default false,
    ExpressReview__c: value.servicoRapido default false,
    TmoCharges__c: value.cobrarCliente default false,
    ExecutionSector__c: mapExecSec(value.setorServico) default false,
    Quantity: value.quantidadeServico default false,
    WorkOrder: if(!isBlank(value.codigoAgendamento)) {
    	SchedulingExternalId__c: value.codigoAgendamento
    } 
    else
    {
    	ExternalId__c: value.codigoOS
    },
    TMO__r: {
    	ExternalId__c: value.codigoTMO
    },
    WorkOrderType__r: {
        ExternalId__c: value.codigoTipoOs
    },
    UnitPrice: value.valorUnitarioServico,
    //DurationTime__c: value.horasDuracaoServico,
    PricebookEntry: {
        ExternalId__c: "WorkOrderTMO" ++ "_" ++ TMOe[(index)].code
    }
} )
output application/json
---
{
	allOrNone: false,
	records: finalMap
}