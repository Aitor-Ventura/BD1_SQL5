
 /* Obtener los coidgos de los suministradores que tengan un valor de situacion menor que el máximo valor de situacion de la tabla s */
 --ORIGINAL
 select distinct sn
from s 
where situacion < any(select situacion from s);
 
--SIN SUBCONSULTAS
create view Diap_20_A as
SELECT DISTINCT x.sn
from s x, s y
where x.situacion < y.situacion;

--CON EXISTS              
CREATE VIEW Diap_20_B as
select distinct x.sn
from s x
where exists(select y.sn
            from s y 
            where x.situacion<y.situacion);

----------------------------------------------------------------------------------------------------------------------------------------------------------
            
/* Obtener los codigos de los suministradores que viven en la misma 
ciudad que el proveedor cuyo código es 's1' */
--ORIGINAL
select sn
from s
where ciudad=(select ciudad
              from s
              where sn='s1');
              
--SIN SUBCONSULTAS
create view Diap_21_A as
select y.sn
from s x, s y
where x.sn='s1'
and y.ciudad=x.ciudad;

--CON CORRELACION SIN EXISTS
create view Diap_21_B as
select sn
from s
where ciudad in(select ciudad
            from s
            where sn='s1');
    
--CON EXISTS
create view Diap_21_C as
select distinct x.sn
from s x
where exists(select *
            from s y
            where y.sn='s1'
            and y.ciudad=x.ciudad);

----------------------------------------------------------------------------------------------------------------------------------------------------------            

/*Obtener los nombres de los suminstradores que suministran la parte 'p2'*/
--ORIGINAL
select distinct snombre 
from s 
where sn in(select sn
            from sp
            where pn='p2');
            
--sIN SUBCONSULTAS
create view Diap_22_A as
select distinct snombre from sp,s
where s.sn=sp.sn
and pn='p2';

--CON CORRELACION SIN EXISTS
create view Diap_22_B as
select distinct snombre 
from s 
where sn in(select sn
            from sp
            where pn='p2');

--CON EXISTS
create view Diap_22_C as
select distinct snombre
from s
where exists(select *
            from sp
            where pn='p2'
            and s.sn=sp.sn);

----------------------------------------------------------------------------------------------------------------------------------------------------------
            
/* Obtener el nombre de los proveedores que vendel al menos una parte roja */
--ORIGINAL
select distinct snombre 
from s
where sn in(select sn
        from sp
        where pn in(select pn
                    from p
                    where color = 'rojo'));

--CON CORRELACION SIN EXISTS
create view Diap_23_A as
select snombre
from s, sp
where sp.sn=s.sn
and sp.sn in(select sp.sn from p
            where p.pn=sp.pn
            and color='rojo');

--CON EXISTS
create view Diap_23_B as
select snombre
from s
where exists(select *
            from sp,p
            where sp.sn=s.sn
            and sp.pn=p.pn
            and color ='rojo');
        
----------------------------------------------------------------------------------------------------------------------------------------------------------        

            
/* Obtener los nombres de lus munisitradores que suminsitran la parte 'p2' */
--ORIGINAL
select distinct snombre
from s
where 'p2' in (select pn
              from sp
              where sn=s.sn);
              
--CON CORRELACION SIN EXISTS
create view Diap_24_A as
select distinct snombre
from s
where 'p2' in (select pn
              from sp
              where sn=s.sn);

--CON EXISTS              
create view Diap_24_B as
select distinct snombre 
from s
where exists(select *
            from sp
            where sp.sn=s.sn
            and pn='p2');
            
----------------------------------------------------------------------------------------------------------------------------------------------------------

/* Obtener los codigos de los proveedores que vendan al menos una parte suministrada por s2 */
--ORIGNIAL
select distinct sn
from sp 
where pn in(select pn
            from sp
            where sn='s2');
            
--SIN SUBCONSULTAS
create view Diap_26_A as
select distinct y.sn
from sp x,sp y 
where x.sn='s2'
and x.pn=y.pn;

-- CON CORRELACION SIN EXISTS
create view Diap_26_B as
select distinct x.sn
from sp x
where x.sn in (select x.sn
              from sp y
              where x.pn=y.pn
              and y.sn= 's2');
              
--CON EXISTS
create view Diap_26_C as
select distinct sn
from sp x
where exists(select *
              from sp y
              where x.pn=y.pn
              and y.sn= 's2' );
              
----------------------------------------------------------------------------------------------------------------------------------------------------------
              
/* Obtener los codigos de las partes vendidas por más de un proveedor */
--ORIGINAL
select distinct pn
from sp spX
where pn in(select pn
            from sp
            where sn<>spX.sn);
            
--SIN SUBCONSULTAS
create view Diap_27_A as
select distinct x.pn
from sp x, sp y
where x.pn=y.pn
and x.sn<>y.sn;

--CON CORRELACION SIN EXISTS DE FORMA DISTINTA A LA DIAPOSITIVA
create view Diap_27_B as
select distinct pn
from sp spX
where pn in(select pn
            from sp
            where sn<>spX.sn);
            
--CON EXISTS  
create view Diap_27_C as
SELECT DISTINCT pn
from sp x
where exists (select *
              from sp y
              where x.pn=y.pn
              and x.sn<>y.sn);
              
----------------------------------------------------------------------------------------------------------------------------------------------------------              

/* Obtener los proveedores que vendan la parte 'P2'*/
--ORIGINAL
select distinct snombre 
from s
where exists(select *
            from sp
            where sn=s.sn
            and pn='p2');
            
--SIN SUBCONSULTAS
create view Diap_28_A as
select distinct snombre 
from s, sp
where s.sn=sp.sn
and pn = 'p2';

--CON CORRELACION SIN EXISTS DE FORMA DISTINTA A LA DIAPOSITIVA
create view Diap_28_B as
select distinct snombre 
from s
where 'p2' in(select pn
              from sp
              where sn=s.sn);

----------------------------------------------------------------------------------------------------------------------------------------------------------

/* 'Obtener los códigos de los proyectos que no le compran partes al proveedor cuyo código es 's2'' */

--SIN CORRELACION
--create view Ej_Prop_A as
select distinct jn
from j
where jn in(select jn
            from spj
            where sn <>'s2'
            and spj.jn=j.jn);
            
--CON CORRELACION NOT IN 
--create view Ej_prop_B as
select distinct jn
from j
where 's2' not in(select sn
                from spj
                where j.jn=jn);
                
--CON NOT EXISTS
--create view Ej_prop_C as
select distinct jn
from j
where not exists(select *
                from spj
                where sn='s2'
                and j.jn=jn);
            
            
            
            
            
            
            
            
            
            
            
            
            