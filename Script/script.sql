/*
Created		13/03/2016
Modified		02/04/2016
Project		
Model		
Company		
Author		
Version		
Database		Firebird 
*/


Create Table USUARIO  (
	ID_USUARIO Integer NOT NULL,
	NOME_LOGIN Varchar(30) NOT NULL,
	SENHA_LOGIN Varchar(30) NOT NULL,
	CONFIRMA_SENHA Varchar(30) NOT NULL,
	ACESSO Varchar(30) NOT NULL,
	SITUACAO Char(1) NOT NULL
);
Alter Table USUARIO add Constraint pk_USUARIO Primary Key (ID_USUARIO);

Create Table CLIENTE  (
	ID_CLIENTE Integer NOT NULL,
	ID_CIDADE Integer NOT NULL,
	NOME_CLI Varchar(30) NOT NULL,
	ENDERE_O_CLI Varchar(30),
	FONE_CLI Varchar(30) NOT NULL,
	CPF_CLI Varchar(14),
	DATA_NASC Date,
	DS_BAIRRO Varchar(80)
);
Alter Table CLIENTE add Constraint pk_CLIENTE Primary Key (ID_CLIENTE);

Create Table CIDADE  (
	ID_CIDADE Integer NOT NULL,
	NOME_CID Varchar(50) NOT NULL,
	UF_CID Char(2) NOT NULL
);
Alter Table CIDADE add Constraint pk_CIDADE Primary Key (ID_CIDADE);

Create Table PRODUTO  (
	ID_PRODUTO Integer NOT NULL,
	ID_GRUPO_PRO Integer NOT NULL,
	NOME_PRO Varchar(50) NOT NULL,
	DESCRICAO_PRO Varchar(60),
	QT_ESTOQUE Numeric(15,2),
	VL_CUSTO Numeric(15,2),
	VL_VENDA Numeric(15,2)
);
Alter Table PRODUTO add Constraint pk_PRODUTO Primary Key (ID_PRODUTO);

Create Table GRUPO_PRODUTO  (
	ID_GRUPO_PRO Integer NOT NULL,
	NOME_GRUPO Varchar(50) NOT NULL
);
Alter Table GRUPO_PRODUTO add Constraint pk_GRUPO_PRODUTO Primary Key (ID_GRUPO_PRO);

Create Table FORNECEDOR  (
	ID_FORNECEDOR Integer NOT NULL,
	ID_CIDADE Integer NOT NULL,
	NOME_FOR Varchar(50) NOT NULL,
	CNPJ_FOR Varchar(18),
	ENDERECO_FOR Varchar(50) NOT NULL,
	FONE_FOR Varchar(30)
);
Alter Table FORNECEDOR add Constraint pk_FORNECEDOR Primary Key (ID_FORNECEDOR);

Create Table VENDA  (
	ID_VENDA Integer NOT NULL,
	ID_CONDPGTO Integer NOT NULL,
	ID_CLIENTE Integer NOT NULL,
	VL_TOTAL Numeric(15,2),
	DATA_VENDA Date NOT NULL,
	VL_SUBTOTAL Numeric(15,2),
	VL_DESCONTO Numeric(15,2),
	TP_SITUCAO Char(1) NOT NULL,
	VL_RECEBIDO Numeric(15,2),
	VL_TROCO Numeric(15,2)
);
Alter Table VENDA add Constraint pk_VENDA Primary Key (ID_VENDA);

Create Table COND_PGTO  (
	ID_CONDPGTO Integer NOT NULL,
	QTD_PARCELA Varchar(30),
	DESCRICAO_COND Varchar(50)
);
Alter Table COND_PGTO add Constraint pk_COND_PGTO Primary Key (ID_CONDPGTO);

Create Table COMPRA  (
	ID_COMPRA Integer NOT NULL,
	ID_FORNECEDOR Integer NOT NULL,
	DATA_COMPRA Date NOT NULL,
	VLT_COMPRA Numeric(15,2) NOT NULL
);
Alter Table COMPRA add Constraint pk_COMPRA Primary Key (ID_COMPRA);

Create Table VENDA_ITENS  (
	ID_VENDAITENS Integer NOT NULL,
	ID_VENDA Integer NOT NULL,
	ID_PRODUTO Integer NOT NULL,
	VL_UNITARIO Numeric(15,2) NOT NULL,
	QT_ITEM Numeric(15,2) NOT NULL,
	VLI_TOTAL Numeric(15,2) NOT NULL
);
Alter Table VENDA_ITENS add Constraint pk_VENDA_ITENS Primary Key (ID_VENDAITENS);

Create Table COMPRA_ITEM  (
	ID_ITEMCOMPRA Integer NOT NULL,
	ID_COMPRA Integer NOT NULL,
	ID_PRODUTO Integer NOT NULL,
	VL_UNITARIO Numeric(15,2),
	QT_ITEM Numeric(15,2),
	VL_TOTAL Numeric(15,2)
);
Alter Table COMPRA_ITEM add Constraint pk_COMPRA_ITEM Primary Key (ID_ITEMCOMPRA);

Create Table CONTAS_PAGAR  (
	ID_CONTASPAGAR Integer NOT NULL,
	ID_COMPRA Integer NOT NULL,
	ID_FORNECEDOR Integer NOT NULL,
	SITUACAO_PAGAR Varchar(4),
	DT_EMISSAOP Date,
	PARCELAS_PAGAR Numeric(10,2),
	DT_VENCP Date,
	DT_PAGP Date,
	VL_PAGOP Numeric(10,2)
);
Alter Table CONTAS_PAGAR add Constraint pk_CONTAS_PAGAR Primary Key (ID_CONTASPAGAR);

Create Table CONTAS_RECEBER  (
	ID_CONTASRECEBER Integer NOT NULL,
	ID_VENDA Integer NOT NULL,
	ID_CLIENTE Integer NOT NULL,
	DT_EMISSAOR Date,
	PARCELA_RECEBER Numeric(10,2),
	DT_VENCR Date,
	VL_PAGOR Numeric(10,2),
	DT_PAGR Date,
	SITUCAO_RECEBER Varchar(4)
);
Alter Table CONTAS_RECEBER add Constraint pk_CONTAS_RECEBER Primary Key (ID_CONTASRECEBER);


Alter Table VENDA add Constraint FKCLIENTE_VENDA Foreign Key (ID_CLIENTE) references CLIENTE (ID_CLIENTE) on update no action on delete no action ;
Alter Table CONTAS_RECEBER add Constraint FKCLIENTE_CONTAS Foreign Key (ID_CLIENTE) references CLIENTE (ID_CLIENTE) on update no action on delete no action ;
Alter Table CLIENTE add Constraint FKCIDADE_CLIENTE Foreign Key (ID_CIDADE) references CIDADE (ID_CIDADE) on update no action on delete no action ;
Alter Table FORNECEDOR add Constraint FKCIDADE_FORNECEDOR Foreign Key (ID_CIDADE) references CIDADE (ID_CIDADE) on update no action on delete no action ;
Alter Table VENDA_ITENS add Constraint FKPRODUTOITEN Foreign Key (ID_PRODUTO) references PRODUTO (ID_PRODUTO) on update no action on delete no action ;
Alter Table COMPRA_ITEM add Constraint FKPRODUTO_COMPRAITEM Foreign Key (ID_PRODUTO) references PRODUTO (ID_PRODUTO) on update no action on delete no action ;
Alter Table PRODUTO add Constraint FKGRUPO_GRUPRO Foreign Key (ID_GRUPO_PRO) references GRUPO_PRODUTO (ID_GRUPO_PRO) on update no action on delete no action ;
Alter Table COMPRA add Constraint FKFORNECEDOR_VENDA Foreign Key (ID_FORNECEDOR) references FORNECEDOR (ID_FORNECEDOR) on update no action on delete no action ;
Alter Table CONTAS_PAGAR add Constraint FKFORNECEDOR_CONTAS Foreign Key (ID_FORNECEDOR) references FORNECEDOR (ID_FORNECEDOR) on update no action on delete no action ;
Alter Table VENDA_ITENS add Constraint FKVENDA_VENDAITENS Foreign Key (ID_VENDA) references VENDA (ID_VENDA) on update no action on delete no action ;
Alter Table CONTAS_RECEBER add Constraint FKVENDA_CONTAS Foreign Key (ID_VENDA) references VENDA (ID_VENDA) on update no action on delete no action ;
Alter Table VENDA add Constraint FKCONDPGTO_VENDA Foreign Key (ID_CONDPGTO) references COND_PGTO (ID_CONDPGTO) on update no action on delete no action ;
Alter Table COMPRA_ITEM add Constraint FKCOMPRA_CITEM Foreign Key (ID_COMPRA) references COMPRA (ID_COMPRA) on update no action on delete no action ;
Alter Table CONTAS_PAGAR add Constraint FKCOMPRA_CONTAS Foreign Key (ID_COMPRA) references COMPRA (ID_COMPRA) on update no action on delete no action ;


Create Exception except_del_p 'Children still exist in child table. Cannot delete parent.';
Create Exception except_ins_ch 'Parent does not exist. Cannot create child.';
Create Exception except_upd_ch 'Parent does not exist. Cannot update child.';
Create Exception except_upd_p 'Children still exist in child table. Cannot update parent.';
Create Exception except_ins_ch_card 'Maximum cardinality exceeded. Cannot insert into child.';
Create Exception except_upd_ch_card 'Maximum cardinality exceeded. Cannot update child.';


set term ^;


set term ;^


/* Roles permissions */


/* Users permissions */


