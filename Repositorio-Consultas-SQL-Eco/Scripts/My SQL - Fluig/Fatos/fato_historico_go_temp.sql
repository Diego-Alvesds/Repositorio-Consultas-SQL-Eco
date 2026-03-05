 SELECT 
    m30.proposta AS PROPOSTA,
    m30.contrato_protheus AS CONTRATO,
    m30.nomeRazaoCli AS CLIENTE,
    m30.descricaoUnidade AS UNIDADE,
    CAST(m30.potenciaSimul AS DECIMAL (10,2)) AS POTENCIA,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_FINAL,
    m112.dataHistoricoCompleta AS DATA_HISTORICO_STATUS,
    m112.statusHistoricoDe AS HISTORICO_STATUS_DE,
    m112.statusHistorico AS HISTORICO_STATUS_PARA,
    m112.nomeUsuarioHistorico AS USUARIO_HISTORICO_STATUS,
    m112.matriculaUsuarioHistorico AS MATRICULA_HISTORICO_STATUS,
    NOW() AS data_stamp
FROM 
    ML001030 m30
    JOIN DOCUMENTO d 
    ON d.COD_REG_LISTA = m30.ID
    JOIN ML001112 m112 
    ON m112.companyid = m30.companyid
    AND m112.masterid = m30.ID
WHERE 
    d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.dataAtualizacao BETWEEN '2025-10-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m30.proposta <> ''
    AND m30.proposta <> "00000NaN"
    AND m30.proposta IS NOT NULL
    AND m112.statusHistorico IS NOT NULL
    AND m112.statusHistorico <> ''
    AND M112.statusHistoricoDe IS NOT NULL
    AND M112.statusHistoricoDe <> ''