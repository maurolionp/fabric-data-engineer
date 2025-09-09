CREATE TABLE [business].[Dim_Posts] (

	[Id] bigint NOT NULL, 
	[UserId] bigint NOT NULL, 
	[AnswerCount] int NULL, 
	[CommentCount] int NULL, 
	[FavoriteCount] int NULL, 
	[Type] varchar(50) NULL, 
	[ViewCount] int NULL, 
	[Score] int NULL, 
	[CreationDate] datetime2(6) NULL, 
	[ClosedDate] datetime2(6) NULL
);


GO
ALTER TABLE [business].[Dim_Posts] ADD CONSTRAINT PK_Dim_Posts primary key NONCLUSTERED ([Id]);