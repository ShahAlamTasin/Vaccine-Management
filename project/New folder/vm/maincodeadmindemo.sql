SET VERIFY OFF;
SET SERVEROUTPUT ON;


 Accept ANUM char prompt  "enter phone number = "
Accept APASS char prompt  "enter admin passward = "
Accept vaccineupdate char prompt  "enter y if you want to allocate vaccine to your  hospital = "

CREATE OR REPLACE PACKAGE mainadminpackage AS
	
 PROCEDURE adproc(E IN  Servertable2.officerphoneno%type ,F IN Servertable2.officerpass%type,G IN Servertable2.officerpass%type);
END mainadminpackage;
/
CREATE OR REPLACE PACKAGE BODY mainadminpackage AS
 
   PROCEDURE adproc(E IN Servertable2.officerphoneno%type, F IN Servertable2.officerpass%type,G IN Servertable2.officerpass%type)
   IS
   aid Servertable2.hospitalid%type;
   flg NUMBER;
   wrong EXCEPTION;
   BEGIN
   DBMS_OUTPUT.PUT_LINE(E);
   DBMS_OUTPUT.PUT_LINE(F);
   flg:=0;
   for R IN (select * from Servertable2) LOOP
   
   if R.officerphoneno = E and R.officerpass= F THEN
  
   aid:=R.hospitalid;
   DBMS_OUTPUT.PUT_LINE(aid);
   flg := 1;
   
   
   end if;
   
   
   END LOOP;
   IF flg=1 and G = 'y' then
   
    
  UPDATE Servertable@sitepc1  SET Servertable.vaccineavailable = 120 WHERE Servertable.hospitalid = aid ;
    DBMS_OUTPUT.PUT_LINE('vaccine value  updated into the table ');
   END IF;
    IF flg=0 then
       RAISE wrong; 
   END IF;
   
    
 EXCEPTION
   WHEN wrong THEN
   DBMS_OUTPUT.PUT_LINE('login exception occur');
   
   
   END adproc;
   
  END mainadminpackage;
  /
  

   
   
DECLARE
  C   Servertable2.officerphoneno%type;
  D    Servertable2.officerpass%type;
  V    Servertable2.officerphoneno%type;
BEGIN
  

  
      C:= '&ANUM';
      D:= '&APASS';
	  V:= '&vaccineupdate';
       mainadminpackage.adproc(C,D,V);
 

END;
/



commit;