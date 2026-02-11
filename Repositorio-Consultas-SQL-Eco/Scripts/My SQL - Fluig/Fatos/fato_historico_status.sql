SELECT 
    m30.proposta AS PROPOSTA,
    m30.potenciaSimul AS POTENCIA,
    m30.atividadeDesc AS STATUS_PROJETO,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_FINAL,    
    m112.dataHistoricoCompleta AS DATA_HISTORICO_STATUS,
    m112.statusHistoricoDe AS HISTORICO_STATUS_DE,
    m112.statusHistorico AS HISTORICO_STATUS_PARA,
    m112.nomeUsuarioHistorico AS USUARIO_HISTORICO_STATUS,
    m112.matriculaUsuarioHistorico AS MATRICULA_HISTORICO_STATUS,
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
FROM ML001030 m30
JOIN DOCUMENTO d 
    ON d.COD_REG_LISTA = m30.ID
JOIN ML001112 m112 
    ON m112.companyid = m30.companyid
    AND m112.masterid = m30.ID
WHERE 
    d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.atividadeDesc <> ''
    AND m30.proposta <> '00000NaN'
    AND m30.dataAtualizacao >= DATE_FORMAT(CURRENT_DATE - INTERVAL 2 MONTH, '%Y-%m-01') 