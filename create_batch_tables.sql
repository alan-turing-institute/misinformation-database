IF OBJECT_ID('[batch_article]', 'U') IS NULL
CREATE TABLE [batch_article]
(
	[minibatch_id] [int] NOT NULL,
	[article_url] [nvarchar](800) NULL,
);
GO

IF OBJECT_ID('[batch_info]', 'U') IS NULL
CREATE TABLE [dbo].[batch_info](
	[minibatch_id] [int] NOT NULL,
	[description] [nvarchar](max) NULL,
	[created_date] [datetimeoffset](7) DEFAULT(getdate()),
	[priority] [int] NULL,
);
GO

IF OBJECT_ID('[batch_evaluation]', 'U') IS NULL
CREATE TABLE [dbo].[batch_evaluation](
	[article_url] [nvarchar](800) NOT NULL,
	[username] [nvarchar](100) NOT NULL,
);
GO

