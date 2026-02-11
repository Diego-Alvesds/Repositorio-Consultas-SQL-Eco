SELECT
	ID AS codigo_unidade,
	DESCRICAO AS descricao,
	A3_COD AS cod_vendedor,
	CIDADE AS codigo_ibge,
	COD_EXEC AS cod_executivo,
	ESTADO AS estado,
	STATUS AS status
FROM toe_unidade
WHERE 1 = 1