USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VersionType - if only @Name is valid the lookup and return @VersionTypeID]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VersionType - if only @Name is valid the lookup and return @VersionTypeID]

AS

BEGIN
  
  SET NOCOUNT ON;

  -- arrange
  DECLARE @VersionTypeID INT = 1;
  DECLARE @Name NVARCHAR(100) = N'Some name';
  
  DECLARE @expected INT = @VersionTypeID; 
  DECLARE @actual INT;
  DECLARE @return_value INT;

  EXEC tSQLt.FakeTable 'Versioning.tb_VersionType';

  INSERT INTO Versioning.tb_VersionType (VersionTypeID, Name, Description)
  VALUES (@VersionTypeID, @Name, N'Some description');

  -- act
  EXEC @return_value = Versioning.pr_Manage_VersionType @Name = @Name;

  SET @actual = @return_value;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
