USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_ObjectVersion - check that INSERT is occured when not existing @Fullname provided]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_ObjectVersion - check that INSERT is occured when not existing @Fullname provided]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @NewFullName NVARCHAR(255) = N'Some new Fullname not existing yet';
  
  EXEC tSQLt.FakeTable 'Versioning.tb_VCSType';
  
    DECLARE @VCSTypeName NVARCHAR(50) = 'Some VCS type name';
    DECLARE @VCSTypeID INT = 1;

  INSERT INTO Versioning.tb_VCSType (VCSTypeID, Name)
    VALUES (@VCSTypeID, @VCSTypeName);

  EXEC tSQLt.FakeTable 'Versioning.tb_VersionType';
  
    DECLARE @VersionTypeID INT = 1;
    DECLARE @VersionTypeName NVARCHAR(100) = N'Some name';

    INSERT INTO Versioning.tb_VersionType (VersionTypeID, Name, Description)
    VALUES (@VersionTypeID, @VersionTypeName, N'Some description');

  SELECT @NewFullName AS FullName,
    @VersionTypeID AS VersionTypeID,
    -2 AS Major,
    -2 AS Minor,
    -2 AS Micro,
    @VCSTypeID AS VCSTypeID,
    '2019-01-01' AS UTCBuildDate
  INTO expected;

  -- act
  EXEC Versioning.pr_Manage_ObjectVersion
    @FullName = @NewFullName,
    @VersionTypeName = @VersionTypeName,
    @Major = -2,
    @Minor = -2,
    @Micro = -2,
    @Revision = -2,
    @VCSTypeName = @VCSTypeName,
    @UTCBuildDate = '2019-01-01';

  SELECT FullName,
    VersionTypeID,
    Major,
    Minor,
    Micro,
    Revision,
    VCSTypeID,
    UTCBuildDate
  INTO actual
  FROM Versioning.tb_ObjectVersion
  WHERE FullName = @NewFullName;

  -- assert
  EXEC tsqlt.AssertEqualsTable @Expected = 'expected', @Actual = 'actual';

END
GO
