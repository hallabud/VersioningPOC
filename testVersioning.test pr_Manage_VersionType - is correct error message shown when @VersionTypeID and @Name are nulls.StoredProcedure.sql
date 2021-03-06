USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VersionType - is correct error message shown when @VersionTypeID and @Name are nulls]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VersionType - is correct error message shown when @VersionTypeID and @Name are nulls]

AS

BEGIN

  SET NOCOUNT ON;

  EXEC tSQLt.ExpectException @ExpectedMessagePattern = N'%VersionTypeID and Name cannot be NULL.';
  EXEC [Versioning].[pr_Manage_VersionType] @VersionTypeID = NULL, @Name = NULL;

END
GO
