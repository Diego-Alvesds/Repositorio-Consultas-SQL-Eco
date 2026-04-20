WITH ultima_promo AS(
    SELECT 
        documentid,
        MAX(version) AS max_version,
        MAX(ID) AS max_id
    FROM ML001015
    WHERE companyid = 1
    GROUP BY documentid
)
SELECT 
	m15.documentid AS documentid,
	m15.version,
    m15.idPromocaoCriada AS id_promocao_criada,
    m15.descPromocao AS desc_promocao,
    CAST(m15.potencia AS DECIMAL (10,2)) AS potencia_promocao,
    CAST(m15.qtdModulo AS UNSIGNED INTEGER) AS qtd_modulo,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m15.valorPadrao, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_deconto,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m15.valorTabela , '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_tabela,
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
    AND up.max_version = m15.version
    AND up.max_id = m15.ID
WHERE 1 = 1
AND m15.companyid = 1









