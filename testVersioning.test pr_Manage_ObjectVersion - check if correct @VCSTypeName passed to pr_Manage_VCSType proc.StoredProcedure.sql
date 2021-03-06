USE [CBOS_Audit]
GO

CREATE PROC [testVersioning].[test pr_Manage_ObjectVersion - check if correct @VCSTypeName passed to pr_Manage_VCSType proc]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  EXEC tSQLt.SpyProcedure 'Versioning.pr_Manage_VCSType';
  EXEC tSQLt.FakeTable 'Versioning.tb_ObjectVersion';

  
  SELECT [Name]
  INTO expected
  FROM (SELECT CAST(N'Adhoc' AS NVARCHAR(100))) ex (Name);

  -- act
  EXEC Versioning.pr_Manage_ObjectVersion
    @FullName = N'Some object name',
    @VersionTypeName = N'Patch',
    @Major = -1,
    @Minor = -1,
    @Micro = 1,
    @Revision = -1,
    @VCSTypeName = N'Adhoc',
    @UTCBuildDate = N'2019-01-01';

  SELECT [Name]
  INTO actual
  FROM Versioning.pr_Manage_VCSType_SpyProcedureLog;

  -- assert
  EXEC tsqlt.AssertEqualsTable @Expected = 'expected', @Actual = 'actual';

END
GO
