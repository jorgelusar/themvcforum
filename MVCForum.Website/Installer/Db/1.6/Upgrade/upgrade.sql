-- Alter the category
ALTER TABLE [Category]
	Add [Colour] nvarchar(50) NULL, [Image] nvarchar(200) NULL
GO

-- Update the Permission table
ALTER TABLE [Permission]
	Add [IsGlobal] bit NULL
GO

-- Set all the isglobals to false
UPDATE [Permission]
SET [IsGlobal] = 0
GO

-- Drop the PrivateMessage Subject column
ALTER TABLE [PrivateMessage]
DROP COLUMN [Subject]

-- Make sure is global is set to NOT NULL
ALTER TABLE [Permission]
	ALTER COLUMN [IsGlobal] bit NOT NULL
GO

-- Add the new global permission Edit Members
INSERT INTO [Permission] (Id, Name, IsGlobal)
VALUES (NEWID(),'Edit Members', 1);
GO

-- Alter the post content field
ALTER TABLE [Post] 
	ALTER COLUMN [PostContent] [nvarchar](max) NOT NULL
GO

-- Create the new favourite table
CREATE TABLE [dbo].[Favourite](
	[Id] [uniqueidentifier] NOT NULL,
	[MemberId] [uniqueidentifier] NOT NULL,
	[PostId] [uniqueidentifier] NOT NULL,
	[TopicId] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Favourite] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
GO

-- Create the global permission for role table
CREATE TABLE [dbo].[GlobalPermissionForRole](
	[Id] [uniqueidentifier] NOT NULL,
	[Permission_Id] [uniqueidentifier] NOT NULL,
	[MembershipRole_Id] [uniqueidentifier] NOT NULL,
	[IsTicked] [bit] NOT NULL,
 CONSTRAINT [PK_GlobalPermissionForRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
GO

-- Update the Banned word table
ALTER TABLE [BannedWord]
	Add [IsStopWord] bit NULL
GO

-- Create Email table
CREATE TABLE [dbo].[Email](
	[Id] [uniqueidentifier] NOT NULL,
	[EmailTo] [nvarchar](100) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Subject] [nvarchar](200) NOT NULL,
	[NameTo] [nvarchar](100) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
GO

--Add an IsMultipleChoice column to the Poll table
ALTER TABLE [dbo].[Poll]
ADD [IsMultipleChoice] bit NOT NULL
GO

--Update all existing polls to not be multiple choice
UPDATE [dbo].[Poll] 
SET [IsMultipleChoice] = 0
GO
