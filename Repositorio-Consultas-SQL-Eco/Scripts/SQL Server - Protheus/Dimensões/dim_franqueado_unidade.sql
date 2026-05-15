SELECT DISTINCT 
	A3_COD AS cod_vendedor2,
	A3_NOME AS nome_vendedor2,
	A3_NREDUZ AS nome_vend2_reduzido,
	NULLIF(CONVERT(DATE, A3_ADMISS), '1900-01-01') AS data_admissao,
	A3_TIPO AS cod_tipo_representante,
	CASE
		WHEN A3_TIPO = 'I' THEN 'Interno'
		WHEN A3_TIPO = 'E' THEN 'Externo'
		WHEN A3_TIPO = 'P' THEN 'Parceiro'
		ELSE 'N/A'
	END AS tipo_representante,
	CASE
		WHEN A3_X_TIPIN = '1' THEN 'Interno'
		WHEN A3_X_TIPIN = '2' THEN 'Fluig'
		WHEN A3_X_TIPIN = '3' THEN 'Hubspo'
		ELSE 'N/A'
	END AS tipo_id,
	CASE
		WHEN A3_XTPOPER = '1' THEN 'Franquia Store'
		WHEN A3_XTPOPER = '2' THEN 'Franquia Home'
		WHEN A3_XTPOPER = '3' THEN 'Franquia Premium'
		WHEN A3_XTPOPER = '4' THEN 'Representante'
		WHEN A3_XTPOPER = '5' THEN 'Parceiro'
		WHEN A3_XTPOPER = '6' THEN 'Interno'
		WHEN A3_XTPOPER = '7' THEN 'Protheus'
		WHEN A3_XTPOPER = '8' THEN 'Power GO'
		ELSE 'N/A'
	END AS tipo_operador,
	MAX(DATA_ATUALIZACAO) AS data_stamp
FROM SA3010
WHERE 1 = 1
GROUP BY A3_COD,
		 A3_NOME, 
		 A3_NREDUZ,
		 A3_ADMISS,
		 A3_TIPO,
		 A3_X_TIPIN,
		 A3_XTPOPER
		 