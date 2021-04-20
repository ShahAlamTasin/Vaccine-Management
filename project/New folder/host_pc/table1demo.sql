
clear screen;
DROP TABLE Servertable;
create table Servertable(hospitalid number, hospitalname varchar2(70), vaccineavailable number, area varchar2(40));

insert into Servertable values(1, 'Shaheed Suhrawardy Medical College and Hospital', 100,'mohammadpur'); 
insert into Servertable values(2, 'Mohammadpur Fertility Services and Training Centre', 100,'mohammadpur'); 
insert into Servertable values(3, 'Labaid specialized Hospital', 100,'dhanmondi'); 
insert into Servertable values(4, 'Popular Diagnostic Centre Ltd.', 100,'dhanmondi'); 
insert into Servertable values(5, 'National Institute of Laboratory Medicine and Referral Center', 100,'agargon'); 
insert into Servertable values(6, 'Bangabandhu Sheikh Mujib Medical University Hospital', 100,'shahbag'); 
insert into Servertable values(7, 'Armed Forces Institute of Pathology', 100,'shaheed_sharani'); 
insert into Servertable values(8, 'ICDDRB Dhaka Hospital', 100,'mohakhali'); 
insert into Servertable values(9, 'Ibn Sina Diagnostic and Imaging Center', 100,'dhanmondi'); 

commit;

select * from Servertable;
--select * from Servertable NATURAL JOIN Servertable2 @site1;