	WITH ClientesRankeados AS (
    SELECT 
        A1_COD AS cod_cliente,
        RTRIM(LTRIM(TRIM(A1_NREDUZ))) AS nome_cliente_reduzido,
        A1_PESSOA AS tipo_cliente,
        CASE 
            WHEN A1_PESSOA = 'F' THEN 'Pessoa Fisica'
            WHEN A1_PESSOA = 'J' THEN 'Pessoa Juridica'
        END AS tipo_cliente2,
        -- Critério de desempate: PRIORIZA PJ sobre PF
        CASE 
            WHEN A1_PESSOA = 'J' THEN 1  -- Prioridade máxima para PJ
            WHEN A1_PESSOA = 'F' THEN 2  -- Segunda prioridade para PF
            ELSE 3
        END AS prioridade_tipo,
        -- Critério secundário: nome mais completo
        LEN(RTRIM(LTRIM(TRIM(A1_NREDUZ)))) AS tamanho_nome,
        ROW_NUMBER() OVER (
            PARTITION BY A1_COD 
            ORDER BY 
                A1_PESSOA ASC,      -- Primeiro: PJ tem preferência
                A1_NREDUZ DESC,        -- Segundo: nome mais longo
                A1_NREDUZ ASC -- Terceiro: ordem alfabética
        ) AS ranking
    FROM SA1010 
    WHERE 1 = 1
)
SELECT 
    cod_cliente,
    nome_cliente_reduzido,
    tipo_cliente,
    tipo_cliente2
FROM ClientesRankeados
WHERE ranking = 1