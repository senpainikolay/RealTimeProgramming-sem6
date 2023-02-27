use PTR

Declare @JSON varchar(max)
SELECT @JSON=BulkColumn
FROM OPENROWSET (BULK 'C:\Users\nicol\Desktop\ELIXIR\RealTimeProgramming-sem6\lab1\week5_rest_api\db.json', SINGLE_CLOB) import 
 SELECT *  INTO movies
 FROM OPENJSON (@JSON)  WITH (
   [id] int ,  
   [title] varchar(100),  
   [release_year] int,  
   [director] varchar(100)
   );  