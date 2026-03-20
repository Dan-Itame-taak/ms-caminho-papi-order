%dw 2.0
var pMap = payload map (value, index) -> 
{
    "attributes": {
        "type": "PaymentCondition__c"
    },
    "ExternalId__c": value.idForma,
    "Name": value.Descricao,
    "Description__c": value.Descricao,
    "Type__c": value.tipo,
    "IsActive__c": true
    }
output application/json
---
{
    allOrNone: false,
    records: pMap
}

