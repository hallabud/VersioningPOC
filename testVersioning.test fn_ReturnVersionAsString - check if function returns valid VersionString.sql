USE CBOS_Audit
GO

CREATE PROC testVersioning.[test fn_ReturnVersionAsString - check if function returns valid VersionString]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @expected VARCHAR(100) = '2.3.12.48 (Ident)';
  DECLARE @actual VARCHAR(100);

  -- act

  SELECT @actual = Versioning.fn_ReturnVersionAsString(2,3,12,48,'Ident');

  -- assert
  
  EXEC tSQLt.AssertEquals @expected, @actual;

END