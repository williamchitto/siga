--Inserir aqui os scripts para cria��o da base


ALTER SESSION SET CURRENT_SCHEMA = corporativo;

	grant select on CP_TIPO_CONFIGURACAO to sigagc;
	grant select, references on CP_IDENTIDADE to sigagc;
	grant select on CP_TIPO_IDENTIDADE to sigagc;
	grant select, references on DP_PESSOA to sigagc;
	grant select, references on DP_LOTACAO to sigagc;
	grant select on CP_MARCADOR to sigagc;
	grant select on CP_TIPO_MARCA to sigagc;
	grant select on CP_TIPO_MARCADOR to sigagc;
	grant select on CP_COMPLEXO to sigagc;
	grant select on DP_CARGO to sigagc;
	grant select on DP_FUNCAO_CONFIANCA to sigagc;
	grant select on CP_SERVICO to sigagc;
	grant select, references on CP_GRUPO to sigagc;
	grant select on CP_SITUACAO_CONFIGURACAO to sigagc;
	grant select on cp_feriado to sigagc;
	grant select on cp_localidade to sigagc;
	grant select on cp_modelo to sigagc;
	grant select on cp_orgao to sigagc;
	grant select on cp_papel to sigagc;
	grant select on cp_personalizacao to sigagc;
	grant select on cp_servico to sigagc;
	grant select on cp_tipo_configuracao to sigagc;
	grant select on cp_tipo_grupo to sigagc;
	grant select on cp_tipo_identidade to sigagc;
	grant select on cp_tipo_lotacao to sigagc;
	grant select on cp_tipo_papel to sigagc;
	grant select on cp_tipo_pessoa to sigagc;
	grant select on cp_uf to sigagc;
	grant select on dp_substituicao to sigagc;
	grant select on cp_modelo_seq to sigagc;
	grant select on CP_IDENTIDADE_SEQ to sigagc;
	grant select, references on cp_orgao_usuario to sigagc;
	grant select on cp_tipo_servico to sigagc;
	
	grant select, update, delete, insert on cp_marca to sigagc;
	grant select, update, insert, references on CP_CONFIGURACAO to sigagc;
	
	grant select on CP_CONFIGURACAO_SEQ to sigagc;
	grant select on CP_MARCA_SEQ to sigagc;
  
  
  
  -- - - - - - - - - - - - - - - - - - - - - - 
-- - - Marcadores- - - - - - - - - - - - - -
-- - - - - - - - - - - - - - - - - - - - - - 
	
	insert into cp_marcador (id_marcador, descr_marcador, id_tp_marcador) values (36, 'Ativo',	1);
	insert into cp_marcador (id_marcador, descr_marcador, id_tp_marcador) values (37,	'Novo',	1);
	insert into cp_marcador (id_marcador, descr_marcador, id_tp_marcador) values (38,	'Popular',	1);
	insert into cp_marcador (id_marcador, descr_marcador, id_tp_marcador) values (39,	'Revisar',	1);
	insert into cp_marcador (id_marcador, descr_marcador, id_tp_marcador) values (40,	'Tomst Ci�ncia',	1);
	
  
	insert into cp_tipo_marca(id_tp_marca, descr_tp_marca) values (3, 'SIGA-GC');
  
-- - - - - - - - - - - - - - - - - - - - - - 
-- - - Serviços- - - - - - - - - - - - - - -
-- - - - - - - - - - - - - - - - - - - - - - 

	insert into corporativo.cp_configuracao (
		id_configuracao, his_id_ini, id_tp_configuracao, id_sit_configuracao, id_servico, 
		dt_ini_vig_configuracao, id_lotacao
	) values(
		corporativo.cp_configuracao_seq.nextval, 
		corporativo.cp_configuracao_seq.currval,
		200, 
		1, 
		(select id_servico from corporativo.cp_servico where sigla_servico='SIGA-GC'),
		sysdate, 
		(select id_lotacao from corporativo.dp_lotacao where sigla_lotacao = 'SESIA' and data_fim_lot is null and id_orgao_usu = 1)
	);
  commit;
	



ALTER SESSION SET CURRENT_SCHEMA = sigagc;

create sequence hibernate_sequence;

CREATE TABLE SIGAGC.GC_TIPO_TAG 
(
  ID_TIPO_TAG NUMBER(19, 0) NOT NULL 
, NOME_TIPO_TAG VARCHAR2(255 CHAR) NOT NULL 
, CONSTRAINT SYS_C00172409 PRIMARY KEY 
  (
    ID_TIPO_TAG 
  )
  ENABLE 
); 

CREATE TABLE SIGAGC.GC_TIPO_MOVIMENTACAO 
(
  ID_TIPO_MOVIMENTACAO NUMBER(19, 0) NOT NULL 
, NOME_TIPO_MOVIMENTACAO VARCHAR2(255 CHAR) NOT NULL 
, CONSTRAINT SYS_C00172408 PRIMARY KEY 
  (
    ID_TIPO_MOVIMENTACAO 
  )
  ENABLE 
); 

CREATE TABLE SIGAGC.GC_TIPO_INFORMACAO 
(
  ID_TIPO_INFORMACAO NUMBER(19, 0) NOT NULL 
, NOME_TIPO_INFORMACAO VARCHAR2(255 CHAR) NOT NULL  
, CONSTRAINT SYS_C00172407 PRIMARY KEY 
  (
    ID_TIPO_INFORMACAO 
  )
  ENABLE 
); 


CREATE TABLE SIGAGC.GC_ARQUIVO 
(
  ID_CONTEUDO NUMBER(19, 0) NOT NULL 
, CLASSIFICACAO VARCHAR2(255 CHAR) 
, CONTEUDO BLOB 
, CONTEUDO_TIPO VARCHAR2(255 CHAR) 
, TITULO VARCHAR2(255 CHAR) 
, CONSTRAINT SYS_C00172401 PRIMARY KEY 
  (
    ID_CONTEUDO 
  )
  ENABLE 
); 

CREATE TABLE SIGAGC.GC_ACESSO 
(
  ID_ACESSO NUMBER(19, 0) NOT NULL 
, NOME_ACESSO VARCHAR2(255 CHAR) NOT NULL 
, CONSTRAINT SYS_C00172400 PRIMARY KEY 
  (
    ID_ACESSO 
  )
  ENABLE 
); 


CREATE TABLE SIGAGC.GC_CONFIGURACAO 
(
  ID_CONFIGURACAO_GC NUMBER(19, 0) NOT NULL 
, ID_TIPO_INFORMACAO NUMBER(19, 0) 
, CONSTRAINT SYS_C00172402 PRIMARY KEY 
  (
    ID_CONFIGURACAO_GC 
  )
  ENABLE 
); 

ALTER TABLE SIGAGC.GC_CONFIGURACAO
ADD CONSTRAINT FK5B6C283297A881AD FOREIGN KEY
(
  ID_TIPO_INFORMACAO 
)
REFERENCES SIGAGC.GC_TIPO_INFORMACAO
(
  ID_TIPO_INFORMACAO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_CONFIGURACAO
ADD CONSTRAINT FK5B6C2832F6A487C3 FOREIGN KEY
(
  ID_CONFIGURACAO_GC 
)
REFERENCES CORPORATIVO.CP_CONFIGURACAO
(
  ID_CONFIGURACAO 
)
ENABLE;

CREATE TABLE SIGAGC.GC_INFORMACAO 
(
  ID_INFORMACAO NUMBER(19, 0) NOT NULL 
, ANO NUMBER(10, 0) 
, DT_ELABORACAO_FIM TIMESTAMP(6) 
, HIS_DT_FIM TIMESTAMP(6) 
, HIS_DT_INI TIMESTAMP(6) 
, NUMERO NUMBER(10, 0) 
, ID_ARQUIVO NUMBER(19, 0) NOT NULL 
, ID_PESSOA_TITULAR NUMBER(19, 0) NOT NULL 
, ID_ACESSO_EDICAO NUMBER(19, 0) NOT NULL 
, HIS_IDC_INI NUMBER(19, 0) NOT NULL 
, ID_INFORMACAO_PAI NUMBER(19, 0) 
, ID_LOTACAO_TITULAR NUMBER(19, 0) NOT NULL 
, ID_ORGAO_USUARIO NUMBER(19, 0) NOT NULL 
, ID_TIPO_INFORMACAO NUMBER(19, 0) NOT NULL 
, ID_ACESSO NUMBER(19, 0) NOT NULL 
, CONSTRAINT SYS_C00172403 PRIMARY KEY 
  (
    ID_INFORMACAO 
  )
  ENABLE 
); 

ALTER TABLE SIGAGC.GC_INFORMACAO
ADD CONSTRAINT FK8B6611FC14A981C FOREIGN KEY
(
  ID_ACESSO 
)
REFERENCES SIGAGC.GC_ACESSO
(
  ID_ACESSO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_INFORMACAO
ADD CONSTRAINT FK8B6611FC4A634B1A FOREIGN KEY
(
  ID_LOTACAO_TITULAR 
)
REFERENCES CORPORATIVO.DP_LOTACAO
(
  ID_LOTACAO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_INFORMACAO
ADD CONSTRAINT FK8B6611FC5C8D8B16 FOREIGN KEY
(
  ID_ARQUIVO 
)
REFERENCES SIGAGC.GC_ARQUIVO
(
  ID_CONTEUDO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_INFORMACAO
ADD CONSTRAINT FK8B6611FC8DEEFE82 FOREIGN KEY
(
  ID_ACESSO_EDICAO 
)
REFERENCES SIGAGC.GC_ACESSO
(
  ID_ACESSO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_INFORMACAO
ADD CONSTRAINT FK8B6611FC9139CD43 FOREIGN KEY
(
  ID_INFORMACAO_PAI 
)
REFERENCES SIGAGC.GC_ARQUIVO
(
  ID_CONTEUDO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_INFORMACAO
ADD CONSTRAINT FK8B6611FC97A881AD FOREIGN KEY
(
  ID_TIPO_INFORMACAO 
)
REFERENCES SIGAGC.GC_TIPO_INFORMACAO
(
  ID_TIPO_INFORMACAO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_INFORMACAO
ADD CONSTRAINT FK8B6611FCC8778546 FOREIGN KEY
(
  ID_PESSOA_TITULAR 
)
REFERENCES CORPORATIVO.DP_PESSOA
(
  ID_PESSOA 
)
ENABLE;

ALTER TABLE SIGAGC.GC_INFORMACAO
ADD CONSTRAINT FK8B6611FCE2B26866 FOREIGN KEY
(
  ID_ORGAO_USUARIO 
)
REFERENCES CORPORATIVO.CP_ORGAO_USUARIO
(
  ID_ORGAO_USU 
)
ENABLE;

ALTER TABLE SIGAGC.GC_INFORMACAO
ADD CONSTRAINT FK8B6611FCFC20D6A3 FOREIGN KEY
(
  HIS_IDC_INI 
)
REFERENCES CORPORATIVO.CP_IDENTIDADE
(
  ID_IDENTIDADE 
)
ENABLE;


CREATE TABLE SIGAGC.GC_MOVIMENTACAO 
(
  ID_MOVIMENTACAO NUMBER(19, 0) NOT NULL 
, HIS_DT_INI TIMESTAMP(6) 
, ID_CONTEUDO NUMBER(19, 0) 
, HIS_IDC_INI NUMBER(19, 0) NOT NULL 
, ID_INFORMACAO NUMBER(19, 0) NOT NULL 
, ID_LOTACAO_ATENDENTE NUMBER(19, 0) 
, ID_LOTACAO_TITULAR NUMBER(19, 0) 
, ID_MOVIMENTACAO_CANCELADORA NUMBER(19, 0) 
, ID_MOVIMENTACAO_REF NUMBER(19, 0) 
, ID_PESSOA_ATENDENTE NUMBER(19, 0) 
, ID_PESSOA_TITULAR NUMBER(19, 0) 
, ID_TIPO_MOVIMENTACAO NUMBER(19, 0) NOT NULL 
, CONSTRAINT SYS_C00172404 PRIMARY KEY 
  (
    ID_MOVIMENTACAO 
  )
  ENABLE 
);

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT FK3157F3861DEBB381 FOREIGN KEY
(
  ID_TIPO_MOVIMENTACAO 
)
REFERENCES SIGAGC.GC_TIPO_MOVIMENTACAO
(
  ID_TIPO_MOVIMENTACAO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT FK3157F3864101359E FOREIGN KEY
(
  ID_CONTEUDO 
)
REFERENCES SIGAGC.GC_ARQUIVO
(
  ID_CONTEUDO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT FK3157F3864A634B1A FOREIGN KEY
(
  ID_LOTACAO_TITULAR 
)
REFERENCES CORPORATIVO.DP_LOTACAO
(
  ID_LOTACAO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT FK3157F3869B156615 FOREIGN KEY
(
  ID_LOTACAO_ATENDENTE 
)
REFERENCES CORPORATIVO.DP_LOTACAO
(
  ID_LOTACAO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT FK3157F386A3658F2C FOREIGN KEY
(
  ID_MOVIMENTACAO_CANCELADORA 
)
REFERENCES SIGAGC.GC_MOVIMENTACAO
(
  ID_MOVIMENTACAO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT FK3157F386BC9A64C1 FOREIGN KEY
(
  ID_PESSOA_ATENDENTE 
)
REFERENCES CORPORATIVO.DP_PESSOA
(
  ID_PESSOA 
)
ENABLE;

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT FK3157F386C8778546 FOREIGN KEY
(
  ID_PESSOA_TITULAR 
)
REFERENCES CORPORATIVO.DP_PESSOA
(
  ID_PESSOA 
)
ENABLE;

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT FK3157F386D38B6636 FOREIGN KEY
(
  ID_INFORMACAO 
)
REFERENCES SIGAGC.GC_INFORMACAO
(
  ID_INFORMACAO 
)
ENABLE;

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT FK3157F386FC20D6A3 FOREIGN KEY
(
  HIS_IDC_INI 
)
REFERENCES CORPORATIVO.CP_IDENTIDADE
(
  ID_IDENTIDADE 
)
ENABLE;

ALTER TABLE SIGAGC.GC_MOVIMENTACAO
ADD CONSTRAINT ID_MOVIMENTACAO_FK FOREIGN KEY
(
  ID_MOVIMENTACAO_REF 
)
REFERENCES SIGAGC.GC_MOVIMENTACAO
(
  ID_MOVIMENTACAO 
)
ON DELETE SET NULL ENABLE;


CREATE TABLE SIGAGC.GC_TAG 
(
  ID_TAG NUMBER(19, 0) NOT NULL 
, CATEGORIA VARCHAR2(10 CHAR) 
, TITULO VARCHAR2(256 CHAR) 
, TIPO_ID_TIPO_TAG NUMBER(19, 0) NOT NULL 
, CONSTRAINT SYS_C00172405 PRIMARY KEY 
  (
    ID_TAG 
  )
  ENABLE 
);

ALTER TABLE SIGAGC.GC_TAG
ADD CONSTRAINT FK7D04AD97F23572CE FOREIGN KEY
(
  TIPO_ID_TIPO_TAG 
)
REFERENCES SIGAGC.GC_TIPO_TAG
(
  ID_TIPO_TAG 
)
ENABLE;

CREATE TABLE SIGAGC.GC_TAG_X_INFORMACAO 
(
  ID_INFORMACAO NUMBER(19, 0) NOT NULL 
, ID_TAG NUMBER(19, 0) NOT NULL 
, CONSTRAINT SYS_C00172406 PRIMARY KEY 
  (
    ID_INFORMACAO 
  , ID_TAG 
  )
  ENABLE 
); 

ALTER TABLE SIGAGC.GC_TAG_X_INFORMACAO
ADD CONSTRAINT FK6DCF9EA8635922F0 FOREIGN KEY
(
  ID_TAG 
)
REFERENCES SIGAGC.GC_TAG
(
  ID_TAG 
)
ENABLE;

ALTER TABLE SIGAGC.GC_TAG_X_INFORMACAO
ADD CONSTRAINT FK6DCF9EA8D38B6636 FOREIGN KEY
(
  ID_INFORMACAO 
)
REFERENCES SIGAGC.GC_INFORMACAO
(
  ID_INFORMACAO 
)
ENABLE;