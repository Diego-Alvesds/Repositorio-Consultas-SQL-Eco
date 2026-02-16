SELECT 
    m30.entradaImputado AS filial,
    m30.proposta AS proposta,
    m30.contrato_protheus AS contrato,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.nomeRazaoCli AS cliente,
    m30.documentoIdent AS documento,
    m30.telefone AS tel_cliente,
    m30.celular AS cel_cliente,
    CONVERT(dataCriacao, DATE) AS data_criacao,
    CONVERT(dataAtualizacao, DATE) AS data_atualizacao,
    m30.atividadeDesc AS status_projeto,
    m30.tipoSimulacaoDesc AS tipo_simulacao,
    m30.descricaoUnidade AS unidade,
    CAST(m30.potenciaSimul AS DECIMAL (6,2)) AS potencia,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_negociacao,
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
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_final,   
    m30.estadoInstalacao AS estado,
    m30.cidadeInstalacaoDesc AS cidade,
    CASE 
        WHEN m30.estadoInstalacao IN ('AC','AM','AP','PA','RO','RR','TO') THEN 'Norte'
        WHEN m30.estadoInstalacao IN ('AL','BA','CE','MA','PB','PE','PI','RN','SE') THEN 'Nordeste'
        WHEN m30.estadoInstalacao IN ('DF','GO','MT','MS') THEN 'Centro-Oeste'
        WHEN m30.estadoInstalacao IN ('ES','MG','RJ','SP') THEN 'Sudeste'
        WHEN m30.estadoInstalacao IN ('PR','RS','SC') THEN 'Sul'
    ELSE 'Região não identificada'
    END AS regiao,
    CASE
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) = TRIM(IFNULL(m30.marcaInversorDesc, '')) AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) = '' AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorDesc, '')) = '' AND TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> '' THEN TRIM(m30.marcaInversorPromocaoDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> TRIM(IFNULL(m30.marcaInversorDesc, '')) AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        ELSE 'Venda Avulsa'
    END AS tipo_inversor,
    CASE 
        WHEN m30.atividade = '15' THEN 'Sim'
    ELSE 'Não' 
    END AS retirar_finalizarperdida,
    NOW() AS data_stamp
FROM 
    ML001030 m30
    JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
    JOIN ML001056 m56 ON m56.companyid = m30.companyid
    AND m56.masterid = m30.ID
WHERE 
    d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m30.atividadeDesc <> ''
    AND m30.proposta <> '00000NaN'