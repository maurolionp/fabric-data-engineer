CREATE TABLE [business].[Dim_Date] (

	[Id] bigint NOT NULL, 
	[DateAlternativeKey] date NOT NULL, 
	[DateString] varchar(10) NULL, 
	[DateYear] varchar(4) NULL
);