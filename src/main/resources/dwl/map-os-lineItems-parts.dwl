%dw 2.0
output application/json
---
 {
    attributes: {
        "type": "WorkOrderLineItem"
    },
    ExternalId__c: payload.codigoPeca ++ "_" 
    ++ payload.codigoServico ++ "_" 
    ++ payload.codigoOS,
    ParentWorkOrderLineItem: {
        ExternalId__c: payload.codigoServico ++ "_" 
    ++ payload.codigoOS
    },
    PricebokEntry: {
    	ExternalId__c: "posvenda_" ++ value.codigoEmpresa
    },
    StartDate: payload.dataCriacao,
    EndDate: payload.dataLiberacaoVeiculo,
    DurationTime__c: (payload.horasDuracaoServico / 3600),
    ExpressReview__c: payload.servicoRapido,
    Quantitiy: payload.quantidadePeca,
    WorkOrderId: payload.numeroOs,
    UnitPrice: payload.valorUnitarioPeca,
    Discount: payload.valorDescontoPeca
}