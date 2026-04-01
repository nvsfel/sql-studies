-- inicio de clientes --

create type tipo_genero as enum ('MM', 'FF', 'NB');

create table cliente(
id serial primary key,
nome varchar(500),
cnh varchar(500),
email varchar(500),
genero tipo_genero
);

--inserção de clientes--

insert into cliente (nome,cnh,email,genero)
values
('ANA CAROLINA SOUZA', '12345678901', 'ana.souza@sql', 'FF'),
('BRUNO MENDES', '09876543210', 'bruno.mendes@sql', 'MM'),
('CAMILA SANTOS', '11223344556', 'camila.s@sql', 'FF'),
('DANIEL OLIVEIRA', '66554433221', 'daniel.oli@sql', 'MM'),
('ELISA FERREIRA', '77889900112', 'elisa.f@sql', 'FF'),
('FELIPE ROCHA', '22113344556', 'felipe.r@sql', 'MM'),
('GIOVANNA LIMA', '88776655443', 'giovanna.l@sql', 'FF'),
('HENRIQUE COSTA', '33445566778', 'henrique.c@sql', 'MM'),
('ISADORA GOMES', '99001122334', 'isadora.g@sql', 'FF'),
('JOÃO VITOR ALMEIDA', '44556677889', 'joao.vitor@sql', 'MM'),
('KAI SILVEIRA', '55667788990', 'kai.silveira@sql', 'NB'),
('LARISSA BARBOSA', '10293847560', 'larissa.b@sql', 'FF'),
('MATHEUS RIBEIRO', '05948372610', 'matheus.r@sql', 'MM'),
('NICOLE DIAS', '67584930211', 'nicole.dias@sql', 'FF'),
('OSVALDO PIRES', '29384756102', 'osvaldo.p@sql', 'MM'),
('PAULA MARTINS', '31425364758', 'paula.m@sql', 'FF'),
('QUITERIA NEVES', '80971625344', 'quiteria.n@sql', 'FF'),
('RAFAEL SOARES', '40596871325', 'rafael.s@sql', 'MM'),
('SAMARA CRUZ', '52637485960', 'samara.cruz@sql', 'NB'),
('THIAGO VIANA', '91082736451', 'thiago.v@sql', 'MM'),
('URSULA MONTE', '04857619203', 'ursula.m@sql', 'FF'),
('VICTOR NOGUEIRA', '73625184904', 'victor.n@sql', 'MM'),
('YASMIN PEREIRA', '61728394055', 'yasmin.p@sql', 'FF'),
('ZION SANTOS', '82930415266', 'zion.santos@sql', 'NB');

-- fim de clientes --
-- inicio de veiculos --

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
placa varchar (500) NOT NULL,
combustivel tipo_combustivel NOT NULL
);

--inserções de veículos--

insert into veiculo (tipo, marca, modelo, ano, cor, placa, combustivel)
values
('carro','volksvagen','gol','2018','prata','abc1234','flex'),
('carro','chevrolet','onix','2021','vermelho','def5678','gasolina'),
('carro','fiat','strada','2022','branco','ghi9012','flex'),
('carro','ford','ka','2017','preto','jkl3456','gas'),
('carro','hyundai','hb20','2020','azul','mno7890','flex'),
('carro','renault','kwid','2023','cinza','pqr1357','gasolina');
('moto','honda','cg 160 fan','2021', 'vermelha','xyz9876','gasolina'),
('moto','yamaha','fz25 fazer','2020','azul','wut5432','flex'),
('moto','kawazaki','ninja 400','2023','verde','srq1098','gasolina'),
('moto','suzuki','intruder 125','2015','preta','opz7654','gas'),
('moto','royal enfield','meteor 350','2022','cinza','lkm3210','gasolina'),
('moto','honda','pop 110i','2019','branca','jih8765','flex');

--fim de tratativas com veiculos

--RETRATAR A ENTIDADE ASSOCIATIVA 'ALUGA', FISICAMENTE TIDA COMO cliente_veiculo
--Essa tabela retrata as 'ocorrências' de alugueis de cada cliente.

create table cliente_veiculo(
cliente_id integer,
veiculo_id integer,
data_retirada date,
data_devolucao date,
foreign key (cliente_id) references cliente(id),
foreign key (veiculo_id) references veiculo(id)
);

insert into cliente_veiculo(cliente_id, veiculo_id, data_retirada, data_devolucao)
values
(1, 1, '2024-01-05', '2024-01-10'),
(2, 7, '2024-02-15', '2024-02-18'),
(3, 4, '2024-03-20', '2024-03-27'),
(4, 8, '2024-04-01', '2024-04-05'),
(5, 2, '2024-05-10', '2024-05-15'),
(6, 9, '2024-06-01', '2024-06-03'),
(7, 3, '2024-07-18', '2024-07-25'),
(7, 10, '2024-08-10', '2024-08-12'),
(8, 10, '2024-08-22', '2024-08-23'),
(9, 5, '2024-09-09', '2024-09-15'),
(8, 4, '2024-09-15', '2024-09-17'),
(9, 7, '2024-10-15', '2024-10-20'),
(10, 11, '2024-10-25', '2024-10-30'),
(11, 6, '2024-11-12', '2024-11-14'),
(10, 6, '2024-11-20', '2024-11-22'),
(12, 12, '2024-12-01', '2024-12-07'),
(11, 1, '2024-12-05', '2024-12-10'),
(12, 2, '2024-12-20', '2024-12-24'),
(13, 1, '2025-01-08', '2025-01-15'),
(13, 11, '2025-02-05', '2025-02-10'),
(14, 2, '2025-02-28', '2025-03-05'),
(13, 3, '2025-03-05', '2025-03-15'),
(15, 3, '2025-03-10', '2025-03-12'),
(14, 12, '2025-03-15', '2025-03-18'),
(15, 8, '2025-04-05', '2025-04-10'),
(14, 5, '2025-04-10', '2025-04-20'),
(16, 4, '2025-04-16', '2025-04-22'),
(15, 9, '2025-05-01', '2025-05-05'),
(17, 7, '2025-05-05', '2025-05-09'),
(18, 8, '2025-06-19', '2025-06-21'),
(19, 5, '2025-07-01', '2025-07-10'),
(20, 11, '2025-08-14', '2025-08-20'),
(21, 6, '2025-09-25', '2025-09-30'),
(22, 12, '2025-10-01', '2025-10-01'),
(23, 3, '2025-11-10', '2025-11-17'),
(24, 9, '2025-12-01', '2025-12-10');

