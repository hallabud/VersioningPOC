USE [CBOS_Audit]
GO
/****** Object:  StoredProcedure [testVersioning].[test pr_Manage_ObjectVersion - check that UPDATE is occured when existing @Fullname provided]    Script Date: 1/22/2019 5:55:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [testVersioning].[test pr_Manage_ObjectVersion - check that UPDATE is occured when existing @Fullname provided]

AS

BEGIN

  SET NOCOUNT ON;

  -- arrange
  DECLARE @ExistingFullName NVARCHAR(255);

    SELECT TOP (1) @ExistingFullName = FullName
    FROM Versioning.tb_ObjectVersion
    ORDER BY NEWID();

  DECLARE @CurrentVersionTypeID INT;

    SELECT @CurrentVersionTypeID = VersionTypeID
    FROM Versioning.tb_ObjectVersion
    WHERE FullName = @ExistingFullName;

  DECLARE @CurrentVersionTypeName NVARCHAR(100);

    SELECT @CurrentVersionTypeName = [Name]
    FROM Versioning.tb_VersionType
    WHERE VersionTypeID = @CurrentVersionTypeID;

  SELECT @ExistingFullName AS FullName,
    @CurrentVersionTypeID AS VersionTypeID,
    -2 AS Major,
    -2 AS Minor,
    -2 AS Micro,
    -2 AS Revision,
    4 AS VCSTypeID,
    '2019-01-01' AS UTCBuildDate
  INTO expected;

  -- act
  EXEC Versioning.pr_Manage_ObjectVersion
    @FullName = @ExistingFullName,
    @VersionTypeName = @CurrentVersionTypeName,
    @Major = -2,
    @Minor = -2,
    @Micro = -2,
    @Revision = -2,
    @VCSTypeName = N'Adhoc',
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
  WHERE FullName = @ExistingFullName;

  -- assert
  EXEC tsqlt.AssertEqualsTable @Expected = 'expected', @Actual = 'actual';

END
GO
