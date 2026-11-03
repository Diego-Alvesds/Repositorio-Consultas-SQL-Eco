SELECT m30.proposta AS PROPOSTA,
       m30.entradaImputado AS filial,
       m30.contrato_protheus AS contrato,
       CASE
           WHEN m30.dataCriacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataCriacao)
       END AS data_criacao,
       CASE
           WHEN m30.dataAtualizacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataAtualizacao)
       END AS data_atualizacao,
       m30.atividadeDesc AS status_projeto,
       CASE
           WHEN m30.tipoTrocaSimulacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.tipoTrocaSimulacao)
       END AS data_negociacao,
       m30.tipoSimulacaoDesc AS tipo_simulacao,
       m30.tipoFinanciamentoDesc AS pf_pj,
       m30.nomeRazaoCli AS cliente,
       m30.vendedor_protheus AS cod_vendedor_protheus,
       m30.executivo_protheus AS cod_executivo_protheus,
       m30.nomeFranqueado AS nome_vendedor,
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
       CASE
           WHEN m30.potenciaSimul REGEXP '[0-9]' THEN CAST(TRIM(m30.potenciaSimul) + 0 AS DECIMAL(10, 2))
       END AS potencia,
       CASE
           WHEN m30.valorTabelaSimul NOT REGEXP '[0-9]' THEN NULL
           WHEN m30.valorTabelaSimul LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaSimul, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m30.valorTabelaSimul, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS valor_tabela_simulacao,
       CASE
           WHEN m30.valorTabelaTotal NOT REGEXP '[0-9]' THEN NULL
           WHEN m30.valorTabelaTotal LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaTotal, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m30.valorTabelaTotal, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS valor_tabela_total,
       CASE
           WHEN m30.valorDescontoSimul NOT REGEXP '[0-9]' THEN NULL
           WHEN m30.valorDescontoSimul LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoSimul, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m30.valorDescontoSimul, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS valor_desconto_simulacao,
       CASE
           WHEN m30.valorDescontoTotal NOT REGEXP '[0-9]' THEN NULL
           WHEN m30.valorDescontoTotal LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoTotal, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m30.valorDescontoTotal, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS valor_desconto_total,
       CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.-]', ''), '.', ''), ',', '.'), '') AS DECIMAL(15, 2)) AS valor_final,
       m55.categoriaProdutoAdicional AS categoria_produto,
       m55.codigoProdutoAdicional AS cod_produto_adicional,
       m55.produtosAdicionaisDesc AS produto_adicional,
       CASE
           WHEN m55.qtdProdutosAdicionais REGEXP '[0-9]' THEN CAST(REGEXP_REPLACE(m55.qtdProdutosAdicionais, '[^0-9.-]', '') AS DECIMAL(10, 2))
       END AS qtd_produto_adicional,
       CASE
           WHEN m55.valorUnitProdutosAdicionais NOT REGEXP '[0-9]' THEN NULL
           WHEN m55.valorUnitProdutosAdicionais LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m55.valorUnitProdutosAdicionais, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m55.valorUnitProdutosAdicionais, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS valor_unit_produto_adicional,
       CASE
           WHEN m55.valorProdutosAdicionais NOT REGEXP '[0-9]' THEN NULL
           WHEN m55.valorProdutosAdicionais LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m55.valorProdutosAdicionais, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m55.valorProdutosAdicionais, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS subtotal_produto_adicional,
       CASE
           WHEN m30.totalProdutosAdicionais NOT REGEXP '[0-9]' THEN NULL
           WHEN m30.totalProdutosAdicionais LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.totalProdutosAdicionais, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m30.totalProdutosAdicionais, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS total_produtos_adicionais,
       ROUND(CASE
                 WHEN m55.qtdProdutosAdicionais REGEXP '[0-9]' THEN CAST(REGEXP_REPLACE(m55.qtdProdutosAdicionais, '[^0-9.-]', '') AS DECIMAL(15, 4))
                 ELSE 0
             END * CASE
                       WHEN m55.valorUnitProdutosAdicionais NOT REGEXP '[0-9]' THEN 0
                       WHEN m55.valorUnitProdutosAdicionais LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m55.valorUnitProdutosAdicionais, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 4))
                       ELSE CAST(REGEXP_REPLACE(m55.valorUnitProdutosAdicionais, '[^0-9.-]', '') AS DECIMAL(15, 4))
                   END , 2) AS total_produtos_adicionais_real,
       CASE
           WHEN m30.descontoDado = '' THEN NULL
           ELSE CAST(m30.descontoDado AS DECIMAL(10, 2))
       END AS desconto_dado,
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
JOIN ML001030 m30 ON m30.companyid = d.COD_EMPRESA
AND m30.documentid = d.NR_DOCUMENTO
AND m30.version = d.NR_VERSAO
JOIN ML001055 m55 ON m55.companyid = m30.companyid
AND m55.documentid = m30.documentid
AND m55.version = m30.version
WHERE d.COD_EMPRESA = 1
  AND d.COD_LISTA = 30
  AND d.VERSAO_ATIVA = 1
  AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
  AND m30.atividadeDesc IN ('Liberado Financeiro',
                            'Finalizado Comercial');