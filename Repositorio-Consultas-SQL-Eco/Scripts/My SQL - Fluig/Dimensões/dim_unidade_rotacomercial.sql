SELECT
	ID AS codigo_unidade,
	DESCRICAO AS descricao,
	A3_COD AS cod_vendedor,
	CIDADE AS codigo_ibge,
	COD_EXEC AS cod_executivo,
	ESTADO AS estado,
	STATUS AS status,
	CASE 
		WHEN ID IN (287, 282, 284)	THEN 'Rota - Interior SP I'
		WHEN ID IN (414, 390, 418, 391)	THEN 'Interior SP II'
		WHEN ID IN (278, 26, 460, 373, 73, 449, 496)	THEN 'Interior SP III - 019'
		WHEN ID IN (219, 75, 524)	THEN 'Interior SP IV'
		WHEN ID IN (455, 185)	THEN 'SP - Capital / Baixada(011 E 013)'
		WHEN ID IN (207, 338, 660, 216, 213, 566, 199)	THEN 'Mato Grosso - 163'
		WHEN ID IN (555, 201)	THEN 'Mato Grosso - Central'
		WHEN ID IN (217)	THEN 'Mato Grosso'
		WHEN ID IN (210, 209)	THEN 'Rondonópolis'
		WHEN ID IN (202, 517)	THEN 'Mato Grosso - Araguaia'
		WHEN ID IN (751, 403, 404)	THEN 'Vilhena'
		WHEN ID IN (11, 18, 10, 587)	THEN 'Rondonia / Acre'
		WHEN ID IN (109, 123)	THEN 'Apucarana'
		WHEN ID IN (110, 464, 463)	THEN 'Parana'
		WHEN ID IN (183, 849, 148)	THEN 'Mato Grosso Sul I'
		WHEN ID IN (49, 272)	THEN 'Mato Grosso Sul II'
		WHEN ID IN (800, 241, 746)	THEN 'Minas Gerais'
		WHEN ID IN (192, 468, 89)	THEN 'Sul da Bahia'
		WHEN ID IN (569)	THEN 'Barreiras'
		WHEN ID IN (372, 181)	THEN 'Vitoria da Conquista'
		WHEN ID IN (550, 34, 99)	THEN 'Norte da Bahia'
		WHEN ID IN (139)	THEN 'Toritama'
		WHEN ID IN (208, 120, 117, 371)	THEN 'Pelotas'
		WHEN ID IN (112, 480)	THEN 'Lages - Distribuição Weg'
		WHEN ID IN (271, 525, 738, 19)	THEN 'Goiania'
		WHEN ID IN (567, 98)	THEN 'Balsas / São Luiz'
		ELSE 'Sem Rota Comercial'
	END AS rota_comercial
FROM toe_unidade
WHERE 1 = 1





