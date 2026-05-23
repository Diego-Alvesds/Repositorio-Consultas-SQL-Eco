SELECT
  	m30.entradaImputado AS filial,
    m30.proposta AS proposta,
    m30.contrato_protheus AS contrato,
    CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_venda,
    m30.atividadeDesc AS status_projeto,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.documentoIdent AS DOCUMENTO,
    m30.nomeRazaoCli AS NOME_CLIENTE,
    m30.cidadeInstalacaoDesc AS CIDADE,
    m30.estadoInstalacao AS ESTADO,
    m30.descricaoUnidade AS UNIDADE,
   	CAST(m30.potenciaSimul AS DECIMAL (10,2)) AS POTENCIA,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_FINAL,
    m55.codigoProdutoAdicional AS COD_PROD_ADICIONAL, 
    m55.produtosAdicionaisDesc AS PRODUTO_ADICIONAL,
    m55.qtdProdutosAdicionais AS QTD_PRODUTO_ADICIONAL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m55.valorUnitProdutosAdicionais, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_UNIT_PRODUTO_ADICIONAL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m55.valorProdutosAdicionais, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS SUBTOTAL_PRODUTO_ADICIONAL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.totalProdutosAdicionais, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS TOTAL_PRODUTOS_ADICIONAIS,
    m30.descontoDado AS PORCENT_DESCONTO
FROM
    DOCUMENTO d
    JOIN ML001030 m30 ON m30.companyid = d.COD_EMPRESA
    AND m30.documentid = d.NR_DOCUMENTO
    AND m30.version = d.NR_VERSAO
    JOIN ML001055 m55 ON m55.companyid = m30.companyid
    AND m55.documentid = m30.documentid
    AND m55.version = m30.version
WHERE
    COD_EMPRESA = 1
    AND VERSAO_ATIVA = 1
    AND m30.dataAtualizacao BETWEEN '2025-01-02 00:00:00' AND '2026-12-31 23:59:59'
    AND m55.produtosAdicionaisDesc LIKE '%SEGURO%'
    AND m30.atividade IN ('14', '22')