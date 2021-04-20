
clear screen;
DROP TABLE patienttable;
create table patienttable(patientid number unique, patientname varchar2(20), patient_nid varchar2(20) unique,hospitalid number, schedule date );

insert into patienttable values(1001, 'shah alam', '2012435fryu4',1, ADD_MONTHS(SYSDATE, 1)); 
insert into patienttable values(1002, 'tasin', '2032435fpeu4', 2,ADD_MONTHS(SYSDATE, 1)); 
insert into patienttable values(1003, 'shah alif','2042s435fiyu4', 3,ADD_MONTHS(SYSDATE, 1)); 
insert into patienttable values(1004, 'tousif','2041o475diru4', 4,ADD_MONTHS(SYSDATE, 1)); 



select * from patienttable;

commit;
