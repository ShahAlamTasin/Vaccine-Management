SET VERIFY OFF;
clear screen;
DROP TABLE Servertable2;
create table Servertable2(hospitalid number, officerphoneno varchar2(11) unique , officerpass varchar2(40));

insert into Servertable2 values(1, '1234567865','pass1'); 
insert into Servertable2 values(2, '1235567895','pass2'); 
insert into Servertable2 values(3, '1983147562','pass3'); 
insert into Servertable2 values(4, '1856605725','pass4'); 
insert into Servertable2 values(5, '1234167263','pass5'); 
insert into Servertable2 values(6, '1135568867','pass6'); 
insert into Servertable2 values(7, '2234667765','pass7'); 
insert into Servertable2 values(8, '1234587867','pass8'); 
insert into Servertable2 values(9, '6123356746','pass9'); 
Create table   completetable2 as ( select * from Servertable2 NATURAL JOIN Servertable @sitepc1);

commit;

select * from Servertable2;
select * from completetable2;