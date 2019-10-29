-- Ecriture de requêtes SQL afin de traiter des tables dans le but d'initier aux requêtes SQL.

--TP3
--Exo1

-- QUESTION 1
select nomf,nomp,prix from fournisseur join produit on fournisseur.numf=produit.numf 
where nomp in 
	(select nomp from commande join client 
	on commande.numc=client.numc 
	where nomc='Jean');

--Question 2
select nomf,nomp,prix from fournisseur join produit on fournisseur.numf=produit.numf 
where nomp in 
	(select nomp from commande join client 
	on commande.numc=client.numc 
	where nomc='Jean')
order by nomf,nomp DESC;

--QUESTION 3
select nomp from produit
where prix in
	(select min(prix) 
	from produit);

--QUESTION 4
select nomp,avg(prix) from produit
group by nomp;

--QUESTION 5
select nomp,avg(prix) from produit
group by nomp having avg(prix)>=1000;

--QUESTION 6
select distinct nomp from produit
where prix >=(select avg(prix) from produit);

--QUESTION 7
select nomp,avg(prix) from produit
group by nomp having count(numf)>=2;

--QUESTION 8
select nomp,prix from fournisseur f join produit p 
on f.numf=p.numf
where upper(villef) like '%ANGERS' and p.nomp in 
	(select nomp from commande c join client cl 
	  on c.numc=cl.numc 
	  where upper(villec) like '%PARIS');


-- Exo2

select *
from conges;
select *
from consultations;
select *
from patients;
select *
from personnels;
select *
from services;

-- Question 1

select nom
from personnels
where qualif='INFIRMIERE' and nom in (select nom from personnels where qualif='SECRETAIRE MEDICALE');

-- Question 2

select P.nom,P.prnm
from personnels P join patients S on P.nom=S.nom
where (S.prof=P.qualif);

-- Question 3

select P.nom,P.prnm
from personnels P
where qualif='SECRETAIRE MEDICALE' and sx='2' and not exists (select * from patients S where P.nom=S.nom and P.prnm=S.prnm);


--Question 4

select P.cdprs,P.nom,P.prnm,P.qualif,M.cdspr,M.nom,M.prnm,M.qualif
from Personnels P join Personnels M on P.cdspr=M.cdprs
where P.qualif='ASSISTANT' or P.qualif='CHEF DE CLINIQUE';

--Question 5

select P.nom,P.prnm,P.sx,P.datnais,S.nom
from personnels P join services S on P.cdsrv=S.cdsrv
where P.qualif='CHEF DE SERVICE';

-- Question 6

select S.nom,P.nom,prnm,sx
from services S left outer join (select * from personnels  where qualif='CHEF DE SERVICE') P on S.cdsrv=P.cdsrv;

--Question 7

select S.nom,
coalesce(P.nom,'*****') as nom,coalesce(prnm,'*****') as prnm,coalesce(sx,'*****') as sx
from services S left outer join (select * from personnels  where qualif='CHEF DE SERVICE') P on S.cdsrv=P.cdsrv;


-- Question 8

select S.cdsrv,S.nom
from services S
where not exists (select * from personnels P where S.cdsrv=P.cdsrv);


--EXO3

--QUESTION 1
select sum(qte) from commande c join client cl 
on c.numc=cl.numc 
where upper(nomc)='PIERRE';

--QUESTION 2
select numcom from commande co join client cl 
on co.numc=cl.numc
where  upper(nomc)!='VINCENT' and qte >=
	(select sum(qte) from commande co join client cl 
	 on co.numc=cl.numc
	 where upper(nomc)='VINCENT');

--QUESTION 3
select numcom from commande co join client cl 
on co.numc=cl.numc
where  upper(nomc)!='JEAN' and qte >= ANY
	(select qte from commande co join client cl 
	 on co.numc=cl.numc
	 where upper(nomc)='JEAN');

--QUESTION 4
select nomp from commande
except (select nomp from commande co join client cl on co.numc=cl.numc
	where upper(nomc)='JEAN');

--QUESTION 5
select numcom,col.nomp from (fournisseur f join produit p on f.numf=p.numf )as fr
 join 
(commande co join client cl on co.numc=cl.numc) as col on fr.nomp=col.nomp

where upper(substring(villeF from 6 for 20)) like upper(substring(villec from 6 for 20)) ;

--Question 6
select distinct upper(substring(villeF from 6 for 20)),upper(substring(villec from 6 for 20)) 
from (fournisseur f join produit p on f.numf=p.numf )as fr join 
(commande co join client cl on co.numc=cl.numc) as col on fr.nomp=col.nomp
;

--QUESTION 7
select distinct a.nomp,b.nomp 
from produit a join produit b on a.numf=b.numf 
order by a.nomp;

--QUESTION 8
select nomf from (fournisseur f join produit p on f.numf=p.numf) where nomp=ALL(select nomp from (commande co join client cl on co.numc=cl.numc) where upper(nomc)='VINCENT');
