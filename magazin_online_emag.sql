# CREAREA UNEI BAZE DE DATE
create database magazin_online_emag;

# Tabela1: produse (id, descriere, pret, marca_produs, furnizor, id_discount)
create table produse(
       id int not null auto_increment primary key,
       descriere varchar(50),
       pret float not null,
       marca_produs varchar(30),
       furnizor varchar(30),
       id_discount int
       );
 
 # Tabela2: comenzi (id, id_produs, nr_bucati, status_comanda, valoare_comanda, tip_livrare, data_plasare_comanda)
create table comenzi(
		id int not null auto_increment primary key,
        id_produs int not null,
        nr_bucati int,
        status_comanda varchar(30),
        valoare_comanda float,
        tip_livrare varchar(30),
        data_plasare_comanda date,
        foreign key(id_produs) references produse(id)
        );

# arata structura unei tabele
desc produse;
desc comenzi;
# stergem o intreaga tabela
#drop table comenzi;

# Tabela 6: discount (id, nume_discount, data_inceput, data_expirare, procent_discount)
create table discount(
        id int not null auto_increment primary key,
        nume_discount varchar(30),
        data_inceput date,
        data_expirare date,
        procent_discount int
        );
        
alter table produse add foreign key(id_discount) references discount(id);

#Tabela 4: plati (id, id_comanda, tip_plata, status)
 create table plati(
         id int not null auto_increment primary key,
         id_comanda int,
         nume varchar(2),
         tip_plata varchar(30),
         status_plata varchar(30),
         foreign key(id_comanda) references comenzi(id)
         );

alter table plati drop column nume;
drop table plati;
# Tabela3: utilizatori (id, nume, prenume, adresa, nr_telefon, email, card, id_comanda, id_discount)
create table utilizatori(
	     id int not null auto_increment primary key,
         nume varchar(30) not null,
         prenume varchar(30) not null,
         adresa varchar(30),
         nr_telefon varchar(15) not null,
         email varchar(30) not null,
         card varchar(20),
         id_comanda int not null,
         id_discount int not null,
         foreign key(id_comanda) references comenzi(id),
         foreign key(id_discount) references discount(id)
         );
desc utilizatori;
         
#Tabela 5: cos_cumparaturi (id, id_utilizator, id_produs, cantitate)	
create table cos_cumparaturi(
         id int not null auto_increment primary key,
         id_utilizator int not null,
         id_produs int not null,
         cantitate int,
         foreign key(id_utilizator) references utilizatori(id),
         foreign key(id_produs) references produse(id)
         );
desc cos_cumparaturi;
# comanda pt a ne da voie sa adaugam valori in tabele
set sql_safe_updates=0;
insert into discount (nume_discount, data_inceput, data_expirare, procent_discount)
values ("sales20", "2023-08-04", "2023-08-15",20);

insert into discount (nume_discount, data_inceput, data_expirare, procent_discount)
values
 ("sales30", "2023-08-01", "2023-08-30", 30),
 ("sales15", "2023-08-01", "2023-08-20", 15);

insert into produse (descriere, pret, marca_produs, furnizor, id_discount) 
 values
 ("laptop", 3000, "hp", "emag", 2),
 ("tableta", 500, "samsung", "altex", 1);
 
insert into produse (descriere, pret, marca_produs, furnizor, id_discount) 
values("televizor", 2500, "lg", "emag", 2);

insert into comenzi (id_produs, nr_bucati, status_comanda, valoare_comanda, tip_livrare, data_plasare_comanda)
values (1, 10, "in asteptare",2000, "curier","2023-08-01" );

insert into comenzi (id_produs, nr_bucati, status_comanda, valoare_comanda, tip_livrare, data_plasare_comanda)
values 
(1, 5, "aprobata", 2500, "curier","2023-08-04" ),
(1, 7, "expediata",3000, "curier","2023-08-03" );

insert into utilizatori (nume, prenume, adresa, nr_telefon, email, card, id_comanda, id_discount)
values ("Popescu", "Ion", "Florilor Nr 3", "0768222444", "pop@gmail.com", "4444-1234-5678-5789", 1, 1);

insert into plati(id_comanda, tip_plata, status_plata)
values(1,'ramburs','in asteptare');

insert into plati(id_comanda, tip_plata, status_plata)
values
      (2,'card','aprobata'),
      (3,'ramburs','in asteptare');
select * from plati;

insert into cos_cumparaturi(id_utilizator, id_produs, cantitate)
values(1,1,10);
select * from cos_cumparaturi;

update produse set pret = 1500 where id=1;
update discount set procent_discount = 10, nume_discount='sales10' where id=1;
update discount set procent_discount = 30, nume_discount='sales30' where id=2;
update discount set procent_discount = 10, nume_discount='sales10' where id=1;
update discount set procent_discount = 25 where nume_discount='sales30';
update discount set nume_discount='sales25' where data_inceput='2023-08-01' and data_expirare='2023-08-30';
update discount set nume_discount='sales' where data_expirare='2023-08-30' or data_expirare='2023-08-20';
update discount set nume_discount='sales20' where data_expirare='2023-08-30' or data_expirare='2023-08-10';
update discount set procent_discount=30 where data_inceput between '2023-08-01' and '2023-08-04';

update produse set descriere = replace(descriere,'telefon','smartphone') where descriere like '%tele%';

alter table produse add stoc int default 1;

update produse set pret = 2500, stoc=10 where id = 2;
update produse set pret = pret + pret*0.1 where id_discount = 1;		
update produse set pret = pret - 200 where id_discount = 2;

select * from plati;
select * from utilizatori;
select * from cos_cumparaturi;
select * from discount;
select * from comenzi;
select * from produse;

select descriere,pret from produse;
select * from produse where pret = 550;
select descriere from produse where pret = 550;

select * from discount;
select * from discount where data_expirare > '2023-08-15';
select * from discount where data_expirare >= '2023-08-15';
select * from discount where data_inceput>'2023-01-01' and data_expirare< '2023-08-30';
select * from discount where data_expirare < '2023-08-30' or procent_discount < 20;
select * from discount where procent_discount < 20;
select * from discount where procent_discount <= 10;
select * from discount where procent_discount != 10;

# a not in lista, a in lista
select * from discount where nume_discount in ('sales30','sales10');
select * from discount where nume_discount not in ('sales30','sales10');

insert into discount(nume_discount) values ('sales50');

# is null/is not null
select * from discount where procent_discount is null;
select * from discount where procent_discount is not null;

# operatorul LIKE
select * from produse where descriere like 't%';
select * from produse where descriere like '_a%'; -- pt a sa fie a doua litera
select * from produse where descriere like '%a_'; -- pt a fi penultima litera a

# functii agregate - asvg, sum, min, max, count
select avg(pret) from produse; -- media aritemtica
select sum(pret) from produse;
select min(pret) from produse;
select max(pret) from produse;
select max(pret) from produse;
select count(*) from produse; -- nr nr randurile care nu sunt nule
select count(*) from discount; 

select count(*) as 'Nr de inregistrari' from discount;

# order by = ordonarea indormatiilor dupa o coloana
select * from produse order by pret; -- ordine crscatoare
select * from produse order by pret desc; -- ordine descrescatoare
select * from produse order by marca_produs, pret; 

# group by 
select count(*), furnizor from produse group by furnizor;
# group by and order by
select count(*), furnizor from produse group by furnizor order by furnizor;

# HAVING - folosit la functiileagragate si in contextul group by
select count(*), furnizor from produse group by furnizor having count(*)>1;

# JOINURI

# INNER JOIN sau JOIN - ne aduce inf care sunt comune in cele 2 tabele
select status_comanda, tip_plata from comenzi c inner join plati p on p.id_comanda = c.id;

# left join - ne aduce pe langa lucrurile comune si cele din tabela stanga(comenzi)
select status_comanda, tip_plata from comenzi c left join plati p on p.id_comanda = c.id;

# right join - ne aduce pe langa lucrurile comune si cele din tabela dreapta(plati)
select status_comanda, tip_plata from comenzi c right join plati p on p.id_comanda = c.id;

# cross join - va cupla fiecare rand din tabela 1 cu fiecare rand din tabela 2
select status_comanda, tip_plata from comenzi cross join plati;