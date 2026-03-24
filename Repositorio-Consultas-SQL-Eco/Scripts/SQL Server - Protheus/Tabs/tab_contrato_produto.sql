
SELECT
    ADB_FILIAL AS filial,
    ADB_NUMCTR AS contrato,
    TRIM(CONCAT(ADB_FILIAL,ADB_NUMCTR)) AS filial_contrato,
    ADB_ITEM AS cod_item,
    ADB_CODPRO AS cod_produto,
    ADB_DESPRO AS descricao_produto,
    ADB_UM AS unidade_medida,
    CONVERT(INT, ADB_QUANT) AS qtd_produto,
    CONVERT(FLOAT, ADB_PRCVEN) AS preco_venda,
    CONVERT(FLOAT, ADB_TOTAL) AS preco_venda_total,
    ADB_PEDCOB AS numero_pedido,
    ADB_TES AS tes,
    ADB_TESCOB AS tes_cobranca,
    ADB_LOCAL AS armazem,
    ADB_QTDEMP AS qtd_emp,
    ADB_CODCLI AS cod_cliente,
    ADB_LOJCLI AS cod_loja_cliente,
    CONVERT(FLOAT, ADB_XKWP) AS kwp,
    ADB_X_TIPO AS cod_tipo_venda,
    CASE ADB_X_TIPO
        WHEN '' THEN 'Gerador'
        WHEN '0' THEN 'Normal'
        WHEN '1' THEN 'Bonificação'
        WHEN '2' THEN 'Brinde'
    END AS tipo_venda,
    ADB_XINVER AS cod_inversor,
    DATA_ATUALIZACAO AS data_stamp
FROM VW_ADB010
WHERE 1 = 1 