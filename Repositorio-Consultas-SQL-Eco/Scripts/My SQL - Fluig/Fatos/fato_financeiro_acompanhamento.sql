SELECT 
    m30.proposta AS proposta,
    CONVERT(m30.dataCriacao, DATE) AS data_cricao,
    m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
    TRIM(CONCAT(m30.entradaImputado,contrato_protheus)) AS filialcontrato,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    m30.cliente_protheus AS cod_cliente,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.documentoIdent AS documento,
    m30.nomeRazaoCli AS nome_cliente,
    m30.loja_protheus AS cod_loja,
    m30.executivo_protheus AS cod_executivo,
    m30.descricaoUnidade AS unidade,
    TRIM(CONCAT(m30.cliente_protheus,m30.loja_protheus)) AS cod_clienteloja,
    m33.opcaoEscolhida AS Opcao_Escolhida,  
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.retencaoFinanceira, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS retencao_financeira,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorTotalFinanciamento, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_financiamento,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_final,
    m33.statusFinanceira AS status,
    CAST(m33.taxa AS DECIMAL (6,2)) AS taxa_cliente,
    m33.idFinanceira AS id_financeira,
    m33.selecionaFinanceira AS financeira,
    CASE m33.idFinanceira
        WHEN '206' THEN 'Banco Aprovoou'
        WHEN '207' THEN 'BV Financeira'
        WHEN '208' THEN 'Banco Santander'
        WHEN '209' THEN 'Losango'
        WHEN '1701' THEN 'Banco SICREDI'
        WHEN '459345' THEN 'TABELA BV Financeira'
        WHEN '1270181'  THEN 'DESCONTO Sol Agora'
        WHEN '1481184'  THEN 'CESSÃO Losango'
        WHEN '1481222'  THEN 'CESSÃO Banco Santander'
        WHEN '1481223'  THEN 'CESSÃO COTA CPFL Banco Aprovoou'
        WHEN '2070700'  THEN 'Desconto CESSÃO Losango'
        WHEN '2920025'  THEN 'LOCAÇÃO Grenke'
        WHEN '2920030'  THEN 'OMNI'
        WHEN '3066772'  THEN 'Conectepag'
        WHEN '3137117'  THEN 'HORWIN'
        WHEN '3238254'  THEN 'Aventis'
        WHEN '3238261'  THEN 'CRI EcoPower'
        WHEN '3238262'  THEN 'FIDC EcoPower'
        WHEN '3303892'  THEN 'Cielo Recorrente'
        WHEN '3303897'  THEN 'EOS'
        WHEN '3303899'  THEN 'Porto Bank'
        WHEN '3663572'  THEN 'DESCONTO CESSÃO Banco Santander'
    END AS financeira_reduzido,
    CONVERT(STR_TO_DATE(REPLACE(m33.dataAnalise, 'T', ''),'%Y-%m-%d %H:%i:%s'), DATETIME) AS data_retorno,
    CONVERT(STR_TO_DATE(REPLACE(m33.validadeAnalise, 'T', ''),'%Y-%m-%d %H:%i:%s'), DATE) AS validade_retorno,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.entradaFinanceira, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS entrada_retorno,
    m33.qntParcela AS qtd_parcela,
    CASE                                                                                                                                    -- 05/03/2026 - Retornos da Conectepag pela rotina automatica com padrão decimal '0.00'
        WHEN m33.idFinanceira = '3066772' AND m33.matriculaUsuarioLogado = 'rotina.automatica' THEN CAST(m33.parcela AS DECIMAL(10,2))
        ELSE CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.parcela, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2))
    END AS valor_parcela,
    m33.carencia AS carencia,
    CASE 
        WHEN m33.idFinanceira = '3066772' AND m33.matriculaUsuarioLogado = 'rotina.automatica' THEN CAST(m33.valorAprovado AS DECIMAL(10,2))
        ELSE CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorAprovado, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2))
    END AS valor_aprovado,
    m33.usarValorTotalDiferenciado AS aprovar_valor_dif_retorno,
    m33.tabelaFinanceira AS tabela_financeira_retorno,
    NOW() AS data_stamp
FROM ML001030 m30
JOIN DOCUMENTO d 
ON d.COD_REG_LISTA = m30.ID
JOIN ML001033 m33 
ON m33.companyid = m30.companyid
AND m33.masterid = m30.ID
WHERE 1 = 1
AND d.COD_EMPRESA = 1 
AND d.COD_LISTA = 30
AND d.VERSAO_ATIVA = 1
AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
AND m33.dataAnalise <> ''
AND m33.idFinanceira <> ''
AND m33.selecionaFinanceira <> ''
AND m30.atividadeDesc <> ''
AND m30.proposta NOT IN ('00000NaN','00148111','00187137','00189120','00190659','00190992','00409630' )
AND m30.contrato_protheus <> ''
AND m33.opcaoEscolhida = 'opcaoEscolhida'

















