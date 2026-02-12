
SELECT 
	ada.ADA_FILIAL AS filial,
	ada.ADA_X_UNID AS unidade,
	ada.ADA_NUMCTR AS contrato,
	ada.ADA_XFLUIG AS proposta_fluig,
	TRIM(CONCAT(ada.ADA_FILIAL,ada.ADA_NUMCTR)) AS filial_contrato,
	CONCAT(ada.ADA_FILIAL, '-',ada.ADA_CONDPG) AS filial_codpag,
	NULLIF(CONVERT(DATE,ada.ADA_EMISSA), '1900-01-01') AS dt_emissao_contrato,
	ada.ADA_TPCTRT AS cod_tipo_contrato,
	CASE ADA_TPCTRT
		 WHEN '1' THEN 'Venda' 
		 WHEN '2' THEN 'Bonificacão'
		 WHEN '3' THEN 'Ecostore' 
		 WHEN '4' THEN 'Bonificação Ecostore'
		 WHEN '5' THEN 'Retrabalho' 
		 WHEN '6' THEN 'Material Eletricista'
		 WHEN '7' THEN 'Remessa' 
		 WHEN '8' THEN 'Intercompany'
		 WHEN '9' THEN 'Licitação'
		 WHEN 'A' THEN 'Grandes Obras'
		 WHEN 'B' THEN 'Grandes Parcerias'
		 WHEN 'C' THEN 'Venda Avulsa'
		 WHEN 'D' THEN 'Venda FCO'
		 WHEN 'E' THEN 'Desconto em folha'
		 WHEN 'F' THEN 'Venda Mobilidade'
		 WHEN 'G' THEN 'Locação'
		 WHEN ' ' THEN 'Venda'
	END AS tipo_contrato,
	ada.ADA_CODCLI AS cod_cliente,
	ada.ADA_LOJCLI AS cod_loja,
	TRIM(CONCAT(ada.ADA_CODCLI,ada.ADA_LOJCLI)) AS cod_cliente_loja,
	ada.ADA_CONDPG AS cod_condicao_pagamento,
	ada.ADA_XTPTLH AS cod_tipo_telhado,
	CASE ada.ADA_XTPTLH
		 WHEN '1' THEN 'Telhado Cerâmico' 
		 WHEN '2' THEN 'Telhado Eternit'
		 WHEN '3' THEN 'Telhado Zinco/Sanduíche'
		 WHEN '4' THEN 'Telhado Laje'
		 WHEN '5' THEN 'Telhado Kalhetão'
		 WHEN '6' THEN 'RET'
		 WHEN '7' THEN 'SOLO'
		 WHEN '8' THEN 'Carport 3 m'
		 WHEN '9' THEN 'N/A'
		 WHEN 'A' THEN 'Estrurura Propia'
		 WHEN 'B' THEN 'Barracão'
		 WHEN 'C' THEN 'Carport 4 m'
		 WHEN 'D' THEN 'Carport 5 m'
		 WHEN 'E' THEN 'Carport 6 m'
		 WHEN 'F' THEN 'Telhado W'
		 WHEN 'G' THEN 'Telhado Zipado'
		 WHEN 'P' THEN 'PRE MOLD'
		 WHEN 'Q' THEN 'PRE MOLD FIB'
	END AS tipo_telhado,
	ada.ADA_X_TPSL AS cod_tipo_solo,
	CASE ada.ADA_X_TPSL
		WHEN '1' THEN 'Com Abrigo'
		WHEN '2' THEN 'Sem Abrigo'
		WHEN '3' THEN 'N/A'
	END	AS tipo_solo,
	ada.ADA_XTPEST AS cod_tipo_estrutura,
	CASE ada.ADA_XTPEST
		 WHEN 'T' THEN 'Telhado' 
		 WHEN 'E' THEN 'Elevação Telhado'
		 WHEN 'S' THEN 'Solo' 
		 WHEN 'C' THEN 'Carpot'
		 WHEN 'B' THEN 'Barracão' 
		 WHEN 'N' THEN 'N/A'
		 WHEN 'X' THEN 'Estrutura Propria' 
		 WHEN 'Z' THEN 'Telhado Zipado'
		 WHEN 'W' THEN 'Telhado Eternit'
		 WHEN 'I' THEN 'Telhado W'
	END AS tipo_estrutura,
	ada.ADA_X_TPST AS cod_tipo_sistema,
	CASE ada.ADA_X_TPST 
		WHEN '1' THEN 'Monofásico'
		WHEN '2' THEN 'Bifásico'
		WHEN '3' THEN 'Trifásico'
		WHEN '4' THEN 'RET'
		WHEN '4-RET' THEN 'RET'
		WHEN '5' THEN 'N/A'
	END AS tipo_sistema,
	ada.ADA_ZZCOMP AS nome_companhia,
	ada.ADA_X_TENS AS cod_tensao,
	CASE ada.ADA_X_TENS 
		WHEN '1' THEN '127/220'
		WHEN '2' THEN '220/380'
		WHEN '3' THEN 'RET'
		WHEN '4' THEN 'N/A'
		WHEN '5' THEN '440/220'
		WHEN '6' THEN '800/460'
	END AS tensao,
	ada.ADA_XVEND2 AS nome_vendedor2,
	ada.ADA_XVEND3 AS nome_vendedor3,
	NULLIF(CONVERT(DATE,ada.ADA_X_DTNG), '1900-01-01') AS data_negociacao_real,
	NULLIF(CONVERT(DATE,ada.ADA_X_DTN1), '1900-01-01') AS data_negociao_e,
	CASE
		WHEN NULLIF(CONVERT(DATE,ada.ADA_X_DTN1), '1900-01-01') <> '' THEN NULLIF(CONVERT(DATE,ada.ADA_X_DTN1), '1900-01-01')
		ELSE NULLIF(CONVERT(DATE,ada.ADA_X_DTNG), '1900-01-01')
	END AS data_negociacao,
	ada.ADA_X_STAN AS cod_status_negociacao,
	CASE ada.ADA_X_STAN
		WHEN '0' THEN 'Solic Ra'
		WHEN '1' THEN 'Boleto'
		WHEN '2' THEN 'Franquia Paga'
		WHEN '3' THEN 'Análises Credito'
		WHEN '4' THEN 'Corre'
		WHEN '5' THEN 'Executivo'
		WHEN '6' THEN 'Finalizado Comercial'
		WHEN '7' THEN 'Cancelado'
		WHEN '8' THEN 'Solicita NF'
		WHEN '9' THEN 'Reprovado'
		WHEN 'A' THEN 'Aguardando'
		WHEN 'B' THEN 'Finalizado Sac'
		WHEN 'C' THEN 'Parecer de Acesso/Parecer'
		WHEN 'D' THEN 'Finalizado Novos Negocios'
	END AS status_negociacao,
	ada.ADA_X_CFPG AS conf_pag_entrega,
	ada.ADA_X_LIBE AS liberado_entrega,
	ada.ADA_X_STAD AS cod_analise_financeira,
	CASE ada.ADA_X_STAD 
		WHEN '1' THEN 'Efetivado'
		WHEN '2' THEN 'Documentação'
		WHEN '3' THEN 'Em análise'
		WHEN '4' THEN 'Aguardando Pagamento'
		WHEN '5' THEN 'Cancelado'
		WHEN '6' THEN 'Aguardando liberação comercial'
		WHEN '7' THEN 'Aguardando NF'
	END AS analise_financeiro,
	NULLIF(CONVERT(DATE,ada.ADA_X_DLIB), '1900-01-01') AS data_liberacao,
	CONVERT(FLOAT, ada.ADA_X_KWP) AS kwp,
	NULLIF(CONVERT(DATE,ada.ADA_X_DTRE), '1900-01-01') AS data_recebimento,
	ada.ADA_VEND2 AS cod_vendedor2,
	ada.ADA_VEND3 AS cod_vendedor3,
	NULLIF(CONVERT(DATE,ada.ADA_X_PRZC), '1900-01-01') AS prazo_contrato,
	ada.ADA_X_EST AS uf,
	ada.ADA_X_MUN AS municipio,
	CASE 
        WHEN ada.ADA_X_EST IN ('AC','AM','AP','PA','RO','RR','TO') THEN 'Norte'
        WHEN ada.ADA_X_EST IN ('AL','BA','CE','MA','PB','PE','PI','RN','SE') THEN 'Nordeste'
        WHEN ada.ADA_X_EST IN ('DF','GO','MT','MS') THEN 'Centro-Oeste'
        WHEN ada.ADA_X_EST IN ('ES','MG','RJ','SP') THEN 'Sudeste'
        WHEN ada.ADA_X_EST IN ('PR','RS','SC') THEN 'Sul'
    ELSE 'Região não identificada'
    END AS regiao,
	ada.ADA_X_STAF AS cod_analise_credito,
	CASE ada.ADA_X_STAF 
		WHEN '0' THEN 'Não Aplicavel'
		WHEN '1' THEN 'Aprovado'
		WHEN '2' THEN 'Reprovado'
		WHEN '3' THEN 'Em Análise'
		WHEN '4' THEN 'Aguardando Documentação'
	END AS analise_credito,
	NULLIF(CONVERT(DATE,ada.ADA_X_DTCO), '1900-01-01') AS data_conf_entrega,
	NULLIF(CONVERT(DATE,ada.ADA_X_DTLE), '1900-01-01') AS data_libera_entrega,
	ada.ADA_X_PRZ AS prazo_dias,
	ada.ADA_X_VLOR AS vl_proposta,
	CASE ada.ADA_X_LINV
		WHEN '1' THEN 'MONOFÁSICO'
		WHEN '3' THEN 'TRIFÁSICO'
		WHEN '5' THEN 'VENDA AVULSA'
		ELSE 'NÃO IDENTIFICADO'
	END AS linha_inversor,
	ada.DATA_ATUALIZACAO AS data_stamp
FROM VW_ADA010 ada 
WHERE 1 = 1
AND ada.ADA_TPCTRT IN ('1','2','5','7','9','A','B','C','F','G',' ')
AND ada.ADA_FILIAL <> '0112'




