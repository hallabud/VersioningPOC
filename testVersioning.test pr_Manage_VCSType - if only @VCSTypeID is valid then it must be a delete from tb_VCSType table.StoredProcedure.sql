USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VCSType - if only @VCSTypeID is valid then it must be a delete from tb_VCSType table]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VCSType - if only @VCSTypeID is valid then it must be a delete from tb_VCSType table]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @Name NVARCHAR(50) = 'Some VCS type name';
  DECLARE @VCSTypeID INT = 1;

  EXEC tsqlt.FakeTable 'Versioning.tb_VCSType';

  INSERT INTO Versioning.tb_VCSType (VCSTypeID, Name)
    VALUES (@VCSTypeID, @Name);

  DECLARE @expected NVARCHAR(40) = NULL; 
  DECLARE @actual NVARCHAR(40);

  -- act
  EXEC [Versioning].[pr_Manage_VCSType] @VCSTypeID = @VCSTypeID, @Name = NULL;
  
  SELECT @actual = VCSTypeID 
  FROM Versioning.tb_VCSType 
  WHERE VCSTypeID = @VCSTypeID;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
