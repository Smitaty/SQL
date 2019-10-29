/* 
Cet exercice avait pour but de travailler sur la création de table en SQL puis de les traiter grâce à des requêtes SQL
*/

Drop table if exists etudiant cascade;

drop sequence if exists numet;
create sequence numet minvalue 1111;


Drop table if exists groupe cascade;


create table groupe
(nomgroupe varchar(5) primary key constraint groupe check (nomgroupe in ('A1','A2','A3','A4','A5','A6')),
intitulegroupe varchar (15));


\d groupe;

create table etudiant
( numet integer primary key,
nomet varchar(30),
prenomet varchar(30),
adret varchar(50),
datnais date constraint nais check ((datnais <='2002-01-01') and (datnais >='1978-01-01')),
nomgr varchar(5),
foreign key(nomgr)
references groupe(nomgroupe)
	on update cascade on delete cascade);

\d etudiant;

Drop table if exists enseignant cascade;

drop sequence if exists numens;
create sequence numens;

create table enseignant
(numens integer primary key,
nomens varchar(30));

\d enseignant;

Drop table if exists matiere cascade;

create table matiere
(nommat varchar(15) primary key,
coefmat integer constraint cfmat check ((coefmat>=1) and (coefmat<=8)),
numens integer,
foreign key(numens)
references enseignant(numens)
	on update cascade on delete cascade);

\d matiere;


Drop table if exists controle cascade;

drop sequence if exists numcont;
create sequence numcont;

create table controle
(numcont integer primary key,
nommat varchar(15),
datcont date,
coef integer constraint cfcompte check ((coef>=0) and (coef<=20)),
foreign key(nommat)
references matiere(nommat)
	on update cascade on delete cascade);

\d controle;

Drop table if exists passcont cascade;

create table passcont
(numet integer,
numcont integer,
note float constraint notec check((note>=0) and (note<=21)),
primary key(numet,numcont),
foreign key(numet)
references etudiant(numet)
	on update cascade on delete cascade);

\d passcont;

insert into groupe
values
('A1','Informatique'),
('A2','Math-Info'),
('A3','Bio-Info'),
('A4','Chimie'),
('A5','Math');

select *
from groupe;

insert into etudiant
values
(nextval('numet'),'AHDJOUDJ','Yannick','Angers','2000-01-18','A1'),
(nextval('numet'),'AMEUR','Adil','Cholet','1999-02-17','A1'),
(nextval('numet'),'CALVAIRE','Isabelle','Nantes','2001-03-01','A2'),
(nextval('numet'),'GHULAM','William','Cholet','2001-04-27','A2'),
(nextval('numet'),'MIRMONT','Jean','Paris','1999-05-07','A3'),
(nextval('numet'),'TOTO','Sylvie','Tours','1998-06-17','A3'),
(nextval('numet'),'WINTERHA','Shahidah','Toulouse','2000-07-07','A3');

select *
from etudiant;

insert into enseignant
values
(nextval('numens'),'Carter'),
(nextval('numens'),'Clinton'),
(nextval('numens'),'Bush'),
(nextval('numens'),'Paolo'),
(nextval('numens'),'Vissou'),
(nextval('numens'),'Charlemagne'),
(nextval('numens'),'Léandri');


select *
from enseignant;

insert into matiere
values
('Algo 2',6,1),
('Algo 3',7,2),
('Math1',6,3),
('Gestion',7,4),
('TE',7,5),
('Math2',6,6),
('Anglais',7,7);

select *
from matiere;

insert into controle
values
(nextval('numcont'),'Algo 2','2018-01-15','1'),
(nextval('numcont'),'Algo 2','2017-12-12','3'),
(nextval('numcont'),'Algo 3','2018-02-17','2'),
(nextval('numcont'),'Algo 3','2018-03-27','3'),
(nextval('numcont'),'Math1','2018-01-17','1'),
(nextval('numcont'),'Gestion','2018-02-07','2'),
(nextval('numcont'),'TE','2018-03-27','2'),
(nextval('numcont'),'Math2','2018-01-17','1'),
(nextval('numcont'),'Anglais','2018-01-27','2');

select *
from controle;


insert into passcont
values
(1111,1,10),
(1112,1,20),
(1113,1,11.5),
(1114,1,3),
(1115,1,10.5),
(1116,1,12),
(1111,2,10.5),
(1112,2,6.6),
(1113,2,4.5),
(1114,2,9),
(1115,2,8.5),
(1116,2,2.5),
(1111,3,14.5),
(1112,3,11.5),
(1113,3,3.5),
(1114,3,12.5),
(1115,3,20),
(1116,3,9.5);

select *
from passcont;

--2
insert into etudiant
values
(1200,'ZIDANE','Zinédine','Marseille','1972-06-23','A1'); 
-- erreur car plus de 40 ans 

--3
insert into etudiant
values
(1300,'MBAPPÉ','Kylian','Paris','1998-12-20','A6');
-- erreur car pas encore de groupe A6 crée


--4
insert into groupe
values
('A6','Football'); 

select *
from groupe;

--5
insert into etudiant
values
(1300,'MBAPPÉ','Kylian','Paris','1998-12-20','A6');

select *
from etudiant;

--6
insert into passcont
values
(1118,1,15);
-- 1118 pas encore crée

--7
insert into etudiant
values
(nextval('numet'),'POGBA','Paul','Manchester','1993-03-15','A1');

select *
from etudiant;

--8
insert into passcont
values
(1118,1,15);

select *
from passcont;

--9
update enseignant
set numens=101
where nomens='Carter';

select *
from enseignant;

select *
from matiere;

--10

insert into etudiant
values
(nextval('numet'),'VARANE','Raphael','Madrid','1993-04-25',(select nomgroupe from groupe where intitulegroupe='Informatique'));

select *
from etudiant;

--11

alter table groupe
add salle varchar(5);

--12

update groupe
set salle=concat('L00',(select substring (nomgroupe from 2 for 1) from groupe where nomgroupe='A1'))
where nomgroupe='A1';

update groupe
set salle=concat('L00',(select substring (nomgroupe from 2 for 1) from groupe where nomgroupe='A2'))
where nomgroupe='A2';

update groupe
set salle=concat('L00',(select substring (nomgroupe from 2 for 1) from groupe where nomgroupe='A3'))
where nomgroupe='A3';

update groupe
set salle=concat('L00',(select substring (nomgroupe from 2 for 1) from groupe where nomgroupe='A4'))
where nomgroupe='A4';

update groupe
set salle=concat('L00',(select substring (nomgroupe from 2 for 1) from groupe where nomgroupe='A5'))
where nomgroupe='A5';

update groupe
set salle=concat('L00',(select substring (nomgroupe from 2 for 1) from groupe where nomgroupe='A6'))
where nomgroupe='A6';

select *
from groupe;

--13

create view EtudiantGroupe
as(select numet,nomet,nomgr
from etudiant
order by nomgr);

select *
from EtudiantGroupe;

--14

create view EtudiantNote 
as(select E.nomet,P.note,C.nommat
from (Passcont P join Etudiant E on P.numet=E.numet) join Controle C on P.numcont=C.numcont
order by e.nomet);

select *
from EtudiantNote;


--15

update passcont
set note=note+1
where numcont=(select numcont from (select numcont,avg(note) as A from passcont group by numcont) p where A<=8);

select *
from passcont;


--16

select P.note
from (Passcont P join Etudiant E on P.numet=E.numet) join Controle C on C.numcont=P.numcont
where (P.numet=(select numet from etudiant where nomet='TOTO')) and (P.numcont=(select numcont from controle where (nommat='Algo 2') and (datcont='2017-12-12')));

--17

insert into etudiant
values
(1200,'amer','bonjour','Lille','1998-11-20','A4');

select nomet
from etudiant
where (nomet like 'a%') or (nomet like 'A%');


-- 18

select C.coef
from Controle C join Passcont P on C.numcont=p.numcont
where note=20;

-- 19

select E.numet,E.nomet
from (Passcont P join Etudiant E on P.numet=E.numet) join Controle C on C.numcont=P.numcont
where (P.note>=10) and (P.numcont=(select numcont from Controle where (nommat='Algo 2') and (datcont='2017-12-12')));

--20

select distinct E.numens,E.nomens
from ((Enseignant E join Matiere M on E.numens=M.numens) join Controle C on M.nommat=C.nommat) join Passcont P on P.numcont=C.numcont;


--21 

select *
from etudiant;

select numet,nomet
from Etudiant

Except

select numet,nomet
from Etudiant
where (adret='Cholet') or (adret='Angers') or (adret='Tours');


--22

insert into passcont
values
(1114,4,8),
(1112,4,12);

select *
from passcont;

select *
from controle;

select E.numet,E.nomet
from etudiant E join Passcont P on E.numet=P.numet
where (P.note>(select note 
		from (passcont P join etudiant E on P.numet=E.numet) join Controle C on P.numcont=c.numcont 
			where ((E.nomet='GHULAM') and (C.nommat='Algo 3') and (C.datcont='2018-03-27')))) /*
	and (P.numcont=(select C.numcont 
				from Controle C join passcont P on C.numcont=P.numcont 
						where ((C.nommat='Algo 3') and (C.datcont='2018-03-27')))) */;





















