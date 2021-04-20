
clear screen;
DROP table maintable1;

Create table   maintable1 as ( select * from Servertable  NATURAL JOIN Servertable2@site1);

create or replace view view1(view_A, view_B, view_C,view_D, view_E, view_F) as
select S.hospitalid, S.hospitalname, S.vaccineavailable,S.area, S.officerphoneno, S.officerpass
from maintable1 S;

select * from view1;

commit;