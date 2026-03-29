%dw 2.0
output application/json
---
if (!isBlank(payload.nomeConsultor)){
    attributes: {
        "type": "Scheduling__c"
    },
    ExternalId__c: (payload.codigoAgendamento as String) ++ "_" ++ (payload.codigoConsultor as String),
    Seller__r: {
        ExternalId__c: "consultor_" ++ (payload.codigoConsultor as String)
    },
    StartDate__c: payload.horarioOcupado,
    EndDate__c: ((payload.horarioOcupado as LocalDateTime) + |PT30M|) as String ,
    RecordTypeId: vars.rTypeCons
}
else
{
    attributes: {
        "type": "Scheduling__c"
    },
    ExternalId__c: (payload.codigoAgendamento as String) ++ "_" ++ (payload.codigoProdutivo as String),
    Seller__r: {
        ExternalId__c: "produtivo_" ++ (payload.codigoProdutivo as String)
    },
    StartDate__c: payload.horarioOcupado,
    EndDate__c: ((payload.horarioOcupado as LocalDateTime) + |PT30M|) as String,
    RecordTypeId: vars.rTypeCons
}