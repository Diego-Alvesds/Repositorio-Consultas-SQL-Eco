WITH ultima_promo AS(
	SELECT 
		documentid,
        MAX(version) AS max_version
    FROM ML001015
    WHERE companyid = 1
    GROUP BY documentid
)
SELECT 
	m15.idPromocaoCriada AS id_promocao_criada,
	m15.descPromocao AS desc_promocao,
	m15.potencia AS potencia_promocao,
	m15.qtdModulo AS qtd_modulo,
	m15.valorPadrao AS valor_deconto,
	m15.valorTabela AS valor_tabela,
	m15.moduloDesc AS desc_modulo_promocao,
	m15.inversorDesc AS desc_inversor,
	m15.permissaoParaSimular AS permissao_simular,
	m15.tipoPromocao AS cod_tipo_promocao,
	m15.tipoPromocaoDesc AS desc_tipo_promocao,
	m15.codigoProdutoPromocao AS cod_produto_promocao,
	CASE 
		WHEN m15.optStatusTXT = 'true' THEN 'Sim'
		WHEN m15.optStatusTXT = 'false' THEN 'Não'
	END AS status_promocao
FROM  ML001015 m15
INNER JOIN ultima_promo up
	ON up.documentid = m15.documentid
	AND m15.version = up.max_version
WHERE 1 = 1
AND m15.companyid = 1