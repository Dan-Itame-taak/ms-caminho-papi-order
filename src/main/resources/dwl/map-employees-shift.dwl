%dw 2.0
import * from Modules::orderFunctions
output application/json
---
if (!isBlank(payload.consultName)){
    attributes: {
        "type": "Seller__c"
    },
    ExternalId__c: "consultor_" ++ payload."consultCode",
    Name: payload."consultName",
    factoryIsActive__c: payload."ativo",
    MorningStart__c: (payload."INICIO MANHA" as DateTime + |PT3H|)[0 to 18] as String,
    MorningEnd__c: (payload."FIM MANHA" as DateTime + |PT3H|)[0 to 18] as String,
    AfternoonStart__c: (payload."INICIO TARDE" as DateTime + |PT3H|)[0 to 18] as String,
    AfternoonEnd__c: (payload."FIM TARDE" as DateTime + |PT3H|)[0 to 18] as String,
    Store__r : {
        ExternalId__c: mapStore(payload."company")
        },
    RecordTypeId: vars.rTypeCons,
    Team__c: payload."teamName"
}
else 
{
    attributes: {
        "type": "Seller__c"
    },
    ExternalId__c: "produtivo_" ++ payload."prodCode",
    Name: payload."prodName",
    factoryIsActive__c: payload."ativo",
    MorningStart__c: (payload."INICIO MANHA" as DateTime + |PT3H|)[0 to 18] as String,
    MorningEnd__c: (payload."FIM MANHA" as DateTime + |PT3H|)[0 to 18] as String,
    AfternoonStart__c: (payload."INICIO TARDE" as DateTime + |PT3H|)[0 to 18] as String,
    AfternoonEnd__c: (payload."FIM TARDE" as DateTime + |PT3H|)[0 to 18] as String,
    Store__r : {
        ExternalId__c: mapStore(payload."company")
    },
    RecordTypeId: vars.rTypeMech,
    Team__c: payload."teamName"
}