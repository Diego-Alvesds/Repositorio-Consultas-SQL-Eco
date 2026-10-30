SELECT m30.proposta AS proposta,
       m30.entradaImputado AS filial,
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
       m33.opcaoEscolhida AS Opcao_Escolhida,
       CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m33.retencaoFinanceira, '[^0-9,.-]', ''), '.', ''), ',', '.'), '') AS DECIMAL(15, 2)) AS retencao_financeira,
       CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorTotalFinanciamento, '[^0-9,.-]', ''), '.', ''), ',', '.'), '') AS DECIMAL(15, 2)) AS valor_financiamento,
       m33.statusFinanceira AS status,
       CASE
           WHEN m33.taxa = '' THEN NULL
           ELSE CAST(m33.taxa AS DECIMAL(6, 2))
       END AS taxa_cliente,
       m33.idFinanceira AS id_financeira,
       m33.selecionaFinanceira AS financeira,
       CASE
           WHEN m33.dataAnalise REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN CONVERT(STR_TO_DATE(REPLACE(m33.dataAnalise, 'T', ''), '%Y-%m-%d %H:%i:%s'), DATETIME)
       END AS data_retorno,
       CASE
           WHEN m33.validadeAnalise REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN CONVERT(STR_TO_DATE(REPLACE(m33.validadeAnalise, 'T', ''), '%Y-%m-%d %H:%i:%s'), DATE)
       END AS validade_retorno,
       CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m33.entradaFinanceira, '[^0-9,.-]', ''), '.', ''), ',', '.'), '') AS DECIMAL(15, 2)) AS entrada_retorno,
       m33.qntParcela AS qtd_parcela,
       CASE
           WHEN m33.idFinanceira = '3066772'
                AND m33.matriculaUsuarioLogado = 'rotina.automatica' THEN CAST(NULLIF(m33.parcela, '') AS DECIMAL(15, 2))
           ELSE CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m33.parcela, '[^0-9,.-]', ''), '.', ''), ',', '.'), '') AS DECIMAL(15, 2))
       END AS valor_parcela,
       m33.carencia AS carencia,
       CASE
           WHEN m33.idFinanceira = '3066772'
                AND m33.matriculaUsuarioLogado = 'rotina.automatica' THEN CAST(NULLIF(m33.valorAprovado, '') AS DECIMAL(15, 2))
           ELSE CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorAprovado, '[^0-9,.-]', ''), '.', ''), ',', '.'), '') AS DECIMAL(15, 2))
       END AS valor_aprovado,
       m33.usarValorTotalDiferenciado AS aprovar_valor_dif_retorno,
       m33.tabelaFinanceira AS tabela_financeira_retorno,
       NOW() AS data_stamp
FROM ML001030 m30
JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
JOIN ML001033 m33 ON m33.companyid = m30.companyid
AND m33.masterid = m30.ID
WHERE d.COD_EMPRESA = 1
  AND d.COD_LISTA = 30
  AND d.VERSAO_ATIVA = 1
  AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
  AND m33.dataAnalise <> ''
  AND m33.idFinanceira <> ''
  AND m33.selecionaFinanceira <> ''
  AND m30.atividadeDesc <> ''
  AND m30.proposta <> '00000NaN'
  AND m30.contrato_protheus <> ''
  AND m33.opcaoEscolhida = 'opcaoEscolhida';