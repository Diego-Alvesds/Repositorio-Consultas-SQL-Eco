SELECT
	F1_FILIAL AS filial,
	F1_DOC AS num_nf,
	F1_SERIE AS serie_nf,
	F1_FORNECE AS cod_fornecedor,
	F1_LOJA AS cod_loja,
	F1_COND AS cod_condicao_pagamento,
	F1_EMISSAO AS data_emissao_nf, 
	F1_EST AS uf,
	F1_VALMERC AS vl_mercado,
	F1_VALBRUT AS vl_bruto,
	F1_TIPO AS cod_tipo,
	F1_DESCONT AS vl_desconto,
	F1_DTLANC AS dt_lancamento,
	F1_ESPECIE AS especie,
	F1_RECBMTO AS data_recebimento,
	F1_CHVNFE AS chave_nf,
	DATA_ATUALIZACAO 
FROM SF1010
WHERE 1 = 1