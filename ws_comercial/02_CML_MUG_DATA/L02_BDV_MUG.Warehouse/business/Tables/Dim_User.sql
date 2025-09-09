CREATE TABLE [business].[Dim_User] (

	[Id] bigint NOT NULL, 
	[DownVotes] int NULL, 
	[UpVotes] int NULL, 
	[ViewCount] int NULL, 
	[ReputationScore] int NULL, 
	[Email] varchar(150) NULL, 
	[CreationDate] datetime2(6) NULL
);


GO
ALTER TABLE [business].[Dim_User] ADD CONSTRAINT PK_Dim_User primary key NONCLUSTERED ([Id]);