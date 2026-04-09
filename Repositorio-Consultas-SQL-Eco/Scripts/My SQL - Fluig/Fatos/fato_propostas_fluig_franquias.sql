SELECT
    m30.tipoSimulacaoDesc AS tipo_simulacao,
    m30.proposta AS proposta,
    m30.entradaImputado AS filial,
    m30.contrato_protheus AS contrato,
    CONVERT(m30.dataCriacao, DATE) AS data_criacao,
    CONVERT(m30.dataAtualizacao, DATE) AS data_atualizacao,
    CAST(m30.atividade AS SIGNED) AS cod_status_projeto,
    m30.atividadeDesc AS status_projeto,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.documentoIdent AS documento,
    m30.nomeRazaoCli AS cliente,
    m30.sexo as genero,
    m30.enderecoInstalacaoFicha as endereco_instalacao,
    m30.bairroInstalacao as bairro_instalacao,
    m30.numeroInstalacao as numero_instalacao,
    m30.cidadeInstalacao as cod_cidade_instalacao,
    m30.cidadeInstalacaoDesc AS cidade_instalacao,
    m30.estadoInstalacao as estado_instalcao,
    CASE 
        WHEN m30.estadoInstalacao IN ('AC','AM','AP','PA','RO','RR','TO') THEN 'Norte'
        WHEN m30.estadoInstalacao IN ('AL','BA','CE','MA','PB','PE','PI','RN','SE') THEN 'Nordeste'
        WHEN m30.estadoInstalacao IN ('DF','GO','MT','MS') THEN 'Centro-Oeste'
        WHEN m30.estadoInstalacao IN ('ES','MG','RJ','SP') THEN 'Sudeste'
        WHEN m30.estadoInstalacao IN ('PR','RS','SC') THEN 'Sul'
    ELSE 'Região não identificada'
    END AS regiao,
    m30.origemCliente AS origem_cliente,
    m30.codigoUnidade AS cod_unidade,
    m30.descricaoUnidade AS unidade,
    m30.nomeFranqueado AS vendedor,
    m30.classe AS classe,
    m30.localInstalacaoDesc AS local_instalacao,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_fin_comercial_fluig, 
    CONVERT(m30.regiaoInstalacao, DATE) AS data_recebimento, 
    CONVERT(m30.regiaoInstalacaoDesc, DATE) AS data_liberacao_fin, 
    m30.ciaPF_desc AS companhia,
    m30.marcaInversorPromocaoDesc AS linha_inversor_promocao,
    m30.marcaInversorDesc AS linha_inversor_convencional,
    m30.produto_protheus AS codigo_produto,
    m30.tensao AS tensao,
    m30.tensaoPJ AS tensao_pj,
    CAST(m30.potenciaSimul AS DECIMAL (10,2)) AS potencia,
    m30.geracaoSimul AS geracao,
    m30.inversoresSimul AS inversores,
    m30.modulosSimulDesc AS modulos,
    m30.modulosSimul AS qtd_modulos,
    m30.aceitaFiname AS finame,
    CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valor_final,
    CAST(m30.descontoDado AS DECIMAL (5,2)) AS porcent_desconto,
    m30.vendedor_protheus AS cod_vendedor_protheus,
    m30.executivo_protheus AS cod_executivo_protheus,      
    m30.prazoInstalacaoContrato AS prazo_instalacao,
    m30.prazoEntregaFrontline AS prazo_entrega_frontline,
    CONVERT(m30.tipoTrocaSimulacao, DATE) AS data_negociacao,
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
    CASE 
        WHEN m30.atividade = '15' THEN 'Sim'
    ELSE 'Não' 
    END AS finalizar_perdida,
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
