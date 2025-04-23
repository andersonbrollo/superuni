
# alguns nomes foram mudados para singular ou plural em correção ao modelo logico para manter a coerencia

create database superuni;
use superuni;

create table tb_perfil(
id_perfil int not null primary key,
nome_perfil varchar(50),
ativo bit not null default 1
);

create table tb_permissoes(
id_permissao int not null auto_increment,
nome_permissao varchar(50),
descricao text,
primary key (id_permissao)
);

create table tb_perfilpermissao(
id_perfilpermissao int not null auto_increment,
fk_id_perfil int,
fk_id_permissao int,
primary key(id_perfilpermissao),
constraint foreign key (fk_id_perfil) references tb_perfil(id_perfil),
constraint foreign key (fk_id_permissao) references tb_permissoes(id_permissao)
);

create table tb_usuarios(
id_usuario int auto_increment not null primary key,
fk_id_perfil int,
nome varchar(100),
cpf varchar(20),
email varchar(255),
telefone varchar(12),
cargo varchar(50),
login varchar(50),
senha varchar(12),
ativo bit not null default 1,
constraint foreign key (fk_id_perfil) references tb_perfil(id_perfil)
);

create table tb_tipo_status(
id_status int not null auto_increment primary key,
nome_status varchar(45),
ativo bit not null default 1
);

create table tb_caixaturno(
id_caixaturno int not null auto_increment primary key,
fk_id_status int,
datahora_inicio datetime,
datahora_fim datetime,
saldo_inicial decimal(6,2),
saldo_final decimal(10,2),
numero_estacao smallint,
constraint foreign key (fk_id_status) references tb_tipo_status(id_status)
);




create table tb_autenticacao (
id_auth int  not null auto_increment primary key,
fk_id_caixaturno int,
fk_id_atendente int,
fk_id_gerente int,
fk_id_status int,
ip varchar(45),
operacao varchar(1) comment 'A = Abertura B = Fechamento',
datahora_tentativa datetime,
constraint foreign key (fk_id_caixaturno) references tb_caixaturno(id_caixaturno),
constraint foreign key (fk_id_atendente) references tb_usuarios(id_usuario),
constraint foreign key (fk_id_gerente) references tb_usuarios(id_usuario),
constraint foreign key (fk_id_status) references tb_tipo_status(id_status)
);

create table tb_clientes(
id_cliente int not null auto_increment primary key,
nome varchar(100),
email varchar(255),
rg varchar(20),
cpf varchar(20),
data_cadastro date
);

create table tb_telefones(
id_telefone int not null auto_increment primary key,
telefone varchar(20),
fk_id_cliente int,
constraint foreign key (fk_id_cliente) references tb_clientes(id_cliente)
);

create table tb_vendas(
id_venda int not null primary key auto_increment,
fk_id_caixaturno int,
fk_id_status int,
fk_id_cliente int,
datahora_inicio datetime,
datahora_fim datetime,
valor decimal(8,2),
constraint foreign key (fk_id_caixaturno) references tb_caixaturno(id_caixaturno),
constraint foreign key ( fk_id_status) references tb_tipo_status(id_status),
constraint foreign key (fk_id_cliente) references tb_clientes(id_cliente)
);

create table tb_formas_pagamento(
id_forma int not null auto_increment primary key,
nome_forma varchar(100),
ativo bit
);

create table tb_pagamentos(
id_pagamento int auto_increment not null primary key,
fk_id_venda int,
fk_id_forma int,
valor decimal (8,2),
constraint foreign key (fk_id_venda) references tb_vendas(id_venda),
constraint foreign key (fk_id_forma) references tb_formas_pagamento(id_forma)
); 

create table tb_cores(
id_cor int not null auto_increment primary key,
cor varchar(50)
);

create table tb_produtos_categorias(
id_categoria int not null auto_increment primary key,
nome_categoria varchar(50)
);

create table tb_produtos(
id_produto int not null auto_increment primary key,
fk_id_categoria int,
fk_id_cor int,
marca varchar(100),
lote int,
nome_produto varchar(100),
constraint foreign key(fk_id_categoria) references tb_produtos_categorias(id_categoria),
foreign key(fk_id_cor) references tb_cores(id_cor)
);

create table tb_itens_venda(
id_itemvenda int not null auto_increment primary key,
fk_id_venda int,
fk_id_produto int,
valor_unitario decimal(8,2),
quantidade tinyint,
valor_item decimal(8,2),
foreign key(fk_id_venda) references tb_vendas(id_venda),
foreign key(fk_id_produto) references tb_produtos(id_produto)
);

