SELECT 
	CTT_FILIAL AS filial,
	CTT_CUSTO AS centro_custo,
	TRIM(CONCAT(TRIM(CTT_FILIAL),TRIM(CTT_CUSTO))) AS filial_cc,
	CTT_CLASSE AS classe,
	CTT_DESC01 AS descricao_centro_custo,
	CTT_CCSUP AS cc_superior,
	DATA_ATUALIZACAO AS data_stamp
FROM CTT010
WHERE 1 = 1