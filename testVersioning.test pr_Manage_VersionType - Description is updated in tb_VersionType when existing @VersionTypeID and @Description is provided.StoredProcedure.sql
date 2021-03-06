USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_VersionType - Description is updated in tb_VersionType when existing @VersionTypeID and @Description is provided]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_VersionType - Description is updated in tb_VersionType when existing @VersionTypeID and @Description is provided]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @expected NVARCHAR(100) = N'New description'; 
  DECLARE @actual NVARCHAR(100);

  DECLARE @Name NVARCHAR(100) = N'Some version type name';
  DECLARE @Description NVARCHAR(50) = N'New description';
  DECLARE @VersionTypeID INT = 1;

  EXEC tSQLt.FakeTable 'Versioning.tb_VersionType';

  INSERT INTO Versioning.tb_VersionType (VersionTypeID, Name, Description)
  VALUES (@VersionTypeID, @Name, N'Some old description');

  -- act
  EXEC Versioning.pr_Manage_VersionType
    @Name = @Name, 
    @Description = @Description, 
    @VersionTypeID = @VersionTypeID;
  
  SELECT @actual = [Description] 
  FROM Versioning.tb_VersionType 
  WHERE Name = @Name;

  -- asert
  EXEC tsqlt.AssertEquals @expected, @actual;

END
GO
