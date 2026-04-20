SELECT
	m30.proposta AS proposta,
	m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
   	CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    m30.atividade AS cod_status,
    m30.atividadeDesc AS status_projeto,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_negociacao,
    m30.tipoSimulacaoDesc AS tipo_simulacao,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.nomeRazaoCli AS cliente,
    m30.documentoIdent AS documento,
    m30.codigoUnidade AS cod_unidade,
    m30.descricaoUnidade AS unidade,
    m30.cidadeInstalacaoDesc AS cidade,
    m30.estadoInstalacao AS estado,
	CASE 
        WHEN m30.estadoInstalacao IN ('AC','AM','AP','PA','RO','RR','TO') THEN 'Norte'
        WHEN m30.estadoInstalacao IN ('AL','BA','CE','MA','PB','PE','PI','RN','SE') THEN 'Nordeste'
        WHEN m30.estadoInstalacao IN ('DF','GO','MT','MS') THEN 'Centro-Oeste'
        WHEN m30.estadoInstalacao IN ('ES','MG','RJ','SP') THEN 'Sudeste'
        WHEN m30.estadoInstalacao IN ('PR','RS','SC') THEN 'Sul'
    ELSE 'Região não identificada'
    END AS regiao, 
    m30.nomeFranqueado AS vendedor,
    m30.vendedor_protheus AS cod_vendedor_protheus,
    m30.executivo_protheus AS cod_executivo_protheus,   
	m36.quantidadePromocao AS qtd_promocao,
	m36.descricaoPromocao AS descricao_promocao,
	CAST(m36.potenciaPromocao AS DECIMAL (10,2)) AS potencia_promocao,
	m36.idPromocao AS id_promocao,
	m36.codigoProdutoPromocao AS cod_produto_promocao,
	m36.geracaoPromocao AS geracao_promocao,
	m36.moduloPromocao AS modulo_promocao,
	m36.inversorPromocao AS inversor_promocao,
	CAST(REPLACE(REPLACE(REGEXP_REPLACE(m36.valorTabelaPromocao, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_tabela_promocao,
	CAST(REPLACE(REPLACE(REGEXP_REPLACE(m36.valorPromocao, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_desconto_promocao,
	CAST(m30.potenciaSimul AS DECIMAL (10,2)) AS potencia_projeto,
	CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_final,
	CASE
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) = TRIM(IFNULL(m30.marcaInversorDesc, '')) AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) = '' AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorDesc, '')) = '' AND TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> '' THEN TRIM(m30.marcaInversorPromocaoDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> TRIM(IFNULL(m30.marcaInversorDesc, '')) AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        ELSE 'Venda Avulsa'
    END AS tipo_inversor,
    m30.formasDePagEfetivadas AS forma_de_pagamento,
    NOW() AS data_stamp
FROM ML001030 m30
INNER JOIN DOCUMENTO d 
	ON d.COD_REG_LISTA = m30.ID
	AND m30.documentid = d.NR_DOCUMENTO
	AND m30.version = d.NR_VERSAO
JOIN ML001036 m36
	ON m36.companyid = m30.companyid
	AND m36.documentid = m30.documentid
	AND m36.version = m30.version
WHERE 1 = 1
    AND d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m36.promocaoEscolhida = 'promocaoEscolhida'
    AND m30.dataAtualizacao BETWEEN '2025-01-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m30.atividadeDesc <> ''
    AND m30.proposta <> '00000NaN'
    AND m30.atividade <> '15'
    AND m30.atividadeDesc IN ('Liberado Financeiro', 'Finalizado Comercial')