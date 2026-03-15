
SELECT DISTINCT 
    m30.proposta AS proposta,
    m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
    TRIM(CONCAT(m30.entradaImputado,contrato_protheus)) AS filialcontrato,
    CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    m30.atividade AS cod_status,
    m30.atividadeDesc AS status_projeto,
    m30.tipoSimulacaoDesc AS tipo_simulacao,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.documentoIdent AS documento,
    m30.nomeRazaoCli AS nome_cliente,
    m30.documentoTitularInstalacao AS documento_titular_instalacao,
    m30.titularInstalacao AS  titular_instalacao,
    m30.email AS email_cliente,
    m30.telefone AS tel_cliente,
    m30.celular AS cel_cliente,
    CONVERT(m30.dataNascimento, DATE) AS data_nascimento,
    CAST(REPLACE(REPLACE(NULLIF(TRIM(m30.rendaMensal), ''), '.', ''),',', '.') AS DECIMAL(10,2)) AS renda_mensal,
    CAST(REPLACE(REPLACE(NULLIF(TRIM(m30.faturamentoMensal), ''), '.', ''),',', '.') AS DECIMAL(10,2)) AS faturamento_mensal,
    m30.nomeMae AS nome_mae,
    m30.nomePai AS nome_pai,
    m30.nomeConjuge AS nome_conjuge,
    m30.cidadeInstalacaoDesc AS cidade,
    m30.estadoInstalacao AS estado,
    m30.descricaoUnidade AS unidade,
    CAST(m30.potenciaSimul AS DECIMAL (10,2)) AS potencia,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_final,
    m30.formasDePagEfetivadas AS forma_de_pagamento,
    m30.vendedor_protheus AS cod_vendedor2,
    m30.executivo_protheus AS cod_vendedor3,  
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_negociacao
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
    AND m30.contrato_protheus <> ''
    
    
    
    