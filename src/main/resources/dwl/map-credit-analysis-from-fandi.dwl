%dw 2.0
output application/json
---
{
	attributes: {
		"type": "CreditAnalysis__c"
	},
    ApprovedFinancedAmount__c: payload.OperacaoParceiro.Valor,
    InstallmentAmount__c: payload.OperacaoParceiro.RetornoValor,
    InstallmentQuantity__c: payload.OperacaoParceiro.QtdParcelas,
    FinancingBank__c: payload.OperacaoParceiro.FinanceiraNome,
    Status__c: payload.OperacaoParceiro.OperacaoSituacao
}