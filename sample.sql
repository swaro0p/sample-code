USE [AssetManagement]
GO
/****** Object:  Table [dbo].[CityMaster]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CityMaster](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[CountryID] [int] NULL,
	[StateID] [int] NULL,
	[CityName] [varchar](50) NULL,
 CONSTRAINT [PK_CityMaster] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CountryMaster]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CountryMaster](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](50) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StateMaster]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StateMaster](
	[StateID] [int] IDENTITY(1,1) NOT NULL,
	[CountryID] [int] NULL,
	[StateName] [varchar](50) NULL,
 CONSTRAINT [PK_StateMaster] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[CityMaster] ON 

INSERT [dbo].[CityMaster] ([CityID], [CountryID], [StateID], [CityName]) VALUES (1, 1, 1, N'Navi Mumbai')
INSERT [dbo].[CityMaster] ([CityID], [CountryID], [StateID], [CityName]) VALUES (2, 1, 3, N'kurla')
INSERT [dbo].[CityMaster] ([CityID], [CountryID], [StateID], [CityName]) VALUES (5, 1, 1, N'Vikhroli')
SET IDENTITY_INSERT [dbo].[CityMaster] OFF
SET IDENTITY_INSERT [dbo].[CountryMaster] ON 

INSERT [dbo].[CountryMaster] ([CountryID], [CountryName]) VALUES (1, N'India')
SET IDENTITY_INSERT [dbo].[CountryMaster] OFF
SET IDENTITY_INSERT [dbo].[StateMaster] ON 

INSERT [dbo].[StateMaster] ([StateID], [CountryID], [StateName]) VALUES (1, 1, N'Maharashtra')
INSERT [dbo].[StateMaster] ([StateID], [CountryID], [StateName]) VALUES (2, 1, N'Goa')
INSERT [dbo].[StateMaster] ([StateID], [CountryID], [StateName]) VALUES (3, 1, N'Rajasthan')
SET IDENTITY_INSERT [dbo].[StateMaster] OFF
ALTER TABLE [dbo].[CityMaster]  WITH CHECK ADD  CONSTRAINT [FK_CityMaster_CountryMaster] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryMaster] ([CountryID])
GO
ALTER TABLE [dbo].[CityMaster] CHECK CONSTRAINT [FK_CityMaster_CountryMaster]
GO
ALTER TABLE [dbo].[CityMaster]  WITH CHECK ADD  CONSTRAINT [FK_CityMaster_StateMaster] FOREIGN KEY([StateID])
REFERENCES [dbo].[StateMaster] ([StateID])
GO
ALTER TABLE [dbo].[CityMaster] CHECK CONSTRAINT [FK_CityMaster_StateMaster]
GO
ALTER TABLE [dbo].[StateMaster]  WITH CHECK ADD  CONSTRAINT [FK_StateMaster_CountryMaster] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryMaster] ([CountryID])
GO
ALTER TABLE [dbo].[StateMaster] CHECK CONSTRAINT [FK_StateMaster_CountryMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_AddCity]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_AddCity]
@CountryID int,
@StateID int,
@CityName varchar(50)
AS
BEGIN
IF NOT EXISTS(Select CityName From CityMaster Where CityName = @CityName and StateID=@StateID)
BEGIN
INSERT INTO CityMaster
           ([CountryID]
           ,[StateID]
           ,[CityName])
     VALUES
           (@CountryID,@StateID, @CityName)
           Return 1
END 
ELSE
BEGIN
Return 0
END
          
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteCity]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DeleteCity]
@CityID int
AS
BEGIN
Delete From CityMaster Where CityID = @CityID
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetCity]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetCity]
AS
BEGIN
	SET NOCOUNT ON;
SELECT a.CityID
,a.CountryID
      ,c.CountryName
      ,a.StateID
      ,s.StateName
      ,a.CityName
  FROM CityMaster as a
  INNER JOIN CountryMaster as c ON a.CountryID = c.CountryID
  INNER JOIN StateMaster as s ON a.StateID = s.StateID
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetCityByCityID]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetCityByCityID]
@CityID int
AS
BEGIN
	SET NOCOUNT ON;
SELECT CityID
      ,CountryID
      ,StateID
      ,CityName
  FROM CityMaster
  WHERE CityID =@CityID
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetCityByState]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetCityByState]
@StateID int
AS
BEGIN
	SET NOCOUNT ON;
SELECT CityID
      ,CityName
  FROM CityMaster
  WHERE StateID  = @StateID
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetCountryList]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetCountryList]
AS
BEGIN
	SET NOCOUNT ON;
SELECT CountryID
      ,CountryName
  FROM CountryMaster
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetStateByCountry]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetStateByCountry]
@CountryID int
AS
BEGIN
	SET NOCOUNT ON;
SELECT StateID
      ,StateName
  FROM StateMaster
  WHERE CountryID = @CountryID
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetStateByStateID]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetStateByStateID]
@StateID int
AS
BEGIN
	SET NOCOUNT ON;
SELECT a.StateID
      ,a.CountryID
      ,c.CountryName
      ,a.StateName
  FROM StateMaster as a
  INNER JOIN CountryMaster as c ON a.CountryID = c.CountryID
  WHERE StateID =@StateID
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetStateList]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetStateList]
AS
BEGIN
	SET NOCOUNT ON;
SELECT StateID
      ,StateName
  FROM StateMaster
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetStates]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetStates]
AS
BEGIN
	SET NOCOUNT ON;
SELECT a.StateID
      ,a.CountryID
      ,c.CountryName
      ,a.StateName
  FROM StateMaster as a
  INNER JOIN CountryMaster as c ON a.CountryID = c.CountryID
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateCity]    Script Date: 10-01-2022 16:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UpdateCity]
@CityID int,
@StateID int,
@CountryID int,
@CityName varchar(50)
AS
BEGIN
IF NOT EXISTS(Select CityName From CityMaster Where CityName = @CityName and CountryID=@CountryID and StateID = @StateID 
and CityID <> @CityID)
BEGIN
Update CityMaster Set CountryID = @CountryID, StateID = @StateID, CityName = @CityName
Where CityID = @CityID
return 1
END
ELSE
BEGIN
return 0
END
END

GO
