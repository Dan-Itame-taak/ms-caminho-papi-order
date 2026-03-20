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
    MorningStart__c: payload."INICIO MANHA" as DateTime,
    MorningEnd__c: payload."FIM MANHA" as DateTime,
    AfternoonStart__c: payload."INICIO TARDE" as DateTime,
    AfternoonEnd__c: payload."FIM TARDE" as DateTime,
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
    MorningStart__c: payload."INICIO MANHA" as DateTime,
    MorningEnd__c: payload."FIM MANHA" as DateTime,
    AfternoonStart__c: payload."INICIO TARDE" as DateTime,
    AfternoonEnd__c: payload."FIM TARDE" as DateTime,
    Store__r : {
        ExternalId__c: mapStore(payload."company")
    },
    RecordTypeId: vars.rTypeMech,
    Team__c: payload."teamName"
}