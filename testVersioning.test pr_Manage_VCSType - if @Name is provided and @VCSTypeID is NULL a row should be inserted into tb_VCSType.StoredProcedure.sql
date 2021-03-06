USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VCSType - if @Name is provided and @VCSTypeID is NULL a row should be inserted into tb_VCSType]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VCSType - if @Name is provided and @VCSTypeID is NULL a row should be inserted into tb_VCSType]

AS

BEGIN

  SET NOCOUNT ON;

   -- arrange
  DECLARE @NewName NVARCHAR(50) = 'New VCS type name';
 
  DECLARE @expected NVARCHAR(40) = @NewName; 
  DECLARE @actual NVARCHAR(40);

  -- act
  EXEC [Versioning].[pr_Manage_VCSType] @Name = @NewName;
  
  SELECT @actual = [Name] 
  FROM Versioning.tb_VCSType 
  WHERE Name = @NewName;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
