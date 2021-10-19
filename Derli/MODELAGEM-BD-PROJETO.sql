create database froskProject;
use froskProject;


create table tab_cliente(
	idCliente int primary key auto_increment,
    nomeCliente varchar(50),
    emailCliente varchar(50),
    senhaCliente varchar(30),
    cpf_cliente char(11),
    endereçoCliente varchar(60)
)auto_increment= 1;

insert into tab_cliente(nomeCliente,emailCliente,senhaCliente,cpf_cliente,endereçoCLiente) values 
	("Claudio","claudio.frizza@bandtec.com","1234","12312312312","Fazendo Santa Amélia"),
    ("Amanda","amanda.borges@bandtec.com","123456","12312312323","Fazendo Valdi");
    select * from tab_cliente;


create table tab_filial(
	idFilial int primary key auto_increment,
    nomeFilial varchar(50),
    emailFilial varchar(50),
    senhaFilial varchar(30),
    cpf_filial char(11),
    endereçoFilial varchar(60),
    fk_cliente int,
    foreign key (fk_cliente) references tab_cliente(idCliente)
)auto_increment=101;

insert into tab_filial(nomeFilial,emailFilial,senhaFilial,cpf_filial,endereçoFilial,fk_cliente) values
	("Columbre","columbre@gmail.com","1010","01201201201","Campo 01",1),
    ("Austie","austie@gmail.com","1010","34534534512","Campo 02",2);
    
select * from tab_filial;


create table tab_tanqueSensor (
	idTanque int primary key auto_increment,
    nomeTanque varchar(30),
    tempTanque decimal(4,2),
    fk_filial int,
    horaData TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    foreign key (fk_filial) references tab_filial(idFilial)
)auto_increment = 1001;

select * from tab_tanqueSensor;

insert into tab_tanqueSensor(nomeTanque,tempTanque,fk_filial) values 
	("Tanque 01",9.32,101),
    ("Tanque 02",7.01,102);
insert into tab_tanqueSensor(nomeTanque,tempTanque,fk_filial) values
	("Tanque 03",8.7,101);
    
select tt.horaData,tt.nomeTanque,tt.tempTanque,tf.nomeFilial,tf.endereçoFilial
	from tab_tanqueSensor tt join tab_filial tf on tt.fk_filial = tf.idFilial where nomeFilial="Austie";
    