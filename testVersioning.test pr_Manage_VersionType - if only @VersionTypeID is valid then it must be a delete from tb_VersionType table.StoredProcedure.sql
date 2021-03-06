USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VersionType - if only @VersionTypeID is valid then it must be a delete from tb_VersionType table]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VersionType - if only @VersionTypeID is valid then it must be a delete from tb_VersionType table]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @expected INT = NULL; 
  DECLARE @actual INT = NULL;

  DECLARE @VersionTypeID INT = 1;

  EXEC tSQLt.FakeTable 'Versioning.tb_VersionType';

  INSERT INTO Versioning.tb_VersionType (VersionTypeID, [Name], Description)
  VALUES (@VersionTypeID, N'Some name', N'Some description');

  -- act
  EXEC Versioning.pr_Manage_VersionType @VersionTypeID = @VersionTypeID, @Name = NULL;
  
  SELECT @actual = VersionTypeID 
  FROM Versioning.tb_VersionType 
  WHERE VersionTypeID = @VersionTypeID;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
