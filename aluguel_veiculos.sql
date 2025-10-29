create table cliente(
id serial primary key,
nome varchar (500),
cnh varchar (500),
email varchar (500)
--sexo char(2)--
);

--adição da coluna SEXO--
alter table cliente
add column sexo char(2)

insert into cliente(nome,cnh,email) 
values
('Kleber','01234567890','kleber@sql.com'),
('Julia','93216549879','juju@sql.com'),
('Marianne','31472583691','anne@sql.com'),
('Darien','78965425819','darien@sql.com'),
('Johan','0619487849','johan@sql.com'),
('Raziel','43768912437','raziel@sql.com');
--inserções posteriores:
insert into cliente(nome,cnh,email)
values
('Giovanni','05759982879','gigi@sql.com'),
('Andrea','09774187869','andrea@sql.com'),
('Dominic','91594873692','dommi@sql.com'),
('Santclair','37581952627','sant@sql.com'); 
--testes de consulta
--tabela inteira ordenada pelo nome (crescente)
select * from cliente
order by nome 
--tabela inteira ordenada pelo nome(decrescente)
select * from cliente
order by nome desc

--corrigindo cnh de Johan, ID 5:

update cliente
set cnh='06194878494'
where id=5;

update cliente
set sexo = 'FF'
where id in (2,3,4,8);

update cliente
set sexo = 'MM'
where id in (1,6,7,10);

update cliente
set sexo = 'NB'
where id in (5,9);

commit
select * from cliente
-------------FIM DE CLIENTES-------------------

create table carro(
id serial primary key,
marca varchar (500),
modelo varchar (500),
ano smallint
);
begin;
commit;
rollback;
--adicionando 3 colunas posteriormente:
alter table carro
add column cor varchar (500),
add column placa varchar (500),
add column combustivel varchar (500);
insert into carro(marca, modelo, ano, cor, placa, combustivel)
values
('Honda','Civic','2023','preto','xyz5f89','etanol'),
('Chevrolet','Onix','2022','preto','abx8z96','gasolina'),
('Volkswagen','T-Cross','2024','preto','fde9z92','flex'),
('Toyota','Corolla','2025','preto','lux7d10','flex'),
('Hyundai','HB20','2025','preto','div0c74','flex'),
('Ford','Ranger','2025','preto','tec8d66','flex');
--trocar combustivel do Civic e do Onix para flex:
update carro
set combustivel='flex'
where id in (1, 2);
--comando IN permite que eu mexa em duas linhas (ou mais) ao mesmo tempo!
 
--consultar carros mostrando modelo, mas na ordem alfabética das MARCAS
select modelo
from carro
order by marca


----------FIM DE CARRO----------

select * from cliente_carro

--tabela cliente_carro mostra as relações de aluguel entre
--clientes e carros, com suas respectivas datas.

create table cliente_carro(
cliente_id integer,
carro_id integer,
data_retirada date,
data_devolucao date,
foreign key (cliente_id) references cliente(id),
foreign key (carro_id) references carro(id)
);


--na prática, essas inserções seriam equivalentes ao registro de aluguéis
insert into cliente_carro(cliente_id, carro_id, data_retirada, data_devolucao)
values
(4,1,'2025-10-23','2025-10-30'),
(1,4,'2025-10-22','2025-10-29'),
(3,3,'2025-10-14','2025-10-21'),
(2,6,'2025-10-15','2025-10-22'),
(5,2,'2025-10-31','2025-11-06'),
(6,5,'2025-11-01','2025-11-08');

--Para consuletar a tabela cliente_carro, mas com os nomes dos clientes e
--modelos dos carros, precisa-se fazer um JOIN:

--select
	--tabela.coluna (coluna desejada)
	--tabela.coluna (coluna desejada)
--from
	--tabela (que recebe as ligações)

--join
 	--tabela (que cede a info)
--on
	--tabela(que recebe).chave_estrangeira = tabela(que cede).chave_primaria
select
	--colunas e seus apelidos
	cliente_carro.cliente_id as registro_cliente,
	cliente.nome as nome_cliente,
	carro.modelo as modelo_veiculo,
	cliente_carro.data_retirada as data_inicial,
	cliente_carro.data_devolucao as data_final
from
	--coluna que receberá as informações
	cliente_carro
join
	--coluna que cede informações
	cliente
on
	--tabela.chave_estrangeira = tabela.chave_primaria
	cliente_carro.cliente_id = cliente.id
join
	carro
on
	cliente_carro.carro_id = carro.id
--filtragem para saber quais alugueis ainda estão em voga
where
	data_devolucao > current_date;

--uso de join:
--relacionar cliente, veículo alugado e data de retirada e devolucao:

select
--tabela.coluna as apelido
cliente.nome as nome_cliente,
carro.modelo as modelo_veiculo,
cliente_carro.data_retirada as data_retirada,
cliente_carro.data_devolucao as data_devolucao

from cliente_carro

join cliente on cliente_carro.cliente_id = cliente.id
join carro on cliente_carro.carro_id = carro.id


----------FIM DE CLIENTE_CARRO----------

select * from moto
order by id

create table moto(
id serial primary key,
marca varchar(500),
modelo varchar(500),
ano smallint,
cor varchar (500),
placa varchar (500),
combustivel varchar (500)
);

insert into moto(marca,modelo,ano,cor,placa,combustivel)
values
('Honda','CG160','2024','Preta','cgz7750','flex'), --cor editada para 'preto'
('Honda','CG160','2024','Azul','cgy1160','flex'),  --cor editada para 'azul'
('Yamaha','Fazer150','2024','Preta','fzr9985','flex'),  --cor editada para 'preto'
('Yamaha','Fazer150','2024','Vermelha','ffz1500','flex');  --cor editada para 'vermelho'

update moto
set cor='azul'
where id=2;

update moto
set cor='preto'
where id in (1,3);

update moto
set cor='vermelho'
where id=4;

begin;
commit;
select marca, modelo, placa from moto
order by combustivel, id asc
--quando o conteudo escolhido para ordenar é igual para todos, ('flex'),
--o ideal é definir um segundo critério, ou o pgadmin organizará aleatoriamente.
----------FIM DE MOTO ----------

create table cliente_moto(
cliente_id integer,
moto_id integer,
data_retirada date,
data_devolucao date,
foreign key (cliente_id) references cliente(id),
foreign key (moto_id) references moto(id)
);

insert into cliente_moto (cliente_id,moto_id,data_retirada,data_devolucao)
values
(8,1,'2025-06-17','2025-06-24'),
(9,3,'2025-06-10','2025-06-16'),
(7,2,'2025-05-30','2025-06-03'),
(10,4,'2025-05-25','2025-06-25'),
--cliente id 3 e 4 inseridos posteriormente
(3,3,'2025-05-30','2025-06-06'),
(4,4,'2025-10-01','2025-11-01');


select * from cliente_moto

select
	--colunas e seus apelidos
	cliente_moto.cliente_id as registro_cliente,
	cliente.nome as nome_cliente,
	moto.modelo as modelo_moto
from
	cliente_moto
join
	cliente
on
	cliente_moto.cliente_id = cliente.id
join
	moto
on
	cliente_moto.moto_id = moto.id

--where
--	(data_devolucao - data_retirada) >= 30
--distingue quem ficou um mes ou mais com o aluguel em voga	
--order by qualquer coluna de uma das 3 tabelas envolvidas (combustivel, nome...)
--where
--	(data_devolucao - data_retirada) >= 7
--distingue quem ficou uma semana ou mais com o aluguel em voga

----------FIM CLIENTE_MOTO----------

--PARA RODAR UMA LISTA COM TODOS OS ALUGUÉIS DE CARROS E DE MOTOS, PRECISARIA DE UM UNION.

--JOIN: ASSOCIA COLUNAS (ASSOCIA VERTICALMENTE)
--UNION: ASSOCIA LINHAS (ASSOCIA HORIZONTALMENTE)

--------------------------------------------------------
--CLAUSULA UNION:
--relacionar cliente, veículo alugado e data de devolução;
--filtrar UNION;

select * from --declarar umm select all e 'blocar' toda a seleção union;
(
select
--tabela.coluna as apelido
cliente.nome as nome_cliente,
carro.modelo as modelo_veiculo,
cliente_carro.data_retirada as data_retirada,
cliente_carro.data_devolucao as data_devolucao,
cliente.sexo as sexo_cliente

from cliente_carro

join cliente on cliente_carro.cliente_id = cliente.id
join carro on cliente_carro.carro_id = carro.id

union --declarar cláusula entre ambas seleções

select
cliente.nome as nome_cliente,
moto.modelo as modelo_veiculo,
cliente_moto.data_retirada as data_retirada,
cliente_moto.data_devolucao as data_devolucao,
cliente.sexo as sexo_cliente

from cliente_moto

join cliente on cliente_moto.cliente_id = cliente.id
join moto on cliente_moto.moto_id = moto.id

) as lista_total --fechar e apelidar a seleção;

--referenciar a seleção: apelido_union.apelido_coluna_filtro
where
lista_total.sexo_cliente = 'FF'

/* para 2 filtros juntos: 
	or
	lista_total.sexo_cliente = 'NB'; 
	(lista_total.sexo_cliente = 'MM';)
*/

/*Combinação de filtros: Cláusula AND.
Filtro para saber quem ainda NÃO devolveu o veículo que alugou:
*/

and lista_total.data_devolucao > current_date --current_date do estudo: 2025-29-10



