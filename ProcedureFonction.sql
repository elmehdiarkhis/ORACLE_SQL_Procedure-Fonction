
CREATE TABLE CLIENT(
    noClient NUMBER PRIMARY KEY,
    nom VARCHAR(20),
    prenom VARCHAR(20),
    telephone VARCHAR(20)
);

INSERT INTO CLIENT
VALUES
(1,'Stephan','jumper','5143201598');

INSERT INTO CLIENT
VALUES
(2,'alex','browski','4389201687');

INSERT INTO CLIENT
VALUES
(3,'simou','lefdass','5149201683');


CREATE OR REPLACE PROCEDURE proc_SelectAllNames IS
v_CLIENT CLIENT%ROWTYPE;
    CURSOR myCursor IS 
    select *
    from CLIENT;
BEGIN
    OPEN myCursor;
        LOOP
        FETCH myCursor INTO v_CLIENT;
        EXIT WHEN myCursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_CLIENT.nom); 
        END LOOP;
    CLOSE myCursor;
END;

SET SERVEROUTPUT on;
DECLARE
BEGIN
proc_SelectAllNames();
END;



CREATE TABLE VOITURES(
    code VARCHAR(20) PRIMARY KEY,
    marque VARCHAR(20)
);


CREATE OR REPLACE PROCEDURE proc_insertVoitures IS
v_marque VARCHAR(20):='&v_marque';
v_nombreVoiture NUMBER(5):=&v_nombreVoiture;
v_code VARCHAR(20);
i NUMBER(5);
BEGIN
for i in 1..v_nombreVoiture
    loop
    v_code := (v_marque || i);
    DBMS_OUTPUT.PUT_LINE(v_code);
    INSERT INTO VOITURES(code,marque)
    VALUES 
    (v_code,v_marque);
    end loop;
END;

SET SERVEROUTPUT on;
DECLARE
BEGIN
proc_insertVoitures();
END;


CREATE OR REPLACE PROCEDURE proc_selectAllVoitures IS
v_VOITURES VOITURES%ROWTYPE;
        CURSOR myCursor IS
        SELECT *
        FROM VOITURES;
BEGIN
        OPEN myCursor;
            loop
            FETCH myCursor INTO v_VOITURES;
            exit when myCursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('code : '||v_VOITURES.code||' marque : '|| v_VOITURES.marque);
            end loop;
        CLOSE myCursor;
END;
    
SET SERVEROUTPUT on;
DECLARE
BEGIN
proc_selectAllVoitures;
END;



CREATE OR REPLACE FUNCTION Operation(v_valueOne INTEGER,v_valueTwo INTEGER,v_operator VARCHAR) RETURN NUMBER IS
v_resultat NUMBER;

BEGIN
if (v_operator='+')then
    v_resultat := v_valueOne+v_valueTwo;
    return v_resultat;
elsif (v_operator='-')then
    v_resultat := v_valueOne-v_valueTwo;
    return v_resultat;
elsif (v_operator='x')then
    v_resultat := v_valueOne*v_valueTwo;
    return v_resultat;
elsif (v_operator='/') AND (v_valueTwo <>0) then 
    v_resultat := v_valueOne/v_valueTwo;
    return v_resultat;
end if;
END;


SET SERVEROUTPUT on;
DECLARE
v_valueOne NUMBER(5):=&v_valueOne;
v_valueTwo NUMBER(5):=&v_valueTwo;
v_operator VARCHAR(10):='&v_operator';
v_resultat NUMBER;

BEGIN
    if (v_operator='/' AND v_valueTwo =0) then 
        dbms_output.put_line('division sur zero non accepter');
    elsif (v_operator != '/' AND v_operator != '+' AND v_operator != '-' AND v_operator != '/')then 
        dbms_output.put_line('Veuillez entrer un operateure parmie les suivant +-x/'); 
    else 
        v_resultat := Operation(v_valueOne,v_valueTwo,v_operator);
        dbms_output.put_line(v_valueOne||' '||v_operator||' '||v_valueTwo || ' = ' || v_resultat);
    end if;
END;



CREATE OR REPLACE FUNCTION Factorielle(v_value INTEGER) RETURN NUMBER IS
v_resultat NUMBER:=1;
i NUMBER;
begin
for i in 1..v_value
    loop
    v_resultat := v_resultat * i;
    end loop;
return v_resultat;
end;



SET SERVEROUTPUT on;
DECLARE
v_value NUMBER(5):=&v_value;
v_resultat NUMBER;

BEGIN
    v_resultat := Factorielle(v_value);
    dbms_output.put_line('factorielle(' || v_value || ') = '||v_resultat);
END;