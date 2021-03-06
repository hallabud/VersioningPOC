USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VersionType - Name is updated in tb_VersionType when existing @VersionTypeID and new @Name is provided]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VersionType - Name is updated in tb_VersionType when existing @VersionTypeID and new @Name is provided]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @expected NVARCHAR(100) = N'New name for version type'; 
  DECLARE @actual NVARCHAR(100);
  DECLARE @VersionTypeID INT = 1;

  EXEC tsqlt.FakeTable 'Versioning.tb_VersionType';
  
  INSERT INTO Versioning.tb_VersionType (VersionTypeID, [Name], Description)
  VALUES (@VersionTypeID, N'Old Name for version type', N'Description');
  
  DECLARE @Name NVARCHAR(100) = @expected;
  
  -- act
  EXEC [Versioning].[pr_Manage_VersionType] @Name = @Name, @VersionTypeID = @VersionTypeID;
  
  SELECT @actual = [Name] 
  FROM Versioning.tb_VersionType 
  WHERE Name = @Name;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
