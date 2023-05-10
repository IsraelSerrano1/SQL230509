-- EJERCICIOS
/*

1 - Escriba un bloque de codigo PL/pgSQL que reciba una nota como parametro
    y notifique en la consola de mensaje las letras A,B,C,D,E o F segun el valor de la nota	

*/
DO $$
	DECLARE 
	nota INTEGER := 4;
	resultado char(1);
	
	BEGIN
	CASE nota
	WHEN 10,9 then resultado = 'A';
	WHEN 8,7 THEN	resultado = 'B';
	WHEN 6 THEN resultado = 'C';
	WHEN 5 THEN resultado = 'D';
	WHEN 4,3,2,1 THEN resultado = 'E';
	WHEN 0 THEN resultado = 'F';
	ELSE RAISE NOTICE 'introduce un valor entre 0 y 10'
	END CASE;
	
	RAISE NOTICE 'La nota es %', resultado;
END $$ LANGUAGE 'plpgsql';
	
/*
2 - Escriba un bloque de codigo PL/pgSQL que reciba un numero como parametro
    y muestre la tabla de multiplicar de ese numero.
*/

DO $$
	DECLARE 
	numero INTEGER := 5;
	i INTEGER;
	resultado INTEGER;
	
	BEGIN
	
	for i IN 0..10 LOOP
			resultado = numero * i;
			RAISE NOTICE '% * % = %', numero, i, resultado;
	END LOOP;
END $$ LANGUAGE 'plpgsql';
/*
3 - Escriba una funcion PL/pgSQL que convierta de dolares a moneda nacional.
    La funcion debe recibir dos parametros, cantidad de dolares y tasa de cambio.
    Al final debe retornar el monto convertido a moneda nacional.
*/


CREATE OR REPLACE FUNCTION conversion_moneda(dolares NUMERIC, tasa_cambio NUMERIC)
RETURNS NUMERIC AS $$
DECLARE 
    moneda NUMERIC;
BEGIN
    moneda := dolares * tasa_cambio;
    RETURN moneda;
END $$ LANGUAGE 'plpgsql';
SELECT conversion_moneda(10, 0.91);

/*
4 - Escriba una funcion PL/pgSQL que reciba como parametro el monto de un prestamo,
    su duracion en meses y la tasa de interes, retornando el monto de la cuota a pagar.
    Aplicar el metodo de amortizacion frances.	
	
	 C= V / (1-(1/(1+i))^N)/i)
*/
CREATE OR REPLACE FUNCTION cuota_a_pagar(monto NUMERIC, meses INTEGER, tasa_interes NUMERIC)
RETURNS NUMERIC AS $$
DECLARE 
	cuota NUMERIC;
	interes_mensual Numeric;
	BEGIN
		interes_mensual := tasa_interes/12;
		cuota := monto  / ((1-(1/(1+interes_mensual)^meses))/interes_mensual);
		
		RETURN cuota;
END $$ LANGUAGE 'plpgsql';

SELECT cuota_a_pagar(100,36,0.07);