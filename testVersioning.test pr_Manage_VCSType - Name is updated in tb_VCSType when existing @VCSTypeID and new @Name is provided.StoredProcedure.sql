USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VCSType - Name is updated in tb_VCSType when existing @VCSTypeID and new @Name is provided]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VCSType - Name is updated in tb_VCSType when existing @VCSTypeID and new @Name is provided]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @expected NVARCHAR(100) = N'New name for GIT'; 
  DECLARE @actual NVARCHAR(100);
  DECLARE @Name NVARCHAR(50) = N'New name for GIT';
  DECLARE @VCSTypeID INT = 1;

  -- act
  EXEC [Versioning].[pr_Manage_VCSType] @Name = @Name, @VCSTypeID = @VCSTypeID;
  
  SELECT @actual = [Name] 
  FROM Versioning.tb_VCSType 
  WHERE Name = @Name;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
