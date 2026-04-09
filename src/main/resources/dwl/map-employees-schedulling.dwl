%dw 2.0
import * from dw::core::Periods

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
    Name: "Agendamento " ++ (payload.horarioOcupado)[0 to 18] as DateTime as String {format: 'dd/MM/yyyy HH:mm:SS'} default "",
    Status__c: if(payload.statusAgendamento == "FIM") "FIN" else payload.statusAgendamento,
    StartDate__c: (payload.horarioOcupado as DateTime + |PT3H|)[0 to 18] as String,
    EndDate__c: (((payload.horarioOcupado as DateTime + |PT3H|)[0 to 18] as String + |PT30M|))[0 to 18],
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
    Name: "Agendamento " ++ (payload.horaAgendadaProdutivo)[0 to 18] as DateTime as String {format: 'dd/MM/yyyy HH:mm:SS'} default "",
    Status__c: if(payload.statusAgendamento == "FIM") "FIN" else payload.statusAgendamento,
    StartDate__c: (payload.horaAgendadaProdutivo as DateTime + |PT3H|)[0 to 18] as String,
    EndDate__c: ((payload.horaAgendadaProdutivo as DateTime + |PT3H|)[0 to 18] as String + duration({ minutes: (payload.duracaoServico/60)}))[0 to 18]
,
    RecordTypeId: vars.rTypeCons,
    WorkOrder__r:{SchedulingExternalId__c: payload.codigoAgendamento},
    WorkOrderLineItem__r: {ExternalId__c: payload.TMOExternalId ++ "_" ++ payload.codigoIdServico}
}