CREATE TABLE [business].[Fact_Interaction] (

	[UserId] bigint NOT NULL, 
	[PostId] bigint NOT NULL, 
	[InteractionDate] date NULL, 
	[Score] int NULL, 
	[CreateDate] datetime2(6) NULL
);