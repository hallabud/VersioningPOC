USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VCSType - is correct error message shown when @VCSTypeID and @Name are nulls]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VCSType - is correct error message shown when @VCSTypeID and @Name are nulls]

AS

BEGIN

  SET NOCOUNT ON;

  EXEC tSQLt.ExpectException @ExpectedMessagePattern = N'%VCSTypeID and Name cannot be NULL.';
  EXEC [Versioning].[pr_Manage_VCSType] @VCSTypeID = NULL, @Name = NULL;

END
GO
