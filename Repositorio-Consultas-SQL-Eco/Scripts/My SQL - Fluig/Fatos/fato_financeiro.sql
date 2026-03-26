SELECT
    m30.proposta AS PROPOSTA,
    m30.entradaImputado AS FILIAL,
    m30.contrato_protheus AS NUMERO_CONTRATO,
    TRIM(CONCAT(m30.entradaImputado,contrato_protheus)) AS filialcontrato,
    m30.nomeRazaoCli AS NOME_CLIENTE,
    m30.tipoFinanciamentoDesc AS PF_PJ,
    m30.documentoIdent AS DOCUMENTO,
    m30.origemCliente AS ORIGEM_CLIENTE,
    m30.cidadeInstalacao AS cod_cidade_instalacao,
    m30.cidadeInstalacaoDesc AS CIDADE,
    m30.estadoInstalacao AS ESTADO,
    m30.codigoUnidade AS cod_unidade,
    m30.descricaoUnidade AS UNIDADE,
    CONVERT(m30.dataCriacao, DATE) AS DATA_CRIACAO,
    CONVERT(m30.dataAtualizacao, DATE) AS DATA_ATUALIZACAO,
    CAST(m30.potenciaSimul AS DECIMAL (6,2)) AS POTENCIA,
    m30.vendedor_protheus AS VENDEDOR_PROTHEUS,
    m30.executivo_protheus AS EXECUTIVO_PROTHEUS, 
    m30.nomeFranqueado AS NOME_VENDEDOR,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_FINAL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaSimul, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_TABELA_SIMUL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaTotal, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_TABELA_TOTAL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoSimul, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_DESCONTO_SIMUL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoTotal, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_DESCONTO_TOTAL,
    m30.atividade AS cod_status_projeto,
    m30.atividadeDesc AS STATUS_PROJETO,
    CASE 																																	-- 05/03/2026 - Retornos da Conectepag pela rotina automatica com padrão decimal '0.00'
    	WHEN m33.idFinanceira = '3066772' AND m33.matriculaUsuarioLogado = 'rotina.automatica' THEN CAST(m33.parcela AS DECIMAL(10,2))
    	ELSE CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.parcela, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2))
    END AS VALOR_PARCELA,
    m33.carencia AS CARENCIA,
    m33.qntParcela AS QTD_PARCELA,
    CASE 
    	WHEN m33.idFinanceira = '3066772' AND m33.matriculaUsuarioLogado = 'rotina.automatica' THEN CAST(m33.valorAprovado AS DECIMAL(10,2))
    	ELSE CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorAprovado, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2))
    END AS VALOR_APROVADO,
    m33.classificacaoCliente AS CLASSE_CLIENTE,
    m33.descricaoAnalise AS Desc_Analise,
    CONVERT(STR_TO_DATE(REPLACE(m33.dataAnalise, 'T', ''),'%Y-%m-%d %H:%i:%s'), DATETIME) AS DATA_RETORNO,
    m33.opcaoEscolhida AS Opcao_Escolhida,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.retencaoFinanceira, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS RETENCAO_FINANCEIRA,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorTotalFinanciamento, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_FINANCIAMENTO,
    m33.statusFinanceira AS STATUS,
    CAST(m33.taxa AS DECIMAL (6,2)) AS TAXA_CLIENTE,
    m33.matriculaUsuarioLogado AS USUARIO_ADD_RETORNO,
    m33.matriculaPosEdicao AS USUARIO_EDIT_RETORNO,
    m33.idFinanceira AS ID_FINANCEIRA,
    m33.selecionaFinanceira AS FINANCEIRA,
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
    CASE
        WHEN m30.statusBV = 'Aprovado' THEN 'Sim'
        WHEN m30.statusBV = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusBV = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusLosango = 'Aprovado' THEN 'Sim'
        WHEN m30.statusLosango = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusLosango = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusSantander = 'Aprovado' THEN 'Sim'
        WHEN m30.statusSantander = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusSantander = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusTMX = 'Aprovado' THEN 'Sim'
        WHEN m30.statusTMX = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusTMX = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusBTG = 'Aprovado' THEN 'Sim'
        WHEN m30.statusBTG = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusBTG = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusOmni = 'Aprovado' THEN 'Sim'
        WHEN m30.statusOmni = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusOmni = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusHorwin = 'Aprovado' THEN 'Sim'
        WHEN m30.statusHorwin = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusHorwin = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusGrenke = 'Aprovado' THEN 'Sim'
        WHEN m30.statusGrenke = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusGrenke = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusConectepag = 'Aprovado' THEN 'Sim'
        WHEN m30.statusConectepag = 'Pre Aprovado' THEN 'Sim' 
        WHEN m30.statusConectepag = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusAventis = 'Aprovado' THEN 'Sim'
        WHEN m30.statusAventis = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusAventis = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusCRIEcopower = 'Aprovado' THEN 'Sim'
        WHEN m30.statusCRIEcopower = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusCRIEcopower = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusFIDCEcopower = 'Aprovado' THEN 'Sim'
        WHEN m30.statusFIDCEcopower = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusFIDCEcopower = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusEOS = 'Aprovado' THEN 'Sim'
        WHEN m30.statusEOS = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusEOS = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusCieloRecorrente = 'Aprovado' THEN 'Sim'
        WHEN m30.statusCieloRecorrente = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusCieloRecorrente = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusPortoBank = 'Aprovado' THEN 'Sim'
        WHEN m30.statusPortoBank = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusPortoBank = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusRedAsset = 'Aprovado' THEN 'Sim'
        WHEN m30.statusRedAsset = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusRedAsset = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusBBSolar = 'Aprovado' THEN 'Sim'
        WHEN m30.statusBBSolar = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusBBSolar = 'Aprovado Parcial' THEN 'Sim'
        WHEN m30.statusCredicitrus = 'Aprovado' THEN 'Sim'
        WHEN m30.statusCredicitrus = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusCredicitrus = 'Aprovado Parcial' THEN 'Sim'
        ELSE 'Não'
    END AS Aprovado,
    CONVERT(STR_TO_DATE(REPLACE(m33.validadeAnalise, 'T', ''),'%Y-%m-%d %H:%i:%s'), DATE) AS VALIDADE_RETORNO,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.entradaFinanceira, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS ENTRADA_RETORNO,
    m33.usarValorTotalDiferenciado AS APROVAR_VALOR_DIF_RETORNO,
    m33.tabelaFinanceira AS TABELA_FINANCEIRA_RETORNO,
    CASE 
        WHEN m30.atividade = '15' THEN 'Sim'
    ELSE 'Não' 
    END AS retirar_finalizarperdida,
    NOW() AS data_stamp
FROM
    ML001030 m30
    JOIN DOCUMENTO d 
    ON d.COD_REG_LISTA = m30.ID
    JOIN ML001033 m33 
    ON m33.companyid = m30.companyid
    AND m33.masterid = m30.ID
WHERE
    d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m33.dataAnalise <> ''
    AND m33.idFinanceira <> ''
    AND m33.selecionaFinanceira <> ''
    AND m30.atividadeDesc <> ''
    AND m30.proposta <> '00000NaN'

