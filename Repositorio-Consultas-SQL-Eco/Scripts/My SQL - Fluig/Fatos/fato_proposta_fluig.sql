SELECT m30.proposta AS PROPOSTA,
       m30.entradaImputado AS FILIAL,
       m30.contrato_protheus AS NUMERO_CONTRATO,
       TRIM(CONCAT(TRIM(m30.entradaImputado), TRIM(m30.contrato_protheus))) AS filialcontrato,
       CASE
           WHEN m30.dataCriacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataCriacao)
       END AS DATA_CRIACAO,
       CASE
           WHEN m30.dataAtualizacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataAtualizacao)
       END AS DATA_ATUALIZACAO,
       m30.atividade AS cod_status,
       m30.atividadeDesc AS STATUS_PROJETO,
       m30.tipoFinanciamentoDesc AS pf_pj,
       m30.tipoSimulacaoDesc AS TIPO_SIMULACAO,
       m30.nomeRazaoCli AS NOME_CLIENTE,
       m30.documentoIdent AS DOCUMENTO,
       m30.email AS Email_Cliente,
       m30.telefone AS Tel_Cliente,
       m30.celular AS Cel_Cliente,
       CASE
           WHEN m30.dataNascimento REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataNascimento)
       END AS Data_Nascimento,
       m30.rendaMensal AS Renda_Mensal,
       m30.faturamentoMensal AS Faturamento_Mensal,
       m30.cidadeInstalacaoDesc AS CIDADE,
       m30.estadoInstalacao AS ESTADO,
       m30.origemCliente AS ORIGEM_CLIENTE,
       m30.descricaoUnidade AS UNIDADE,
       m30.nomeFranqueado AS NOME_VENDEDOR,
       m30.telefoneFranqueado AS Tel_Franqueado,
       m30.classe AS CLASSE,
       m30.localInstalacaoDesc AS LOCAL_INSTALACAO,
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
       m30.ciaPF_desc AS COMPANHIA,
       m30.marcaInversorPromocaoDesc AS LINHA_INVERSOR_PROMOCAO,
       m30.marcaInversorDesc AS LINHA_INVERSOR_CONVENCIONAL,
       m30.produto_protheus AS Codigo_Produto,
       m30.tensao AS Tensao,
       m30.abrigo AS ABRIGO,
	   CASE WHEN m30.potenciaSimul REGEXP '[0-9]'
     		THEN CAST(TRIM(m30.potenciaSimul) + 0 AS DECIMAL(10,2))
	   END AS POTENCIA,
       m30.geracaoSimul AS GERACAO,
       m30.inversoresSimul AS INVERSORES,
       m30.modulosSimulDesc AS MODULOS,
       m30.modulosSimul AS QTD_MODULOS,
       m30.aceitaFiname AS FINAME,
       CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.-]', ''), '.', ''), ',', '.'), '') AS DECIMAL(15, 2)) AS VALOR_FINAL,
       m30.descontoDado AS PORCENT_DESCONTO,
       m30.percentualComissaoCalculado AS COMISSAO_CALCULADA,
       m30.percentualComissao AS COMISSAO_DIFERENCIADA,
       m30.vendedor_protheus AS VENDEDOR_PROTHEUS,
       m30.executivo_protheus AS EXECUTIVO_PROTHEUS,
       m30.prazoInstalacaoContrato AS PRAZO_INSTALAÇÃO,
       m30.prazoEntregaFrontline AS PRAZO_ENTREGA_FRONTLINE,
       CASE
           WHEN m30.statusBV = 'Aprovado' THEN 'Sim'
           WHEN m30.statusBV = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusLosango = 'Aprovado' THEN 'Sim'
           WHEN m30.statusLosango = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusSantander = 'Aprovado' THEN 'Sim'
           WHEN m30.statusSantander = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusTMX = 'Aprovado' THEN 'Sim'
           WHEN m30.statusTMX = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusBTG = 'Aprovado' THEN 'Sim'
           WHEN m30.statusBTG = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusOmni = 'Aprovado' THEN 'Sim'
           WHEN m30.statusOmni = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusHorwin = 'Aprovado' THEN 'Sim'
           WHEN m30.statusHorwin = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusGrenke = 'Aprovado' THEN 'Sim'
           WHEN m30.statusGrenke = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusConectepag = 'Aprovado' THEN 'Sim'
           WHEN m30.statusConectepag = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusAventis = 'Aprovado' THEN 'Sim'
           WHEN m30.statusAventis = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusCRIEcopower = 'Aprovado' THEN 'Sim'
           WHEN m30.statusCRIEcopower = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusFIDCEcopower = 'Aprovado' THEN 'Sim'
           WHEN m30.statusFIDCEcopower = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusEOS = 'Aprovado' THEN 'Sim'
           WHEN m30.statusEOS = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusCieloRecorrente = 'Aprovado' THEN 'Sim'
           WHEN m30.statusCieloRecorrente = 'Pre Aprovado' THEN 'Sim'
           WHEN m30.statusPortoBank = 'Aprovado' THEN 'Sim'
           WHEN m30.statusPortoBank = 'Pre Aprovado' THEN 'Sim'
           ELSE 'Não'
       END AS Aprovado,
       CASE
           WHEN m30.tipoTrocaSimulacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.tipoTrocaSimulacao)
       END AS data_negociacao,
       m30.cidadeInstalacao AS cod_cidade_instalacao,
       m30.codigoUnidade AS cod_unidade,
       m30.formasDePagEfetivadas AS forma_de_pagamento,
       CASE
           WHEN TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
           WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> '' THEN TRIM(m30.marcaInversorPromocaoDesc)
           ELSE 'Venda Avulsa'
       END AS tipo_inversor,
       CASE
           WHEN m30.atividade = '15' THEN 'Sim'
           ELSE 'Não'
       END AS retirar_finalizarperdida,
       NOW() AS data_stamp
FROM ML001030 m30
JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
WHERE d.COD_EMPRESA = 1
  AND d.COD_LISTA = 30
  AND d.VERSAO_ATIVA = 1
  AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
  AND m30.atividadeDesc <> ''
  AND m30.proposta <> '00000NaN';