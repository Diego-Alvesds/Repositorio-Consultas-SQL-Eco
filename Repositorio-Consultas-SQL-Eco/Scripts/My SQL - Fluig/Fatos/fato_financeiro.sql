SELECT m30.proposta AS PROPOSTA,
       m30.entradaImputado AS FILIAL,
       m30.contrato_protheus AS NUMERO_CONTRATO,
       TRIM(CONCAT(TRIM(m30.entradaImputado), TRIM(m30.contrato_protheus))) AS filialcontrato,
       m30.nomeRazaoCli AS NOME_CLIENTE,
       m30.tipoFinanciamentoDesc AS PF_PJ,
       m30.documentoIdent AS DOCUMENTO,
       m30.origemCliente AS ORIGEM_CLIENTE,
       m30.cidadeInstalacao AS cod_cidade_instalacao,
       m30.cidadeInstalacaoDesc AS CIDADE,
       m30.estadoInstalacao AS ESTADO,
       m30.codigoUnidade AS cod_unidade,
       m30.descricaoUnidade AS UNIDADE,
       CASE
           WHEN m30.dataCriacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataCriacao)
       END AS DATA_CRIACAO,
       CASE
           WHEN m30.dataAtualizacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataAtualizacao)
       END AS DATA_ATUALIZACAO,
       CASE
           WHEN m30.tipoTrocaSimulacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.tipoTrocaSimulacao)
       END AS data_negociacao,
       CASE
           WHEN m30.potenciaSimul REGEXP '[0-9]' THEN CAST(REGEXP_REPLACE(m30.potenciaSimul, '[^0-9.-]', '') AS DECIMAL(6, 2))
       END AS POTENCIA,
       m30.vendedor_protheus AS VENDEDOR_PROTHEUS,
       m30.executivo_protheus AS EXECUTIVO_PROTHEUS,
       m30.nomeFranqueado AS NOME_VENDEDOR,
       CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.-]', ''), '.', ''), ',', '.'), '') AS DECIMAL(15, 2)) AS VALOR_FINAL,
       CASE
           WHEN m30.valorTabelaSimul NOT REGEXP '[0-9]' THEN NULL
           WHEN m30.valorTabelaSimul LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaSimul, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m30.valorTabelaSimul, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS VALOR_TABELA_SIMUL,
       CASE
           WHEN m30.valorTabelaTotal NOT REGEXP '[0-9]' THEN NULL
           WHEN m30.valorTabelaTotal LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaTotal, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m30.valorTabelaTotal, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS VALOR_TABELA_TOTAL,
       CASE
           WHEN m30.valorDescontoSimul NOT REGEXP '[0-9]' THEN NULL
           WHEN m30.valorDescontoSimul LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoSimul, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m30.valorDescontoSimul, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS VALOR_DESCONTO_SIMUL,
       CASE
           WHEN m30.valorDescontoTotal NOT REGEXP '[0-9]' THEN NULL
           WHEN m30.valorDescontoTotal LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoTotal, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m30.valorDescontoTotal, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS VALOR_DESCONTO_TOTAL,
       m30.atividade AS cod_status_projeto,
       m30.atividadeDesc AS STATUS_PROJETO,
       CASE
           WHEN m33.idFinanceira = '3066772'
                AND m33.matriculaUsuarioLogado = 'rotina.automatica' THEN CAST(NULLIF(m33.parcela, '') AS DECIMAL(15, 2))
           WHEN m33.parcela NOT REGEXP '[0-9]' THEN NULL
           WHEN m33.parcela LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.parcela, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m33.parcela, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS VALOR_PARCELA,
       m33.carencia AS CARENCIA,
       m33.qntParcela AS QTD_PARCELA,
       CASE
           WHEN m33.idFinanceira = '3066772'
                AND m33.matriculaUsuarioLogado = 'rotina.automatica' THEN CAST(NULLIF(m33.valorAprovado, '') AS DECIMAL(15, 2))
           WHEN m33.valorAprovado NOT REGEXP '[0-9]' THEN NULL
           WHEN m33.valorAprovado LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorAprovado, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m33.valorAprovado, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS VALOR_APROVADO,
       m33.classificacaoCliente AS CLASSE_CLIENTE,
       m33.descricaoAnalise AS Desc_Analise,
       CASE
           WHEN m33.dataAnalise REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN STR_TO_DATE(REPLACE(m33.dataAnalise, 'T', ' '), CASE
                                                                                                                              WHEN m33.dataAnalise LIKE '%T%'
                                                                                                                                   OR m33.dataAnalise LIKE '% %' THEN '%Y-%m-%d %H:%i:%s'
                                                                                                                              ELSE '%Y-%m-%d'
                                                                                                                          END)
       END AS DATA_RETORNO,
       m33.opcaoEscolhida AS Opcao_Escolhida,
       CASE
           WHEN m33.retencaoFinanceira NOT REGEXP '[0-9]' THEN NULL
           WHEN m33.retencaoFinanceira LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.retencaoFinanceira, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m33.retencaoFinanceira, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS RETENCAO_FINANCEIRA,
       CASE
           WHEN m33.valorTotalFinanciamento REGEXP '[0-9]' THEN CAST(REGEXP_REPLACE(m33.valorTotalFinanciamento, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS VALOR_FINANCIAMENTO,
       m33.statusFinanceira AS STATUS,
       CASE
           WHEN m33.taxa NOT REGEXP '[0-9]' THEN NULL
           WHEN m33.taxa LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.taxa, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(6, 2))
           ELSE CAST(REGEXP_REPLACE(m33.taxa, '[^0-9.-]', '') AS DECIMAL(6, 2))
       END AS TAXA_CLIENTE,
       m33.matriculaUsuarioLogado AS USUARIO_ADD_RETORNO,
       m33.matriculaPosEdicao AS USUARIO_EDIT_RETORNO,
       m33.idFinanceira AS ID_FINANCEIRA,
       m33.selecionaFinanceira AS FINANCEIRA,
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
       CASE
           WHEN m33.validadeAnalise REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(STR_TO_DATE(REPLACE(m33.validadeAnalise, 'T', ' '), CASE
                                                                                                                                           WHEN m33.validadeAnalise LIKE '%T%'
                                                                                                                                                OR m33.validadeAnalise LIKE '% %' THEN '%Y-%m-%d %H:%i:%s'
                                                                                                                                           ELSE '%Y-%m-%d'
                                                                                                                                       END))
       END AS VALIDADE_RETORNO,
       CASE
           WHEN m33.entradaFinanceira NOT REGEXP '[0-9]' THEN NULL
           WHEN m33.entradaFinanceira LIKE '%,%' THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.entradaFinanceira, '[^0-9,.-]', ''), '.', ''), ',', '.') AS DECIMAL(15, 2))
           ELSE CAST(REGEXP_REPLACE(m33.entradaFinanceira, '[^0-9.-]', '') AS DECIMAL(15, 2))
       END AS ENTRADA_RETORNO,
       m33.usarValorTotalDiferenciado AS APROVAR_VALOR_DIF_RETORNO,
       m33.tabelaFinanceira AS TABELA_FINANCEIRA_RETORNO,
       CASE
           WHEN m30.atividade = '15' THEN 'Sim'
           ELSE 'Não'
       END AS retirar_finalizarperdida,
       CASE
           WHEN TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
           WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> '' THEN TRIM(m30.marcaInversorPromocaoDesc)
           ELSE 'Venda Avulsa'
       END AS tipo_inversor,
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
FROM ML001030 m30
JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
JOIN ML001033 m33 ON m33.companyid = m30.companyid
AND m33.masterid = m30.ID
WHERE d.COD_EMPRESA = 1
  AND d.COD_LISTA = 30
  AND d.VERSAO_ATIVA = 1
  AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
  AND m33.idFinanceira <> ''
  AND m33.selecionaFinanceira <> ''
  AND m30.atividadeDesc <> ''
  AND m30.proposta <> '00000NaN';