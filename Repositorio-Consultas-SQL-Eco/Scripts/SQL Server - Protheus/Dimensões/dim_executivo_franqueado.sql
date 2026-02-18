SELECT DISTINCT 
	A3_COD AS cod_vendedor2,
	A3_NOME AS nome_vendedor2,
	A3_NREDUZ AS nome_vend2_reduzido,
	NULLIF(CONVERT(DATE, A3_ADMISS), '1900-01-01') AS data_admissao,
	MAX(DATA_ATUALIZACAO) AS data_stamp
FROM SA3010
WHERE 1 = 1
GROUP BY A3_COD,
		 A3_NOME, 
		 A3_NREDUZ,
		 A3_ADMISS
		 