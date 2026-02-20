 SELECT
    m30.proposta AS proposta,
    m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
    TRIM(CONCAT(m30.entradaImputado,m30.contrato_protheus)) AS filialcontrato,
    CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    m30.atividade AS cod_status,
    m30.atividadeDesc AS status_projeto,
    m30.tipoSimulacaoDesc AS tipo_simulacao,
    m30.tipoFinanciamentoDesc AS pf_pj,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_venda,
    m30.codigoUnidade AS cod_unidade,
    m30.descricaoUnidade AS unidade,
    m30.cidadeInstalacaoDesc AS cidade,
    m30.estadoInstalacao AS estado,
    CASE 
        WHEN m30.estadoInstalacao IN ('AC','AM','AP','PA','RO','RR','TO') THEN 'Norte'
        WHEN m30.estadoInstalacao IN ('AL','BA','CE','MA','PB','PE','PI','RN','SE') THEN 'Nordeste'
        WHEN m30.estadoInstalacao IN ('DF','GO','MT','MS') THEN 'Centro-Oeste'
        WHEN m30.estadoInstalacao IN ('ES','MG','RJ','SP') THEN 'Sudeste'
        WHEN m30.estadoInstalacao IN ('PR','RS','SC') THEN 'Sul'
    ELSE 'Região não identificada'
    END AS regiao,
    m30.classe AS classe,
    m30.vendedor_protheus AS vendedor_protheus,
    m30.executivo_protheus AS executivo_protheus,      
    CAST(m30.potenciaSimul AS DECIMAL (10,2)) AS potencia,
    CASE
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) = TRIM(IFNULL(m30.marcaInversorDesc, '')) AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) = '' AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorDesc, '')) = '' AND TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> '' THEN TRIM(m30.marcaInversorPromocaoDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> TRIM(IFNULL(m30.marcaInversorDesc, '')) AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        ELSE 'Venda Avulsa'
    END AS tipo_inversor,
    m30.formasDePagEfetivadas AS forma_de_pagamento,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_final,
    NOW() AS data_stamp
FROM ML001030 m30
JOIN DOCUMENTO d 
ON d.COD_REG_LISTA = m30.ID
WHERE 1 = 1
    AND d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m30.atividadeDesc <> ''
    AND m30.proposta <> '00000NaN'
    AND m30.atividade <> '15' 





    