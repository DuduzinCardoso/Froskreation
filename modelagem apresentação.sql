create database froskreation;
use froskreation;


create table tab_cliente(
	idCliente int primary key auto_increment,
    nomeCliente varchar(50),
    emailCliente varchar(50),
    senhaCliente varchar(30),
    cpf_cliente char(11),
    enderecoCliente varchar(60)
)auto_increment = 1;


create table tab_filial(
	idFilial int primary key auto_increment,
    nomeFilial varchar(50),
    emailFilial varchar(50),
    senhaFilial varchar(30),
    cnpj_filial char(14),
    enderecoFilial varchar(60),
    fk_cliente int,
    foreign key (fk_cliente) references tab_cliente(idCliente)
)auto_increment = 101;


create table tab_tanque(
	idTanque int primary key not null,
    nomeTanque varchar(30),
    fk_filial int not null,
    foreign key (fk_filial) references tab_filial(idFilial)
);


create table tab_temperatura(
	idAlerta int primary key not null,
    dataAtual date,
    horaAtual time,
    fk_tanque int,
    temperatura decimal(4,2)
);

insert into tab_temperatura values
(1,"2021-10-18","10:21:00",1,9.5),
(2,"2021-10-18","10:31:00",1,8.7),
(3,"2021-10-18","10:41:00",1,8.89),
(4,"2021-10-18","10:51:00",2,10.23),
(5,"2021-10-18","11:01:00",2,8.5),
(6,"2021-10-18","10:21:00",7,9.5),
(7,"2021-10-18","11:31:00",7,7.83),
(8,"2021-10-18","10:41:00",7,9.71),
(9,"2021-10-18","11:51:00",7,10.01);

select * from tab_temperatura;

insert into tab_cliente(nomeCliente,emailCliente,senhaCliente,cpf_cliente,enderecoCliente) values 
	("Claudio","claudio.frizza@bandtec.com","1234","12312312312","Fazendo Santa Amélia"),
    ("Amanda","amanda.borges@bandtec.com","123456","12312312323","Fazendo Valdi");
    
insert into tab_filial(nomeFilial,emailFilial,senhaFilial,cnpj_filial,enderecoFilial,fk_cliente) values
	("Frizza","columbre@gmail.com","1010","88467343000101","Campo 03",1);
    
select * from tab_cliente;


insert into tab_filial(nomeFilial,emailFilial,senhaFilial,cnpj_filial,enderecoFilial,fk_cliente) values
	("Columbre","columbre@gmail.com","1010","88467343000101","Campo 01",1),
    ("Austie","austie@gmail.com","1010","51370550000133","Campo 02",2);
    
select * from tab_filial;

insert into tab_tanque values
(1,"Tanque 01",101),
(2,"Tanque 02",101),
(3,"Tanque 03",101),
(4,"Tanque 04",101),
(5,"Tanque 05",101),
(6,"Tanque 01",102),
(7,"Tanque 02",102),
(8,"Tanque 03",102),
(9,"Tanque 04",102);



select * from tab_tanque;


select * from tab_cliente;
select * from tab_filial;

-- inner join do cliente e suas filiais
select tc.nomeCliente, tf.* 
	from tab_cliente tc join tab_filial tf on tc.idCliente = tf.fk_cliente where nomeCliente="claudio";
    
    
-- inner join de todas as filiais
select  tt.idTanque,
		tt.nomeTanque,
        tf.nomeFilial
        from tab_filial tf join tab_tanque tt on tf.idFilial = tt.fk_filial;
        
-- Inner join de apenas uma filial
        select  tt.idTanque,
		tt.nomeTanque,
        tf.nomeFilial
        from tab_filial tf join tab_tanque tt on tf.idFilial = tt.fk_filial where nomeFilial="Austie";
        
        
-- Join da temperatura e seus tanques e suas filiais
select ttemp.*,
 tt.nomeTanque
 from tab_temperatura ttemp join tab_tanque tt on tt.idTanque = ttemp.fk_tanque;
        
        








    
    