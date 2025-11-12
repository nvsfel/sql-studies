create table cliente(
id serial primary key,
nome varchar(500),
cnh varchar(500),
email varchar(500),
sexo char(2)
);

/*regra de negócio: a locadora trabalha com carros e motos,
os quais podem aceitar gasolina, gas ou flex como combustível.*/
create type tipo_veiculo as enum ('carro', 'moto');
create type tipo_combustivel as enum ('gasolina','gas', 'flex');
--pré criação com regras concluídas, vamos à tabela:

create table veiculo(
id serial primary key,
tipo tipo_veiculo NOT NULL, /*tipo_veiculo agora é uma tipagem,
assim como varchar ou integer. equivalente aos objetos em python ou struct em c.*/
marca varchar(500),
modelo varchar (500),
ano smallint,
cor varchar(500),
placa varchar (500), NOT NULL
combustivel tipo_combustivel NOT NULL
);

