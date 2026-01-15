SELECT
    m30.proposta AS proposta,
    m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
    CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    m30.atividadeDesc AS status_projeto,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.tipoSimulacaoDesc AS tipo_simulacao,
    m30.nomeRazaoCli AS cliente,
    m30.documentoIdent AS documento,
    m30.email AS email_cliente,
    m30.telefone AS tel_cliente,
    m30.celular AS cel_cliente,
    CONVERT(m30.dataNascimento, DATE) AS data_nascimento,
    CAST(REPLACE(REPLACE(NULLIF(TRIM(m30.rendaMensal), ''), '.', ''),',', '.') AS DECIMAL(10,2)) AS renda_mensal,
    CAST(REPLACE(REPLACE(NULLIF(TRIM(m30.faturamentoMensal), ''), '.', ''),',', '.') AS DECIMAL(10,2)) AS faturamento_mensal,
    m30.sexo as genero,
    m30.nomeMae as nome_mae,
    m30.cargo as cargo,
    m30.cepInstalacao as cep_instalacao,
    m30.enderecoInstalacaoFicha as endereco_instalacao,
    m30.bairroInstalacao as bairro_instalacao,
    m30.numeroInstalacao as numero_instalacao,
    m30.cidadeInstalacao as cidade_instalacao,
    m30.estadoInstalacao as estado_instlacao,
    m30.situacaoResidencia as situacao_residencia_pf,
    m30.situacaoResidenciaPJ as situacao_residencia_pj,
    m30.cidadeInstalacaoDesc AS cidade,
    m30.estadoInstalacao AS estado,
    m30.origemCliente AS origem_cliente,
    m30.descricaoUnidade AS unidade,
    m30.nomeFranqueado AS vendedor,
    m30.telefoneFranqueado AS tel_franqueado,   
    CONVERT(m30.validadeProposta, DATE) AS validade, 
    m30.classe AS classe,
    m30.localInstalacaoDesc AS local_instalacao,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_fin_comercial_fluig, 
    CONVERT(m30.regiaoInstalacao, DATE) AS data_recebimento, 
    CONVERT(m30.regiaoInstalacaoDesc, DATE) AS data_liberacao_fin, 
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaSimul, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_TABELA_SIMUL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaTotal, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_TABELA_TOTAL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoSimul, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_DESCONTO_SIMUL,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoTotal, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_DESCONTO_TOTAL,
    m30.ciaPF_desc AS companhia,
    m30.marcaInversorPromocaoDesc AS LINHA_INVERSOR_PROMOCAO,
    m30.marcaInversorDesc AS LINHA_INVERSOR_CONVENCIONAL,
    m30.produto_protheus AS Codigo_Produto,
    m30.tensao AS tensao,
    m30.abrigo AS abrigo,
    CAST(m30.potenciaSimul AS DECIMAL (10,2)) AS potencia,
    m30.geracaoSimul AS geracao,
    m30.inversoresSimul AS INVERSORES,
    m30.modulosSimulDesc AS MODULOS,
    m30.modulosSimul AS QTD_MODULOS,
    m30.aceitaFiname AS FINAME,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_FINAL,
    CAST(m30.descontoDado AS DECIMAL (5,2)) AS PORCENT_DESCONTO,
    m30.percentualComissaoCalculado AS COMISSAO_CALCULADA,
    m30.percentualComissao AS COMISSAO_DIFERENCIADA,   
    m30.vendedor_protheus AS VENDEDOR_PROTHEUS,
    m30.executivo_protheus AS EXECUTIVO_PROTHEUS,      
    m30.prazoInstalacaoContrato AS prazo_instalacao,
    m30.prazoEntregaFrontline AS PRAZO_ENTREGA_FRONTLINE,
    IFNULL(m30.statusBV, '') BV,
    IFNULL(m30.statusLosango, '') LOSANGO,
    IFNULL(m30.statusTMX, '') SOL_AGORA,
    IFNULL(m30.statusSantander, '') SANTANDER,
    IFNULL(m30.statusBTG, '') Aprovoou,
    IFNULL(m30.statusOmni, '') Omni,
    IFNULL(m30.statusHorwin, '') Horwin,
    IFNULL(m30.statusGrenke, '') Grenke,
    IFNULL(m30.statusConectepag, '') Conectepag,
    IFNULL(m30.statusAventis, '') Aventis,
    IFNULL(m30.statusCRIEcopower, '') CRIEcopower,
    IFNULL(m30.statusFIDCEcopower, '') FIDCEcopower,
    IFNULL(m30.statusEOS, '') EOS,
    IFNULL(m30.statusCieloRecorrente, '') CieloRecorrente,
    IFNULL(m30.statusPortoBank, '') PortoBank,
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
        WHEN m30.statusConectepag  = 'Aprovado' THEN 'Sim'
        WHEN m30.statusConectepag = 'Pre Aprovado' THEN 'Sim'    
        WHEN m30.statusAventis  = 'Aprovado' THEN 'Sim'
        WHEN m30.statusAventis = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusCRIEcopower  = 'Aprovado' THEN 'Sim'
        WHEN m30.statusCRIEcopower = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusFIDCEcopower  = 'Aprovado' THEN 'Sim'
        WHEN m30.statusFIDCEcopower = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusEOS  = 'Aprovado' THEN 'Sim'
        WHEN m30.statusEOS = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusCieloRecorrente  = 'Aprovado' THEN 'Sim'
        WHEN m30.statusCieloRecorrente = 'Pre Aprovado' THEN 'Sim'
        WHEN m30.statusPortoBank  = 'Aprovado' THEN 'Sim'
        WHEN m30.statusPortoBank = 'Pre Aprovado' THEN 'Sim'
        ELSE 'Não'
    END AS Aprovado,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_negociacao,
    m30.cidadeInstalacao AS cod_cidade_instalacao,
    m30.codigoUnidade AS cod_unidade,
    CASE
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) = TRIM(IFNULL(m30.marcaInversorDesc, '')) AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) = '' AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorDesc, '')) = '' AND TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> '' THEN TRIM(m30.marcaInversorPromocaoDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> TRIM(IFNULL(m30.marcaInversorDesc, '')) AND TRIM(IFNULL(m30.marcaInversorDesc, '')) <> '' THEN TRIM(m30.marcaInversorDesc)
        ELSE 'Venda Avulsa'
    END AS tipo_inversor,
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
FROM ML001030 m30
JOIN DOCUMENTO d 
ON d.COD_REG_LISTA = m30.ID
WHERE 1 = 1
    AND d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m30.atividadeDesc <> ''
    AND m30.proposta <> '00000NaN'
