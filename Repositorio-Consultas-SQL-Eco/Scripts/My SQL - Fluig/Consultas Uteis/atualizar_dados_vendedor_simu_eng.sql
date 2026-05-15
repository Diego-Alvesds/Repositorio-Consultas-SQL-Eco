-- Atualizar dados do franqueado no Simulador

SELECT
    m30.proposta,
    m30.nomeFranqueado,
    m30.matriculaFranqueado,
    m30.emailFranqueado,
    m30.telefoneFranqueado,
    m30.descricaoUnidade
FROM
    ML001030 m30
    JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
WHERE
    d.COD_EMPRESA = 1
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.proposta = '00448923'

UPDATE
    ML001030 m30
    JOIN DOCUMENTO d ON d.COD_REG_LISTA = m30.ID
SET
    m30.nomeFranqueado = 'Nayara Souza da Cunha',
    m30.matriculaFranqueado = 'nayara.cunha',
    m30.emailFranqueado = 'nayara.cunha@ecopower.com.br',
    m30.telefoneFranqueado = ''
WHERE
    d.COD_EMPRESA = 1
    AND d.COD_LISTA = 30
    AND d.VERSAO_ATIVA = 1
    AND m30.proposta = '00448923'

-- Atualizar dados do franqueado na engenharia

SELECT
    m52.propostaCliente,
    m52.nomeFranqueado,
    m52.matriculaFranqueado,
    m52.unidadeFranqueado
FROM
    ML001052 m52
    JOIN DOCUMENTO d ON d.COD_REG_LISTA = m52.ID
WHERE
    d.COD_EMPRESA = 1
    AND d.COD_LISTA = 52
    AND d.VERSAO_ATIVA = 1
    AND m52.propostaCliente = '00406217'

UPDATE
    ML001052 m52
    JOIN DOCUMENTO d ON d.COD_REG_LISTA = m52.ID
SET
    m52.nomeFranqueado = 'Nayara Souza da Cunha',
    m52.matriculaFranqueado = 'nayara.cunha'
WHERE
    d.COD_EMPRESA = 1
    AND d.COD_LISTA = 52
    AND d.VERSAO_ATIVA = 1
    AND m52.propostaCliente = '00406217'