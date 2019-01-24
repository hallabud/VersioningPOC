USE [CBOS_Audit]
GO

CREATE PROC [testVersioning].[test fn_ReturnVersionAsTable - check that functions returns NULLS instead of missing version parts]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @VersionAsString VARCHAR(100) = '10';

  SELECT 10 AS Major,
    NULL AS Minor,
    NULL AS Micro,
    NULL AS Revision
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
GO


