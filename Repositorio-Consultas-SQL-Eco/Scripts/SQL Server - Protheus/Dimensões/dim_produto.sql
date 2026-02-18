SELECT 
	B1_COD AS cod_produto,
	B1_DESC AS desc_produto,
	B1_TIPO AS tipo_produto,
	B1_UM AS unidade_medida,
	B1_LOCPAD AS armazem,
	B1_GRUPO AS grupo,
	DATA_ATUALIZACAO AS data_stamp
FROM SB1010
WHERE 1 = 1
AND B1_DESC LIKE '%MICROINVERSORES%'

