 SELECT
    m30.proposta AS proposta,
    m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
    TRIM(CONCAT(m30.entradaImputado,m30.contrato_protheus)) AS filialcontrato,
    CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    m30.atividadeDesc AS status_projeto,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_venda,
    m30.tipoSimulacaoDesc AS tipo_simulacao,
    m30.descricaoUnidade AS unidade,
    m30.vendedor_protheus AS vendedor_protheus,
    m30.executivo_protheus AS executivo_protheus,      
    m30.codigoUnidade AS cod_unidade,
    CAST(m30.potenciaSimul AS DECIMAL (10,2)) AS potencia,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.formasDePagEfetivadas AS forma_de_pagamento,
    m30.classe AS CLASSE,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_final,
    NOW() AS data_stamp
FROM ML001030 m30
JOIN DOCUMENTO d 
ON d.COD_REG_LISTA = m30.ID
WHERE 1 = 1
    AND d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.atividadeDesc <> ''
    AND m30.atividade <> '15'
    AND m30.dataAtualizacao BETWEEN '2025-01-01 00:00:00' AND '2026-12-31 23:59:59'
