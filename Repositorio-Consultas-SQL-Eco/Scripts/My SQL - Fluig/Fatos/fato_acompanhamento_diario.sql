 SELECT
    m30.proposta AS proposta,
    m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
    TRIM(CONCAT(m30.entradaImputado,m30.contrato_protheus)) AS filialcontrato,
    CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    m30.atividadeDesc AS status_projeto,
    m30.tipoSimulacaoDesc AS tipo_simulacao,
    m30.descricaoUnidade AS unidade,
    m30.vendedor_protheus AS vendedor_protheus,
    m30.executivo_protheus AS executivo_protheus,      
    m30.codigoUnidade AS cod_unidade,
    m30.potenciaSimul AS potencia,
    CAST(REPLACE(REPLACE(NULLIF(TRIM(LTRIM(REPLACE(m30.valorASerPago, 'R$', ''))), ''), '.', ''),',', '.') AS DECIMAL(10,2)) AS valor_final,
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
    AND m30.dataAtualizacao >= DATE_FORMAT(CURRENT_DATE - INTERVAL 3 MONTH, '%Y-%m-01')