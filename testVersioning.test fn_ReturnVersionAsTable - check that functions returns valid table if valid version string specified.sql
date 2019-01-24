USE [CBOS_Audit]
GO

CREATE PROC testVersioning.[test fn_ReturnVersionAsTable - check that functions returns valid table if valid version string specified]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @VersionAsString VARCHAR(100) = '1.0.1.5';

  SELECT 1 AS Major,
    0 AS Minor,
    1 AS Micro,
    5 AS Revision
  INTO expected;

  -- act
  SELECT Major,
    Minor,
    Micro,
    Revision
  INTO actual
  FROM Versioning.fn_ReturnVersionAsTable(@VersionAsString);

  -- assert
  EXEC tSQLt.AssertEqualsTable 
    @expected = 'expected', 
    @actual = 'actual';

END