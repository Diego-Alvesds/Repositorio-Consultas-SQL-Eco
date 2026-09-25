SELECT
	u.FULL_NAME AS nome_usuario,
	ut.EMAIL AS email,
	ut.USER_CODE AS cod_usuario,
	ut.LOGIN AS login,
	CASE 
		WHEN ut.USER_STATE = 1 THEN "Ativo"
		WHEN ut.USER_STATE = 2 THEN "Inativo"
	END AS status
FROM
	FDN_USERTENANT AS ut
INNER JOIN FDN_USER u ON
	u.USER_ID = ut.USER_ID
WHERE
	TENANT_ID = 1