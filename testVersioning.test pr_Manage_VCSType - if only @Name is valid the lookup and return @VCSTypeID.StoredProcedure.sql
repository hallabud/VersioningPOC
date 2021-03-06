USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VCSType - if only @Name is valid the lookup and return @VCSTypeID]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VCSType - if only @Name is valid the lookup and return @VCSTypeID]

AS

BEGIN
  
  SET NOCOUNT ON;

  -- arrange
  DECLARE @Name NVARCHAR(50) = 'Some VCS type name';
  DECLARE @VCSTypeID INT = 1;
  DECLARE @return_value INT;

  EXEC tsqlt.FakeTable 'Versioning.tb_VCSType';

  INSERT INTO Versioning.tb_VCSType (VCSTypeID, Name)
    VALUES (@VCSTypeID, @Name);

  DECLARE @expected NVARCHAR(40) = @VCSTypeID; 
  DECLARE @actual NVARCHAR(40);

  -- act
  EXEC @return_value = [Versioning].[pr_Manage_VCSType] @Name = @Name;

  SET @actual = @return_value;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
