 SELECT
    m30.proposta AS proposta,
    MAX(CASE WHEN m33.idFinanceira = '206' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_aprovoou,
    MAX(CASE WHEN m33.idFinanceira = '207' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_bv,
    MAX(CASE WHEN m33.idFinanceira = '208' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_banco_santander,
    MAX(CASE WHEN m33.idFinanceira = '209' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_losango,
    MAX(CASE WHEN m33.idFinanceira = '1701' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_sicredi,
    MAX(CASE WHEN m33.idFinanceira = '459345' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_tabela_bvfinanceira,
    MAX(CASE WHEN m33.idFinanceira = '1270181' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_desconto_solagora,
    MAX(CASE WHEN m33.idFinanceira = '1481184' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_cessao_losango,
    MAX(CASE WHEN m33.idFinanceira = '1481222' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_cessao_bancosantander,
    MAX(CASE WHEN m33.idFinanceira = '1481223' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_cessao_bancoaprovoou,
    MAX(CASE WHEN m33.idFinanceira = '2070700' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_desconto_cessaolosango,
    MAX(CASE WHEN m33.idFinanceira = '2920025' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_locacao_grenke,
    MAX(CASE WHEN m33.idFinanceira = '2920030' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_omni,
    MAX(CASE WHEN m33.idFinanceira = '3066772' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_conectepag,
    MAX(CASE WHEN m33.idFinanceira = '3137117' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_horwin,
    MAX(CASE WHEN m33.idFinanceira = '3238254' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_aventis,
    MAX(CASE WHEN m33.idFinanceira = '3238261' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_criecopower,
    MAX(CASE WHEN m33.idFinanceira = '3238262' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_fidcecopower,
    MAX(CASE WHEN m33.idFinanceira = '3303892' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_cielorecorrente,
    MAX(CASE WHEN m33.idFinanceira = '3303897' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_eos,
    MAX(CASE WHEN m33.idFinanceira = '3303899' THEN CAST(m33.taxa AS DECIMAL(5,2)) END) AS taxa_portobank,
    NOW() AS data_stamp
FROM ML001030 m30
    JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
    JOIN ML001033 m33 ON m33.companyid = m30.companyid
    AND m33.masterid = m30.ID
WHERE
    d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.dataAtualizacao BETWEEN '2025-08-01 00:00:00' AND '2026-12-31 23:59:59'
GROUP BY
    proposta
