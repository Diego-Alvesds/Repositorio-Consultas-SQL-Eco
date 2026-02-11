 SELECT 
    proposta AS PROPOSTA,
    dataHistoricoCompleta AS DATA_HISTORICO_STATUS,
    statusHistoricoDe AS HISTORICO_STATUS_DE,
    statusHistorico AS HISTORICO_STATUS_PARA,
    nomeUsuarioHistorico AS USUARIO_HISTORICO_STATUS,
    matriculaUsuarioHistorico AS MATRICULA_HISTORICO_STATUS
FROM 
    ML001030 m30
    JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
    JOIN ML001112 m112 ON m112.companyid = m30.companyid
    AND m112.masterid = m30.ID
WHERE 
    d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.dataAtualizacao BETWEEN '2025-08-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m30.proposta <> ''
    AND m30.proposta <> "00000NaN"
    AND m30.proposta IS NOT NULL
    AND m112.statusHistorico IS NOT NULL
    AND m112.statusHistorico <> ''
    AND M112.statusHistoricoDe IS NOT NULL
    AND M112.statusHistoricoDe <> ''