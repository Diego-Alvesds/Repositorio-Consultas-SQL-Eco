SELECT
	m30.proposta AS PROPOSTA,
	m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
   	CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    m30.atividadeDesc AS status_projeto,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_negociacao,
    m30.tipoSimulacaoDesc AS tipo_simulacao,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.nomeRazaoCli AS cliente,
    m30.vendedor_protheus AS cod_vendedor_protheus,
	m30.executivo_protheus AS cod_executivo_protheus, 
	m30.nomeFranqueado AS nome_vendedor,
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
    CAST(m30.potenciaSimul AS DECIMAL (10,2)) AS potencia,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_final,
    m55.categoriaProdutoAdicional AS categoria_produto,
	m55.codigoProdutoAdicional AS cod_produto_adicional,
    m55.produtosAdicionaisDesc AS produto_adicional,
	CAST(m55.qtdProdutosAdicionais AS DECIMAL (10,2)) AS qtd_produto_adicional,
	CAST(REPLACE(REPLACE(REGEXP_REPLACE(m55.valorUnitProdutosAdicionais, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_unit_produto_adicional,
	CAST(REPLACE(REPLACE(REGEXP_REPLACE(m55.valorProdutosAdicionais, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS subtotal_produto_adicional,
	CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.totalProdutosAdicionais, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS total_produtos_adicionais,
	CAST(m55.qtdProdutosAdicionais * (CAST(REPLACE(REPLACE(REGEXP_REPLACE(m55.valorUnitProdutosAdicionais, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)))AS DECIMAL(10,2)) AS total_produtos_adicionais_real,
	m55.produtoAdicionalEntregue AS produto_entregue,
	m55.produtoBonificado AS produto_bonificado,
	m30.formasDePagEfetivadas AS forma_de_pagamento,
    m30.chkFreteComercial AS cod_frete_prioridade_comercial,
    CASE m30.chkFreteComercial
        WHEN 'true' THEN 'SIM'
        ELSE 'NÃO'
    END AS frete_prioridade_comercial,
    m30.chkFreteFrontline AS cod_frete_frontline,
    CASE m30.chkFreteFrontline
        WHEN 'true' THEN 'SIM'
        ELSE 'NÃO'
    END AS frete_frontline,
    NOW() AS data_stamp
FROM DOCUMENTO d
    JOIN ML001030 m30 
    ON m30.companyid = d.COD_EMPRESA
    AND m30.documentid = d.NR_DOCUMENTO
    AND m30.version = d.NR_VERSAO
    JOIN ML001055 m55 
    ON m55.companyid = m30.companyid
    AND m55.documentid = m30.documentid
    AND m55.version = m30.version
WHERE 1 = 1
    AND d.COD_EMPRESA = 1
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.atividade <> '15'
    AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	