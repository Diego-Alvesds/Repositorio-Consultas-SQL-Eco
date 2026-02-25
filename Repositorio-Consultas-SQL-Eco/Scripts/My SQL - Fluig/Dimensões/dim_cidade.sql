SELECT DISTINCT
    TRIM(REPLACE(m.documentid, ',', '' )) AS cod_cidade_instalacao,
    m.cidade,
    m.estado,
    CONCAT(m.cidade, ' - ', m.estado) AS cidade_estado,
    m.ddd,
    m.taxaFrete AS taxa_frete,
    m.latitude,
    m.longitude,
    m.codigoIBGE AS codigo_ibge
FROM ML001017 m
INNER JOIN (
    SELECT
        documentid,
        MAX(version) AS max_version
    FROM ML001017
    WHERE companyid = 1
    GROUP BY documentid
) ult
    ON m.documentid = ult.documentid
   AND m.version = ult.max_version
WHERE m.companyid = 1
AND m.documentid NOT IN ("12440", "249962", "262360", "12767", "1946037", "12795", "2066092", "2670938", "9817")


