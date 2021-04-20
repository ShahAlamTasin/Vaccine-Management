SET VERIFY OFF;
SET SERVEROUTPUT ON;

Accept USERS number prompt  "enter 1 register for vaccine or enter 2 to see your details = "

Accept USERNAME char prompt  "enter your name = "

Accept USERNID char prompt  "enter your nid = "

Accept USERHOSPITAL char prompt  "enter your preferrable hospital name = "

CREATE OR REPLACE PACKAGE patientpackage AS
	FUNCTION userfunc( U IN number, B IN patienttable.patientname%type, C IN patienttable.patient_nid%type, D IN completetable2.hospitalname%type) 
	return number;
 
END patientpackage;
/

CREATE OR REPLACE PACKAGE BODY patientpackage AS
	FUNCTION userfunc(U IN number, B IN patienttable.patientname%type, C IN patienttable.patient_nid%type, D IN completetable2.hospitalname%type)
   return number
	IS 
	flg number;
	id Servertable2.hospitalid%type;
	cnt number;
	newpid number;
	tempdate date;
	hosname completetable2.hospitalname%type;
	newdate date;
	limitpattient number;
	emptyvaccine EXCEPTION;
	wrongdata EXCEPTION;
	notfound EXCEPTION;
	BEGIN
     
	 if U = 1 then
	    flg:=0;
	   for R IN (select * from completetable2) LOOP
	 
	    if R.hospitalname = D  and R.vaccineavailable >10 then
		 flg:=1;
		 id := R.hospitalid;
		 tempdate:= ADD_MONTHS(SYSDATE, 1);
		 select count(*) into cnt from patienttable;
		-- select count(*) into limitpattient from patienttable where schedule = tempdate AND hospitalid =id;  
		
		select count(*) into limitpattient from patienttable where to_char(tempdate, 'MM-DD') = to_char(patienttable.schedule, 'MM-DD') AND patienttable.hospitalid =id;  
		  newpid:=1000+cnt+1;
		    if limitpattient <10 then 
	
		     insert into patienttable values(newpid,B, C,id, ADD_MONTHS(SYSDATE, 1)); 
		     DBMS_OUTPUT.PUT_LINE(R.hospitalname);
		     exit;
		    elsif limitpattient >=10 then 
		 
		
		     newdate:= NEXT_DAY(tempdate, 'tuesday');
		     insert into patienttable values(newpid,B, C,id, newdate); 
		      exit;
		     end if;
			 
		 elsif  R.hospitalname = D  and R.vaccineavailable <2 then
		    flg:=1;
		  raise emptyvaccine;
		 	 
	
		end if;
	 
	 END LOOP;
	 
	 elsif U=2 then
	 
	   DBMS_OUTPUT.PUT_LINE('enter 2');

       flg:=0;
	  for R IN (select * from patienttable) LOOP
	  if R.patient_nid = C THEN
	   flg:=1;
	  DBMS_OUTPUT.PUT_LINE(' your name is ' || B);
	  DBMS_OUTPUT.PUT_LINE(' your nid is ' || C);
	  DBMS_OUTPUT.PUT_LINE( R.schedule );
	  id := R.hospitalid;
	  select completetable2.hospitalname into hosname from completetable2 where completetable2.hospitalid =id;
	   DBMS_OUTPUT.PUT_LINE(' Center : ' || hosname);
	  
	  exit;
	  END IF;
	  
	  END LOOP;
	
	 end if;
	 
	if flg=0 then
	raise notfound;
	end if;
	 
	 return 1;
   
   EXCEPTION
   when notfound then
    DBMS_OUTPUT.PUT_LINE(' Desired data not found in database exception' );
   when emptyvaccine then
        DBMS_OUTPUT.PUT_LINE(' Desired hospital has not enough vaccine exception' );
   
    END userfunc;
 	
END patientpackage;
/

 CREATE OR REPLACE TRIGGER trg1 
      before insert
      ON patienttable
      DECLARE
      BEGIN
	DBMS_OUTPUT.PUT_LINE(' triggered and data updated to table ');
    END;
     /

DECLARE
  U  number;
  B patienttable.patientname%type;
  C patienttable.patient_nid%type;
  D completetable2.hospitalname%type;
  i number;
BEGIN
   U:= &USERS;
 
   	B:= '&USERNAME';
    C:= '&USERNID';
	D:= '&USERHOSPITAL';

     i:= patientpackage.userfunc(U,B,C,D);


   

END;
/

	