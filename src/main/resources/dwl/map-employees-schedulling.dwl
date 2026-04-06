%dw 2.0
output application/json
---
if (!isBlank(payload.nomeConsultor)){
    attributes: {
        "type": "Scheduling__c"
    },
    ExternalId__c: (payload.codigoAgendamento as String),
    Seller__r: {
        ExternalId__c: "consultor_" ++ (payload.codigoConsultor as String)
    },
    Name: "Agendamento " ++ payload.horarioOcupado default "",
    Status__c: if(payload.statusAgendamento == "FIM") "FIN" else payload.statusAgendamento,
    StartDate__c: payload.horarioOcupado,
    EndDate__c: ((payload.horarioOcupado as LocalDateTime) + |PT30M|) as String ,
    RecordTypeId: vars.rTypeCons,
    WorkOrder__r:{SchedulingExternalId__c: payload.codigoAgendamento}
}
else
{
    attributes: {
        "type": "Scheduling__c"
    },
    ExternalId__c: (payload.codigoIdServico as String) ,
    Seller__r: {
        ExternalId__c: "produtivo_" ++ (payload.codigoProdutivo as String)
    },
    Name: "Agendamento " ++ payload.horarioOcupado default "",
    Status__c: if(payload.statusAgendamento == "FIM") "FIN" else payload.statusAgendamento,
    StartDate__c: payload.horarioOcupado,
    EndDate__c: ((payload.horarioOcupado as LocalDateTime) + |PT30M|) as String,
    RecordTypeId: vars.rTypeCons,
    WorkOrder__r:{SchedulingExternalId__c: payload.codigoAgendamento},
    WorkOrderLineItem__r: {ExternalId__c: payload.codigoTMO ++ "_" ++ payload.codigoIdServico}
}