%dw 2.0
var chave = payload map ((value, index) -> value ++ {"chave": value.numeroOs ++ "_" ++ value.codigoServico })
var groupedPayload = chave groupBy $.chave
var pluckedPayload = groupedPayload pluck ((value, key, index) -> value[0] )
var finalMap = pluckedPayload map ((value, index) -> {
    ExternalId__c: value.codigoServico ++ "_" ++ value.numeroOs,
    StartDate: value.dataCriacao,
    EndDate: value.dataLiberacaoVeiculo,
    DurationTime__c: value.horasDuracaoServico,
    TmoExecutes__c: value.executa,
    TmoRequiresTest__c: value.exigeTeste,
    TmoPrioritario__c: value.prioritario,
    ExpressReview__c: value.servicoRapido,
    TmoCharges__c: value.cobrarCliente,
    ExecutionSector__c: value.setorServico,
    Quantitiy: value.quantidadeServico,
    TMO__r: {
    	ExternalId__c: value.codigoServico
    },
    WorkOrderType__r: {
        ExternalId__c: value.codigoTipoOs
    },
    UnitPrice: value.valorUnitarioServico,
    DurationTime__c: value.horasDuracaoServico,
    PricebookEntry: {
        ExternalId__c: "posvenda_" ++ value.codigoEmpresa ++ "_" ++ value.codigoServico
    }
} )
output application/json
---
{
	allOrNone: false,
	records: finalMap
}