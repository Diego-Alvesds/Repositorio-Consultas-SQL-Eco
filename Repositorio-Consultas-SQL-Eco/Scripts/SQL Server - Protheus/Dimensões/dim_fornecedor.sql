SELECT
	A2_COD AS cod_formecedor,
	A2_LOJA AS cod_loja,
	A2_NOME AS nome_fornecedor,
	A2_NREDUZ AS nome_fornc_reduzido,
	A2_END AS endereco_fornecedor,
	A2_BAIRRO AS bairro,
	A2_MUN AS municipio,
	A2_EST AS uf,
	A2_CEP AS cep,
	A2_TIPO AS tipo_fornecedor,
	A2_CGC AS documento,
	A2_DDD AS ddd,
	A2_TEL AS telefone,
	A2_INSCR AS incscricao_estadual,
	A2_EMAIL AS email,
	A2_COD_MUN AS cod_municipio,
	DATA_ATUALIZACAO AS data_stamp
FROM SA2010
WHERE 1 = 1