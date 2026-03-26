SELECT	 
	m4.documentid, 
	m4.descricaoFinanceira,
	CASE
		m4.documentid
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
	END AS financeira_reduzido
FROM DOCUMENTO d
JOIN ML001010 m4 
	ON m4.companyid = d.COD_EMPRESA
	AND m4.documentid = d.NR_DOCUMENTO
	AND m4.version = d.NR_VERSAO
WHERE 1 = 1
	AND COD_EMPRESA = 1
	AND NUM_DOCTO_PROPRIED = 49
	AND VERSAO_ATIVA = TRUE