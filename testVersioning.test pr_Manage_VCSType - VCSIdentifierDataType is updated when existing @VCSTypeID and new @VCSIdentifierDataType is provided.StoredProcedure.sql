USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VCSType - VCSIdentifierDataType is updated when existing @VCSTypeID and new @VCSIdentifierDataType is provided]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VCSType - VCSIdentifierDataType is updated when existing @VCSTypeID and new @VCSIdentifierDataType is provided]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @Name NVARCHAR(50) = 'Some VCS type name';
  DECLARE @InitialVCSIdentifierDataType NVARCHAR(40) = N'Initial data type for VCS type';
  DECLARE @VCSIdentifierDataType NVARCHAR(50) = N'New data type for VCS type';
  DECLARE @VCSTypeID INT = 1;

  EXEC tsqlt.FakeTable 'Versioning.tb_VCSType';

  INSERT INTO Versioning.tb_VCSType (VCSTypeID, Name, VCSIdentifierDataType)
    VALUES (@VCSTypeID, @Name, @InitialVCSIdentifierDataType);

  DECLARE @expected NVARCHAR(40) = @VCSIdentifierDataType; 
  DECLARE @actual NVARCHAR(40);

  -- act
  EXEC [Versioning].[pr_Manage_VCSType] 
   @Name = @Name, 
   @VCSIdentifierDataType = @VCSIdentifierDataType, 
   @VCSTypeID = @VCSTypeID;
  
  SELECT @actual = VCSIdentifierDataType 
  FROM Versioning.tb_VCSType 
  WHERE Name = @Name;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
