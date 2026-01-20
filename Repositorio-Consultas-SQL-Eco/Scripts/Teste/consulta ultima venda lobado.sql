
----------------------------------
SELECT DISTINCT
    m30.vendedor_protheus AS VENDEDOR_PROTHEUS,
    MAX(CONVERT(m30.dataCriacao, DATE)) AS DATA_CRIACAO
FROM ML001030 m30
JOIN DOCUMENTO d 
ON d.COD_REG_LISTA = m30.ID
WHERE 1 = 1
    AND d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.dataCriacao BETWEEN '2025-01-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m30.atividadeDesc <> ''
    AND m30.proposta <> '00000NaN'
    AND m30.atividade = '2'
GROUP BY m30.vendedor_protheus


------------------------------------------



SELECT DISTINCT
    ada.ADA_VEND2 AS cod_vendedor2,
    ada.ADA_XVEND2 AS nome_vendedor2,
    MAX(CONVERT(DATE,ada.ADA_X_DTNG)) AS data_negociacao
FROM VW_ADA010 ada 
WHERE 1 = 1
    AND ada.ADA_X_STAN NOT IN('7')
    AND ada.ADA_X_STAD NOT IN('5')
    AND ada.ADA_TPCTRT IN('1','2','5','7','9','A','B','C','F','G',' ')
    AND ada.ADA_FILIAL <> '0112'
    AND CONVERT(DATE,ada.ADA_X_DTNG) >= '2025-01-01'
GROUP BY ada.ADA_VEND2,
         ada.ADA_XVEND2
