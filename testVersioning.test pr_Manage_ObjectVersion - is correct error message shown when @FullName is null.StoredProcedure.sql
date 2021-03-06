USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_ObjectVersion - is correct error message shown when @FullName is null]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_ObjectVersion - is correct error message shown when @FullName is null]

AS

BEGIN

  SET NOCOUNT ON;

  EXEC tSQLt.ExpectException @ExpectedMessagePattern = N'%FullName cannot be NULL.';

  EXEC Versioning.pr_Manage_ObjectVersion
    @FullName = NULL,
    @VersionTypeName = N'Patch',
    @Major = -1,
    @Minor = -1,
    @Micro = 1,
    @Revision = -1,
    @VCSTypeName = N'Adhoc',
    @UTCBuildDate = N'2019-01-01';

END
GO
