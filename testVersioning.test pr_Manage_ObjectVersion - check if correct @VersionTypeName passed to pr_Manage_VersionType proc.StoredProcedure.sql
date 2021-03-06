USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_ObjectVersion - check if correct @VersionTypeName passed to pr_Manage_VersionType proc]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [testVersioning].[test pr_Manage_ObjectVersion - check if correct @VersionTypeName passed to pr_Manage_VersionType proc]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  EXEC tSQLt.SpyProcedure 'Versioning.pr_Manage_VersionType';
  EXEC tSQLt.FakeTable 'Versioning.tb_ObjectVersion';

  
  SELECT [Name]
  INTO expected
  FROM (SELECT CAST(N'Patch' AS NVARCHAR(100))) ex (Name);

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
  FROM Versioning.pr_Manage_VersionType_SpyProcedureLog;

  -- assert
  EXEC tsqlt.AssertEqualsTable @Expected = 'expected', @Actual = 'actual';

END
GO
