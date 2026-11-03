SELECT
    m30.proposta          AS proposta,
    m30.entradaImputado   AS filial,
    m30.contrato_protheus AS contrato,
    CASE WHEN m30.dataCriacao     REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataCriacao)     END AS data_criacao,
    CASE WHEN m30.dataAtualizacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.dataAtualizacao) END AS data_atualizacao,
    CAST(m30.atividade AS SIGNED) AS cod_status_projeto,
    m30.atividadeDesc         AS status_projeto,
    m30.tipoFinanciamentoDesc AS pf_pj,
    m30.tipoSimulacaoDesc     AS tipo_simulacao,
    m30.nomeRazaoCli          AS cliente,
    m30.documentoIdent        AS documento,
    m30.email                 AS email_cliente,
    m30.telefone              AS tel_cliente,
    m30.celular               AS cel_cliente,
    m30.dataNascimento AS data_nascimento,
    m30.rendaMensal  AS renda_mensal,
    m30.faturamentoMensal AS faturamento_mensal,
    m30.sexo                 AS genero,
    m30.nomeMae              AS nome_mae,
    m30.cargo                AS cargo,
    m30.cepInstalacao        AS cep_instalacao,
    m30.enderecoInstalacaoFicha AS endereco_instalacao,
    m30.bairroInstalacao     AS bairro_instalacao,
    m30.numeroInstalacao     AS numero_instalacao,
    m30.cidadeInstalacao     AS cod_cidade_instalacao,
    m30.cidadeInstalacaoDesc AS cidade_instalacao,
    m30.estadoInstalacao     AS estado_instlacao,
    m30.situacaoResidencia   AS situacao_residencia_pf,
    m30.situacaoResidenciaPJ AS situacao_residencia_pj,
    CASE WHEN m30.origemCliente = '' OR m30.origemCliente IS NULL THEN 'Sem Origem'
         ELSE m30.origemCliente END AS origem_cliente,
    m30.descricaoUnidade   AS unidade,
    m30.nomeFranqueado     AS vendedor,
    m30.telefoneFranqueado AS tel_franqueado,
    m30.validadeProposta AS validade,
    m30.classe AS classe,
    CASE 
        WHEN m30.classe = '' AND m30.tipoSimulacaoDesc = '5. Cota de Potência em Usina EcoPower' THEN 'Cota em Usina'
        WHEN m30.classe = '' AND m30.tipoSimulacaoDesc = '3. Cota de Potência em Usina EcoPower' THEN 'Cota em Usina'
        WHEN m30.classe = '' AND m30.tipoSimulacaoDesc = '4. Venda Avulsa' THEN 'Venda Avulsa'
        WHEN m30.classe = '' AND m30.tipoSimulacaoDesc = '13. Venda Avulsa' THEN 'Venda Avulsa'
        WHEN m30.classe = '' AND m30.tipoSimulacaoDesc = '5. Uso Próprio Convencional' THEN 'Sem Classe'
        WHEN m30.classe = '' AND m30.tipoSimulacaoDesc = '' THEN 'Sem Classe'
        ELSE m30.classe
    END AS classe_ajustada,
    m30.localInstalacaoDesc AS local_instalacao,
    CASE WHEN m30.tipoTrocaSimulacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.tipoTrocaSimulacao) END AS data_fin_comercial_fluig,
    CASE WHEN m30.regiaoInstalacao     REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.regiaoInstalacao)     END AS data_recebimento,
    CASE WHEN m30.regiaoInstalacaoDesc REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.regiaoInstalacaoDesc) END AS data_liberacao_fin,
    CASE WHEN m30.valorTabelaSimul NOT REGEXP '[0-9]' THEN NULL
         WHEN m30.valorTabelaSimul LIKE '%,%'
              THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaSimul,'[^0-9,.-]',''),'.',''),',','.') AS DECIMAL(15,2))
         ELSE CAST(REGEXP_REPLACE(m30.valorTabelaSimul,'[^0-9.-]','') AS DECIMAL(15,2)) END AS valor_tabela_simulacao,
    CASE WHEN m30.valorTabelaTotal NOT REGEXP '[0-9]' THEN NULL
         WHEN m30.valorTabelaTotal LIKE '%,%'
              THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorTabelaTotal,'[^0-9,.-]',''),'.',''),',','.') AS DECIMAL(15,2))
         ELSE CAST(REGEXP_REPLACE(m30.valorTabelaTotal,'[^0-9.-]','') AS DECIMAL(15,2)) END AS valor_tabela_total,
    CASE WHEN m30.valorDescontoSimul NOT REGEXP '[0-9]' THEN NULL
         WHEN m30.valorDescontoSimul LIKE '%,%'
              THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoSimul,'[^0-9,.-]',''),'.',''),',','.') AS DECIMAL(15,2))
         ELSE CAST(REGEXP_REPLACE(m30.valorDescontoSimul,'[^0-9.-]','') AS DECIMAL(15,2)) END AS valor_desconto_simulacao,
    CASE WHEN m30.valorDescontoTotal NOT REGEXP '[0-9]' THEN NULL
         WHEN m30.valorDescontoTotal LIKE '%,%'
              THEN CAST(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorDescontoTotal,'[^0-9,.-]',''),'.',''),',','.') AS DECIMAL(15,2))
         ELSE CAST(REGEXP_REPLACE(m30.valorDescontoTotal,'[^0-9.-]','') AS DECIMAL(15,2)) END AS valor_desconto_total,
    m30.ciaPF_desc                AS companhia,
    m30.marcaInversorPromocaoDesc AS linha_inversor_promocao,
    m30.marcaInversorDesc         AS linha_inversor_convencional,
    m30.produto_protheus          AS codigo_produto,
    m30.tensao                    AS tensao,
    m30.tensaoPJ                  AS tensao_pj,
    m30.abrigo                    AS abrigo,
       CASE WHEN m30.potenciaSimul REGEXP '[0-9]'
            THEN CAST(TRIM(m30.potenciaSimul) + 0 AS DECIMAL(10,2))
       END AS potencia,
    m30.geracaoSimul     AS geracao,
    m30.inversoresSimul  AS inversores,
    m30.modulosSimulDesc AS modulos,
    m30.modulosSimul     AS qtd_modulos,
    m30.aceitaFiname     AS finame,
    CAST(NULLIF(REPLACE(REPLACE(REGEXP_REPLACE(m30.valorASerPago,'[^0-9,.-]',''),'.',''),',','.'),'') AS DECIMAL(15,2)) AS valor_final,
    m30.descontoDado AS porcent_desconto,
    m30.percentualComissaoCalculado AS comissao_calculada,
    m30.percentualComissao          AS comissao_diferenciada,
    m30.vendedor_protheus           AS vendedor_protheus,
    m30.executivo_protheus          AS executivo_protheus,
    m30.prazoInstalacaoContrato     AS prazo_instalacao,
    m30.prazoEntregaFrontline       AS prazo_entrega_frontline,
    IFNULL(m30.statusBV, '')              AS bv,
    IFNULL(m30.statusLosango, '')         AS losango,
    IFNULL(m30.statusTMX, '')             AS sol_agora,
    IFNULL(m30.statusSantander, '')       AS santander,
    IFNULL(m30.statusBTG, '')             AS aprovoou,
    IFNULL(m30.statusOmni, '')            AS omni,
    IFNULL(m30.statusHorwin, '')          AS horwin,
    IFNULL(m30.statusGrenke, '')          AS grenke,
    IFNULL(m30.statusConectepag, '')      AS conectepag,
    IFNULL(m30.statusAventis, '')         AS aventis,
    IFNULL(m30.statusCRIEcopower, '')     AS criecopower,
    IFNULL(m30.statusFIDCEcopower, '')    AS fidcecopower,
    IFNULL(m30.statusEOS, '')             AS eos,
    IFNULL(m30.statusCieloRecorrente, '') AS cielorecorrente,
    IFNULL(m30.statusPortoBank, '')       AS porto_bank,
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
    END AS aprovado,
    CASE WHEN m30.tipoTrocaSimulacao REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN DATE(m30.tipoTrocaSimulacao) END AS data_negociacao,
    m30.codigoUnidade AS cod_unidade,
    CASE
        WHEN TRIM(IFNULL(m30.marcaInversorDesc, ''))         <> '' THEN TRIM(m30.marcaInversorDesc)
        WHEN TRIM(IFNULL(m30.marcaInversorPromocaoDesc, '')) <> '' THEN TRIM(m30.marcaInversorPromocaoDesc)
        ELSE 'Venda Avulsa'
    END AS tipo_inversor,
    m30.formasDePagEfetivadas AS forma_de_pagamento,
    m30.chkFreteComercial     AS cod_frete_prioridade_comercial,
    CASE m30.chkFreteComercial WHEN 'true' THEN 'SIM' ELSE 'NÃO' END AS frete_prioridade_comercial,
    m30.chkFreteFrontline     AS cod_frete_frontline,
    CASE m30.chkFreteFrontline WHEN 'true' THEN 'SIM' ELSE 'NÃO' END AS frete_frontline,
    CASE WHEN m30.atividade = '15' THEN 'Sim' ELSE 'Não' END AS finalizar_perdida,
    CASE 
        WHEN m30.nomeMesaLead = 'Camila Santana da Cruz'   THEN 'Camila Cruz'
        WHEN m30.nomeMesaLead = 'Daniel Trentini Feijão'   THEN 'Daniel Feijão'
        WHEN m30.nomeMesaLead = 'Daniela Siqueira da Silva' THEN 'Daniela Silva'
        WHEN m30.nomeMesaLead = 'SAMARA RODRIGUES ALCANTARA' THEN 'Samara Alcantara'
        WHEN m30.nomeMesaLead = 'Soraya Cristina da Silva' THEN 'Soraya Silva'
        ELSE m30.nomeMesaLead
    END AS nome_mesa_lead,
    CASE WHEN m30.descricaoAcao = '' OR m30.descricaoAcao IS NULL THEN 'N/A'
         ELSE m30.descricaoAcao END AS descricao_acao,
    NOW() AS data_stamp
FROM ML001030 m30
JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
WHERE d.COD_EMPRESA  = 1 
  AND d.COD_LISTA    = 30
  AND d.VERSAO_ATIVA = 1
  AND m30.dataCriacao BETWEEN '2022-01-01 00:00:00' AND '2026-12-31 23:59:59'
  AND m30.atividadeDesc <> ''
  AND m30.proposta      <> '00000NaN';