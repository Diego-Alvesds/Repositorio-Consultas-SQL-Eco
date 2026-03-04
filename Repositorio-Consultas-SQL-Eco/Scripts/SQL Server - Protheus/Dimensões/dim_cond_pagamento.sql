
SELECT DISTINCT
	E4_FILIAL AS filial,
	E4_CODIGO AS cod_condicao_pagamento,
	CONCAT(E4_FILIAL, E4_CODIGO) AS filial_codpag,
	E4_COND AS condicao_pagamento,
	E4_DESCRI AS descricao_cond_pagamento,
	E4_FORMA AS forma_pagamento
FROM SE4010
WHERE 1 = 1