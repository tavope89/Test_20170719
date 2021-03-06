USE [GFTTest]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 7/19/2017 6:37:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Client](
	[Id_Client] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](80) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Birth_Date] [date] NOT NULL,
	[Id_Client_Type] [int] NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Id_Client] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Client_Type]    Script Date: 7/19/2017 6:37:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Client_Type](
	[Id_Client_Type] [int] NOT NULL,
	[Type_Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Client_Type] PRIMARY KEY CLUSTERED 
(
	[Id_Client_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_Client_Type_01] FOREIGN KEY([Id_Client_Type])
REFERENCES [dbo].[Client_Type] ([Id_Client_Type])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Client_Client_Type_01]
GO
/****** Object:  StoredProcedure [dbo].[Delete_Client]    Script Date: 7/19/2017 6:37:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Delete_Client]
	@piId_Client			INT, 
	@piCode_Error		SMALLINT		OUTPUT,
	@psMsg_Error		VARCHAR(4000)	OUTPUT
AS
/*****************************************************************************************************************************************************
<Name>Delete Client</Name>
<Sistem>GFT Test</Sistem>
<Description>Store procedure which update a client</Description>
<Parameters>   
	@piId_Client		=	Id of the client who is going to be deleted  
</Parameters>
<Outputs>
	@piCode_Error		=	Code of the error
	@psMsg_Error		=	Messege or description of the error
</Outputs>
<Developer>Gustavo Perez Espinoza</Developer>
<Date>July 2017</Date>
<Requirement>GFT Test</Requirement>
<Version>1.0</Version>
<History>	
	<Change>
		<Developer></Developer>
		<Requirement></Requirement>
		<Date></Date>
		<Description></Description>
	</Change>
</History>
*****************************************************************************************************************************************************/
BEGIN
	SET NOCOUNT ON
	SET @piCode_Error	=	0;

	BEGIN TRY

		BEGIN TRANSACTION
		
			DELETE [dbo].[Client]
			WHERE [Id_Client]=@piId_Client
			 			 
		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		SET @piCode_Error	= -1
		SET	@psMsg_Error	= ERROR_MESSAGE()	
		ROLLBACK TRANSACTION
	END CATCH	
END

GO
/****** Object:  StoredProcedure [dbo].[Insert_Client]    Script Date: 7/19/2017 6:37:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Insert_Client]
	@psName				VARCHAR(80),
    @psEmail				VARCHAR (100),
    @pdBirth_Date			DATE,
    @piId_Client_Type		INT,
	@piCode_Error		SMALLINT		OUTPUT,
	@psMsg_Error		VARCHAR(4000)	OUTPUT
AS
/*****************************************************************************************************************************************************
<Name>Insert Client</Name>
<Sistem>GFT Test</Sistem>
<Description>Store procedure which insert a client</Description>
<Parameters>   
    @psName			=	New name of the client
    @psEmail			=	new email of the client
    @pdBirth_Date		=	new birht date of the client
    @piId_Client_Type	=	new type of the client
</Parameters>
<Outputs>
	@piCode_Error		=	Code of the error
	@psMsg_Error		=	Messege or description of the error
</Outputs>
<Developer>Gustavo Perez Espinoza</Developer>
<Date>July 2017</Date>
<Requirement>GFT Test</Requirement>
<Version>1.0</Version>
<History>	
	<Change>
		<Developer></Developer>
		<Requirement></Requirement>
		<Date></Date>
		<Description></Description>
	</Change>
</History>
*****************************************************************************************************************************************************/
BEGIN
	SET NOCOUNT ON
	SET @piCode_Error	=	0;

	BEGIN TRY

		BEGIN TRANSACTION		
	
			INSERT INTO [dbo].[Client]
					   ([Name]
					   ,[Email]
					   ,[Birth_Date]
					   ,[Id_Client_Type])
				 VALUES
					   (@psName
					   ,@psEmail
					   ,@pdBirth_Date
					   ,@piId_Client_Type)
					   			 			 
		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		SET @piCode_Error	= -1
		SET	@psMsg_Error	= ERROR_MESSAGE()	
		ROLLBACK TRANSACTION
	END CATCH	
END

GO
/****** Object:  StoredProcedure [dbo].[Select_Clients]    Script Date: 7/19/2017 6:37:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Select_Clients]
	@psName				VARCHAR(80),	
    @piId_Client_Type		INT,
	@piId_Column		INT,
	@piNumber_Rows		INT,
	@piNumber_Page		INT,
	@piCode_Error		SMALLINT		OUTPUT,
	@psMsg_Error		VARCHAR(4000)	OUTPUT
AS
/*****************************************************************************************************************************************************
<Name>Select Client</Name>
<Sistem>GFT Test</Sistem>
<Description>Store procedure which select clients</Description>
<Parameters>   
    @psName			=	name of the client that the select would be apply the filter
	@piId_Client_Type	=	new type of the client that the select would be apply the filter
	@piId_Column	=	Id of the column which indicates the order of de select
	@piNumber_Rows	=	Numer of rows per page
	@piNumber_Page	=	Numer of Page
</Parameters>
<Outputs>
	@piCode_Error	=	Code of the error
	@psMsg_Error	=	Messege or description of the error
</Outputs>
<Developer>Gustavo Perez Espinoza</Developer>
<Date>July 2017</Date>
<Requirement>GFT Test</Requirement>
<Version>1.0</Version>
<History>	
	<Change>
		<Developer></Developer>
		<Requirement></Requirement>
		<Date></Date>
		<Description></Description>
	</Change>
</History>
*****************************************************************************************************************************************************/
BEGIN
	SET NOCOUNT ON
	SET @piCode_Error	=	0;
	SET @psName= '%'+@psName+'%';
	BEGIN TRY

		SELECT	Id_Client  
				,Name
				,Email
				,Birth_Date
				,Id_Client_Type
		FROM dbo.Client		
		WHERE Id_Client_Type = @piId_Client_Type AND Name LIKE @psName 
		ORDER BY CASE @piId_Column
						WHEN 1 THEN  2
						WHEN 2 THEN  3
						WHEN 3 THEN  4
						WHEN 4 THEN  5
						ELSE 1
				END						
		OFFSET ((@piNumber_Page - 1) * @piNumber_Rows) ROWS
		FETCH NEXT @piNumber_Rows ROWS ONLY;	 			 

	END TRY
	BEGIN CATCH
		SET @piCode_Error	= -1
		SET	@psMsg_Error	= ERROR_MESSAGE()	
		ROLLBACK TRANSACTION
	END CATCH	
END

GO
/****** Object:  StoredProcedure [dbo].[Update_Client]    Script Date: 7/19/2017 6:37:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Update_Client]
	@piId_Client			INT,
    @psName				VARCHAR(80),
    @psEmail				VARCHAR (100),
    @pdBirth_Date			DATE,
    @piId_Client_Type		INT,
	@piCode_Error		SMALLINT		OUTPUT,
	@psMsg_Error		VARCHAR(4000)	OUTPUT
AS
/*****************************************************************************************************************************************************
<Name>Update Client</Name>
<Sistem>GFT Test</Sistem>
<Description>Store procedure which update a client</Description>
<Parameters>   
	@piId_Client		=	Id of the client who is going to be updated
    @psName			=	New name of the client
    @psEmail			=	new email of the client
    @pdBirth_Date		=	new birht date of the client
    @piId_Client_Type	=	new type of the client
</Parameters>
<Outputs>
	@piCode_Error		=	Code of the error
	@psMsg_Error		=	Messege or description of the error
</Outputs>
<Developer>Gustavo Perez Espinoza</Developer>
<Date>July 2017</Date>
<Requirement>GFT Test</Requirement>
<Version>1.0</Version>
<History>	
	<Change>
		<Developer></Developer>
		<Requirement></Requirement>
		<Date></Date>
		<Description></Description>
	</Change>
</History>
*****************************************************************************************************************************************************/
BEGIN
	SET NOCOUNT ON
	SET @piCode_Error	=	0;

	BEGIN TRY

		BEGIN TRANSACTION
		
			UPDATE [dbo].[Client]
			SET	   [Name] = @psName
				  ,[Email] = @psEmail
				  ,[Birth_Date] = @pdBirth_Date
				  ,[Id_Client_Type] = @piId_Client_Type
			 WHERE [Id_Client]=@piId_Client
			 			 
		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		SET @piCode_Error	= -1
		SET	@psMsg_Error	= ERROR_MESSAGE()	
		ROLLBACK TRANSACTION
	END CATCH	

END

GO
