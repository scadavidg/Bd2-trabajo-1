INSERT INTO red VALUES(1,'ejemplo', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>50</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>1</nodo1>
        <costo>90</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>2</nodo1>
        <costo>100</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>3</nodo1>
        <costo>20</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "5">
        <nodo1>4</nodo1>
        <costo>30</costo>        
        <nodo2>5</nodo2>
    </enlace>
     <enlace NO = "6">
        <nodo1>3</nodo1>
        <costo>90</costo>        
        <nodo2>5</nodo2>
    </enlace>
    <enlace NO = "7">
        <nodo1>5</nodo1>
        <costo>200</costo>        
        <nodo2>1</nodo2>
    </enlace>
</grafo>'));
----------------------------------

INSERT INTO red VALUES(2,'ejemplo', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>50</costo>        
        <nodo2>3</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>3</nodo1>
        <costo>90</costo>        
        <nodo2>4</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>4</nodo1>
        <costo>100</costo>        
        <nodo2>5</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>5</nodo1>
        <costo>20</costo>        
        <nodo2>1</nodo2>
    </enlace>
</grafo>'));

---------------------

INSERT INTO red VALUES(3,'ejemplo', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>10</nodo1>
        <costo>50</costo>        
        <nodo2>3</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>3</nodo1>
        <costo>90</costo>        
        <nodo2>40</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>40</nodo1>
        <costo>100</costo>        
        <nodo2>5</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>5</nodo1>
        <costo>20</costo>        
        <nodo2>10</nodo2>
    </enlace>
</grafo>'));

------------------------------------
INSERT INTO red VALUES(330,'ejemplo', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>1</nodo1>
        <costo>50</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>2</nodo1>
        <costo>20</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>3</nodo1>
        <costo>30</costo>        
        <nodo2>4</nodo2>
    </enlace>
     <enlace NO = "5">
        <nodo1>1</nodo1>
        <costo>90</costo>        
        <nodo2>4</nodo2>
    </enlace>
     <enlace NO = "6">
        <nodo1>4</nodo1>
        <costo>90</costo>        
        <nodo2>5</nodo2>
    </enlace>
     <enlace NO = "7">
        <nodo1>5</nodo1>
        <costo>10000</costo>        
        <nodo2>1</nodo2>
    </enlace>
</grafo>'));

----------------------------------
INSERT INTO red VALUES(110,'ejemplo', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>2</nodo1>
        <costo>300</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>2</nodo1>
        <costo>1000</costo>        
        <nodo2>6</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>4</nodo1>
        <costo>70</costo>        
        <nodo2>6</nodo2>
    </enlace>
     <enlace NO = "4">
        <nodo1>4</nodo1>
        <costo>40</costo>        
        <nodo2>5</nodo2>
    </enlace>
     <enlace NO = "5">
        <nodo1>5</nodo1>
        <costo>700</costo>        
        <nodo2>2</nodo2>
    </enlace>
</grafo>'));



  CREATE OR REPLACE PROCEDURE ciudades_comunes
  (r1_id IN red.id_red%TYPE,r2_id IN red.id_red%TYPE)
  IS 
  CURSOR r1 IS  SELECT nodo1,costo,nodo2 
                  FROM red , (XMLTABLE('/grafo/enlace'  
                                     PASSING red.grafo_rutas
                                     COLUMNS  
                                        nodo1  varchar2(20)    PATH './nodo1',  
                                        costo  varchar2(20)    PATH './costo',  
                                        nodo2  varchar2(20)    PATH './nodo2'
                                 ) xmlt)
                  WHERE id_red=r1_id ;
  CURSOR r2 IS  SELECT nodo1,costo,nodo2 
                  FROM red , (XMLTABLE('/grafo/enlace'  
                                     PASSING red.grafo_rutas
                                     COLUMNS  
                                        nodo1  varchar2(20)    PATH './nodo1',  
                                        costo  varchar2(20)    PATH './costo',  
                                        nodo2  varchar2(20)    PATH './nodo2'
                                 ) xmlt)
                  WHERE id_red=r2_id ;

   TYPE t_num IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
   mis_num t_num;
   mis_num1 t_num;
   mis_num2 t_num;
   i NUMBER:=1;
   j NUMBER:=1;
   k NUMBER:=1;
   numi NUMBER(10);
   cont NUMBER;
  BEGIN          
        FOR r1_i IN r1 LOOP
          FOR r2_i IN r2 LOOP

            IF r1_i.nodo1 =r2_i.nodo1 THEN 
                         
                    mis_num(i):=r1_i.nodo1;  
                    i:=i+1;     
                  
            END IF;
           
          END LOOP; 
        END LOOP; 

        FOR i IN 1..mis_num.COUNT LOOP
          cont:=0;
          numi:=mis_num(i);
          mis_num1(j):=numi;
          j:=j+1;
          FOR K IN 1..mis_num1.COUNT LOOP
            IF (mis_num1(K)=numi) THEN
                cont:=cont+1;
            END IF;
          END LOOP;
          IF cont=1 THEN
            mis_num2(k):=numi;
            k:=k+1;
          END IF;
        END LOOP;



       
        DBMS_OUTPUT.PUT_LINE(  'Ciudades Comunes: ' || mis_num2.COUNT);
        FOR i IN 1..mis_num.COUNT LOOP
          DBMS_OUTPUT.PUT_LINE(  'codigo de ciudad ' || mis_num2(i));
        END LOOP;
   
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('FINISH PROCEDURE');
  END;
  /
