SELECT
    m30.entradaImputado AS filial,
    m30.proposta AS proposta,
    m30.contrato_protheus AS contrato,
    TRIM(CONCAT(m30.entradaImputado,contrato_protheus)) AS filialcontrato,
    m30.cliente_protheus AS cod_cliente,
    m30.loja_protheus AS cod_loja,
    TRIM(CONCAT(m30.cliente_protheus,m30.loja_protheus)) AS cod_clienteloja,
    m56.pagamentoParcelasAprovacao AS cod_forma_pagamento,
    m56.pagamentoParcelasAprovacaoDesc AS forma_pagamento,
    m56.situacaoParcelasAprovacaoDesc AS evento,
    m56.qtdParcelasAprovacao AS parcelas,
    m56.retencao AS retencao,
    m56.taxaFinanciamento AS taxa_financiamento,
    CONVERT(m56.dataParcelasAprovacao, DATE) AS data_parcela,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m56.valorParcelasAprovacao, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_parcelas,
    CAST(m56.percentualParcelasAprovacao AS DECIMAL(6,2)) AS percentual_parcelas,
    m56.carenciaParcelasAprovacao AS carencia,
    NOW() AS data_stamp    
FROM ML001030 m30
JOIN DOCUMENTO d 
ON d.COD_REG_LISTA = m30.ID
JOIN ML001056 m56 
ON m56.companyid = m30.companyid
AND m56.masterid = m30.ID
WHERE 1 = 1
AND d.COD_EMPRESA = 1 
AND d.COD_LISTA = 30
AND d.VERSAO_ATIVA = 1
AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
AND m30.atividadeDesc <> ''
AND m30.proposta <> '00000NaN'