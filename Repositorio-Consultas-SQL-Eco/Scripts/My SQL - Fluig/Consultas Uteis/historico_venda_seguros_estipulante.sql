WITH ClientesAgrupados AS (
    SELECT 
		m30.proposta AS proposta,
		m30.entradaImputado AS filial,
        m30.contrato_protheus AS contrato,
        CAST(REPLACE(REPLACE(REGEXP_REPLACE(m55.valorUnitProdutosAdicionais, '[^0-9,.]', ''),'.',''),',','.') AS DECIMAL(10,2)) AS valUnitarioProdutoAdicional
    FROM DOCUMENTO d
    JOIN ML001030 m30 
    ON m30.companyid = d.COD_EMPRESA
    AND m30.documentid = d.NR_DOCUMENTO
    AND m30.version = d.NR_VERSAO
    JOIN ML001055 m55 ON m55.companyid = m30.companyid
    AND m55.documentid = m30.documentid
    AND m55.version = m30.version
	WHERE COD_EMPRESA = 1
    AND VERSAO_ATIVA = 1
    AND m30.dataAtualizacao BETWEEN '2025-01-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m55.produtosAdicionaisDesc LIKE '%SEGURO%'
    AND m30.atividade IN ('14', '22')
)
SELECT 
	"YELUM ENERGIA SOLAR" AS produto,
	"Integrador" AS condicao,
	m30.proposta AS proposta,
	"1" AS parcela,
	"ECOPOWER EFICIENCIA ENERGETICA LTDA." AS nome_estipulante,
	"18269815000136" AS cnpj_estipulante,
	"DELMIRO JOSE DE ANDRADE" AS endereco_estipulante,
	"(17) 4000-1722" AS telefone_estipulante,
	m30.nomeRazaoCli AS nome_cliente,
	m30.nomeRazaoCli AS segurado,
	TRIM(REPLACE(REPLACE(REPLACE(m30.documentoIdent, "/", ""), ".", ""), "-", "")) AS documento,
	m30.celular AS cel_cliente,
	m30.enderecoInstalacaoFicha AS rua,
	m30.numeroInstalacao AS numero,
	m30.complementoInstalacao AS complemento,
	m30.bairroInstalacao AS bairro,
	m30.cidadeInstalacaoDesc AS cidade,
	m30.estadoInstalacao AS estado,
	m30.cepInstalacao AS cep,
	CAST((((ca.valUnitarioProdutoAdicional - ((m30.descontoDado / 100) * ca.valUnitarioProdutoAdicional))*100) / 1.5) AS DECIMAL (10,2)) AS valorProjetoSegurado
FROM DOCUMENTO d
    JOIN ML001030 m30 
    ON m30.companyid = d.COD_EMPRESA
    AND m30.documentid = d.NR_DOCUMENTO
    AND m30.version = d.NR_VERSAO
    JOIN ML001055 m55 ON m55.companyid = m30.companyid
    AND m55.documentid = m30.documentid
    AND m55.version = m30.version
    JOIN ClientesAgrupados ca
    ON ca.proposta = m30.proposta
    AND ca.contrato =  m30.contrato_protheus
WHERE 1 = 1
	AND COD_EMPRESA = 1
    AND VERSAO_ATIVA = 1
    AND m30.dataAtualizacao BETWEEN '2025-01-01 00:00:00' AND '2026-12-31 23:59:59'
    AND m55.produtosAdicionaisDesc LIKE '%SEGURO%'
    AND m30.atividade IN ('14', '22')

