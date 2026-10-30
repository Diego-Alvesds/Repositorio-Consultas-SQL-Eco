SELECT m30.entradaImputado AS filial,
       m30.proposta AS proposta,
       m30.contrato_protheus AS contrato,
       TRIM(CONCAT(TRIM(m30.entradaImputado), TRIM(m30.contrato_protheus))) AS filialcontrato,
       CASE
           WHEN m30.dataCriacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataCriacao)
       END AS data_criacao,
       CASE
           WHEN m30.dataAtualizacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataAtualizacao)
       END AS data_atualizacao,
       CASE
           WHEN m30.tipoTrocaSimulacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.tipoTrocaSimulacao)
       END AS data_negociacao,
       m30.atividade AS cod_status,
       m30.atividadeDesc AS status_projeto,
       m30.cliente_protheus AS cod_cliente,
       m30.loja_protheus AS cod_loja,
       TRIM(CONCAT(TRIM(m30.cliente_protheus), TRIM(m30.loja_protheus))) AS cod_clienteloja,
       m56.pagamentoParcelasAprovacao AS cod_forma_pagamento,
       m56.pagamentoParcelasAprovacaoDesc AS forma_pagamento,
       m56.situacaoParcelasAprovacaoDesc AS evento,
       m56.qtdParcelasAprovacao AS parcelas,
       m56.sequenciaParcelasAprovacao AS sequencia_parcelas,
       m56.retencao AS retencao,
       m56.taxaFinanciamento AS taxa_financiamento,
       CASE
           WHEN m56.dataParcelasAprovacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m56.dataParcelasAprovacao)
       END AS data_parcela,
       CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m56.valorParcelasAprovacao, '[^0-9,.-]', ''), '.', ''), ',', '.') , '') AS DECIMAL(15, 2)) AS valor_parcelas,
       CASE
           WHEN m56.percentualParcelasAprovacao = '' THEN NULL
           ELSE CAST(m56.percentualParcelasAprovacao AS DECIMAL(6, 2))
       END AS percentual_parcelas,
       m56.carenciaParcelasAprovacao AS carencia,
       NOW() AS data_stamp
FROM ML001030 m30
JOIN DOCUMENTO d 
ON d.COD_REG_LISTA = m30.ID
JOIN ML001056 m56 
ON m56.companyid = m30.companyid
AND m56.masterid = m30.ID
WHERE d.COD_EMPRESA = 1
  AND d.COD_LISTA = 30
  AND d.VERSAO_ATIVA = 1
  AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
  AND m30.atividadeDesc <> ''
  AND m30.proposta <> '00000NaN'
  AND m30.contrato_protheus <> '';