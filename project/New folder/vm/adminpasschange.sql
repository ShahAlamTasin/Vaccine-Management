SET VERIFY OFF;
SET SERVEROUTPUT ON;

ACCEPT PHON_NMBER CHAR PROMPT 'ENTER  YOUR PHONE NUMBER = '
ACCEPT OLDPASS CHAR PROMPT 'ENTER  YOUR OLD PASS = '
ACCEPT NEWPASS CHAR PROMPT 'ENTER  YOUR NEW PASS = '

DECLARE
 N  Servertable2.officerpass%type;
 O  Servertable2.officerpass%type;
 P  Servertable2.officerphoneno%type;
  datanotfound EXCEPTION;
 flag number;
BEGIN 
 
 P:= '&PHON_NMBER';
 O:= '&OLDPASS';
 N:= '&NEWPASS';

 flag:=0;
 
 for R in (select * from Servertable2) LOOP
 
 IF R.officerpass = O and R.officerphoneno = P then
 update Servertable2 set Servertable2.officerpass =N  where Servertable2.officerphoneno = P;
 flag:=1;
 exit;
 
 end if;
 
 
 END LOOP;
 
 if flag =0 then
 raise datanotfound;
end if; 

 EXCEPTION
   when datanotfound then
    DBMS_OUTPUT.PUT_LINE(' Desired data not found in database exception' );

END;
/
CREATE OR REPLACE TRIGGER trg3 
      before update of officerpass
      ON Servertable2
      DECLARE
      BEGIN
	DBMS_OUTPUT.PUT_LINE(' triggered and data updated to table ');
    END;
     /
 commit;