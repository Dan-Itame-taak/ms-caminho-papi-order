%dw 2.0
output application/json
---
{
    attributes: {
        "type": "WorkOrderType__c"
    },
    ExternalId__c: payload.Codigo,
    Name: payload.descricao,
    Abbreviation__c: payload.sigla,
    Classification__c: payload.classificacao,
    DepartmentCode__c: payload.codigoSetorServico,
    Revision__c: payload.revisao,
    QuickService__c: payload.servicoRapido,
    FollowUpSheet__c: payload.fichaSeguimento,
    IsActive__c: payload.ativo,
    PayerSource__c: payload.fontePagadora,
    Control__c: payload.controle 
}