SELECT
    m30.proposta AS PROPOSTA,
    m30.entradaImputado AS FILIAL,
    m30.contrato_protheus AS NUMERO_CONTRATO,
    m30.nomeRazaoCli AS NOME_CLIENTE,
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
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_FINAL,
    m30.atividade AS cod_status_projeto,
    m30.atividadeDesc AS STATUS_PROJETO,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.parcela, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_PARCELA,
    m33.carencia AS CARENCIA,
    m33.qntParcela AS QTD_PARCELA,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorAprovado, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_APROVADO,
    m33.classificacaoCliente AS CLASSE_CLIENTE,
    m33.descricaoAnalise AS Desc_Analise,
    CONVERT(STR_TO_DATE(REPLACE(m33.dataAnalise, 'T', ''),'%Y-%m-%d %H:%i:%s'), DATE) AS DATA_RETORNO,
    m33.opcaoEscolhida AS Opcao_Escolhida,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.retencaoFinanceira, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS RETENCAO_FINANCEIRA,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m33.valorTotalFinanciamento, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS VALOR_FINANCIAMENTO,
    m33.statusFinanceira AS STATUS,
    CAST(m33.taxa AS DECIMAL (6,2)) AS TAXA_CLIENTE,
    m33.matriculaUsuarioLogado AS USUARIO_ADD_RETORNO,
    m33.matriculaPosEdicao AS USUARIO_EDIT_RETORNO,
    m33.idFinanceira AS ID_FINANCEIRA,
    m33.selecionaFinanceira AS FINANCEIRA,
    CASE m33.idFinanceira
        WHEN '206' THEN 'Banco Aprovoou'
        WHEN '207' THEN 'BV Financeira'
        WHEN '208' THEN 'Banco Santander'
        WHEN '209' THEN 'Losango'
        WHEN '1701' THEN 'Banco SICREDI'
        WHEN '459345' THEN 'Tabela BV Financeira'
        WHEN '1270181'  THEN 'Desconto Sol Agora'
        WHEN '1481184'  THEN 'Cessão Losango'
        WHEN '1481222'  THEN 'Cessão Banco Santander'
        WHEN '1481223'  THEN 'Cessão Banco Aprovoou'
        WHEN '2070700'  THEN 'Desconto Cessão Losango'
        WHEN '2920025'  THEN 'Locação Grenke'
        WHEN '2920030'  THEN 'Omni'
        WHEN '3066772'  THEN 'Conectepag'
        WHEN '3137117'  THEN 'Horwin'
        WHEN '3238254'  THEN 'Aventis'
        WHEN '3238261'  THEN 'CRI EcoPower'
        WHEN '3238262'  THEN 'FIDC EcoPower'
        WHEN '3303892'  THEN 'Cielo Recorrente'
        WHEN '3303897'  THEN 'EOS'
        WHEN '3303899'  THEN 'Porto Bank'       
    END AS financeira_reduzido,
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
    JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
    JOIN ML001033 m33 ON m33.companyid = m30.companyid
    AND m33.masterid = m30.ID
WHERE
    d.COD_EMPRESA = 1 
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m33.dataAnalise BETWEEN '2025-01-01T00:00:00' AND '2026-12-31T23:59:59'
    AND m33.dataAnalise <> ''
    AND m33.idFinanceira <> ''
    AND m33.selecionaFinanceira <> ''
    AND m30.atividadeDesc <> ''
    AND m30.proposta <> '00000NaN'

