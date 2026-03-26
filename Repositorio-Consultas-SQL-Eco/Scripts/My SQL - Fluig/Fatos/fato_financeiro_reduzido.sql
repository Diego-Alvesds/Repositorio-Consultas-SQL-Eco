SELECT 
    m30.proposta AS proposta,
    m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
    TRIM(CONCAT(m30.entradaImputado,contrato_protheus)) AS filialcontrato,
    CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_negociacao,
    m30.atividade AS cod_status,
    m30.atividadeDesc AS status_projeto,
    m30.cliente_protheus AS cod_cliente,
    m30.loja_protheus AS cod_loja,
    TRIM(CONCAT(m30.cliente_protheus,m30.loja_protheus)) AS cod_clienteloja,
    m33.opcaoEscolhida AS Opcao_Escolhida,  
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.retencaoFinanceira, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS retencao_financeira,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorTotalFinanciamento, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_financiamento,
    m33.statusFinanceira AS status,
    CAST(m33.taxa AS DECIMAL (6,2)) AS taxa_cliente,
    m33.idFinanceira AS id_financeira,
    m33.selecionaFinanceira AS financeira,
	CASE
		m33.idFinanceira
        WHEN '206' THEN 'Banco Aprovoou'
		WHEN '207' THEN 'BV Financeira'
		WHEN '208' THEN 'Banco Santander'
		WHEN '209' THEN 'Losango'
		WHEN '1006' THEN 'Cartão de Crédito'
		WHEN '1701' THEN 'Banco Sicredi'
		WHEN '27390' THEN 'Cheque'
		WHEN '91571' THEN 'Depósito'
		WHEN '91573' THEN 'Permuta'
		WHEN '91576' THEN 'PIX'
		WHEN '110506' THEN 'Cartão de Débito'
		WHEN '110736' THEN 'Banco do Cliente mediante emissão de Nota Fiscal'
		WHEN '179726' THEN 'Desconto de Comissão'
		WHEN '381899' THEN 'Financiamento via SICOOB'
		WHEN '381907' THEN 'Bonificação'
		WHEN '459345' THEN 'Tabela BV Financeira'
		WHEN '459350' THEN 'Tabela Losango'
		WHEN '459355' THEN 'Tabela Banco Santander'
		WHEN '556398' THEN 'Boleto Valor Tabela'
		WHEN '556402' THEN 'Boleto Valor Desconto'
		WHEN '594915' THEN 'Cartão de Crédito Safra Visa/Elo'
		WHEN '594928' THEN 'Cartão de Crédito Gocap Visa'
		WHEN '594937' THEN 'Cartão de Crédito Gocap Elo'
		WHEN '594942' THEN 'Cartão de Débito Gocap Visa'
		WHEN '594985' THEN 'Cartão de Crédito Gocap Mastercard'
		WHEN '724535' THEN 'Cartão de Débito Gocap Master'
		WHEN '724537' THEN 'Cartão de Débito Gocap Elo'
		WHEN '724538' THEN 'Cartão de Crédito Safra Master'
		WHEN '1270181' THEN 'Desconto Sol Agora'
		WHEN '1481113' THEN 'Cessão Sol Agora'
		WHEN '1481180' THEN 'Cessão BV'
		WHEN '1481184' THEN 'Cessão Losango'
		WHEN '1481218' THEN 'Cessão Cotas Losango'
		WHEN '1481222' THEN 'Cessão Banco Santander'
		WHEN '1481223' THEN 'Cessão Cota CPFL Banco Aprovoou'
		WHEN '1534811' THEN 'FGTS (TEGGE PAY)'
		WHEN '1534815' THEN 'FGTS (TEGGE PAY) - TABELA'
		WHEN '1895198' THEN 'Parcelamento EcoPower - Boleto'
		WHEN '2070700' THEN 'Desconto Cessão Losango'
		WHEN '2861644' THEN 'Cartão de Crédito Safra Master (Tabela)'
		WHEN '2861650' THEN 'Cartão de Crédito Safra Visa/Elo (Tabela)'
		WHEN '2920025' THEN 'Locação Grenke'
		WHEN '2920030' THEN 'OMNI'
		WHEN '3066772' THEN 'Conectepag'
		WHEN '3137117' THEN 'Horwin'
		WHEN '3181103' THEN 'Consignado'
		WHEN '3216110' THEN 'Desconto em Folha'
		WHEN '3238254' THEN 'Aventis'
		WHEN '3238261' THEN 'CRI EcoPower'
		WHEN '3238262' THEN 'FIDC EcoPower'
		WHEN '3238272' THEN 'RED Asset'
		WHEN '3238274' THEN 'Fundo MOVA'
		WHEN '3303892' THEN 'Cielo Recorrente'
		WHEN '3303897' THEN 'EOS'
		WHEN '3303899' THEN 'Porto Bank'
		WHEN '3530388' THEN 'Locação para Colaborador'
		WHEN '3663572' THEN 'Desconto Cessão Banco Santander'
		WHEN '4024594' THEN 'BB Solar'
		WHEN '4024599' THEN 'Credicitrus Solar'
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
AND m30.proposta <> '00000NaN'
AND m30.contrato_protheus <> ''
AND m33.opcaoEscolhida = 'opcaoEscolhida'

















