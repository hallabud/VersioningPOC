USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VersionType - if @Name is provided and @VersionTypeID is NULL a row should be inserted into tb_VersionType]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VersionType - if @Name is provided and @VersionTypeID is NULL a row should be inserted into tb_VersionType]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @expected NVARCHAR(100) = N'Some new name'; 
  DECLARE @actual NVARCHAR(100);
  DECLARE @Name NVARCHAR(50) = N'Some new name';

  -- act
  EXEC [Versioning].[pr_Manage_VersionType] @Name = @Name;
  
  SELECT @actual = [Name] 
  FROM Versioning.tb_VersionType 
  WHERE Name = @Name;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
