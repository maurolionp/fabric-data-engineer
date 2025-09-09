[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "raw comments_DataDestination", IsNewTarget = false], Settings = [Kind = "Manual", AllowCreation = false, ColumnSettings = [Mappings = {[SourceColumnName = "UserId", DestinationColumnName = "UserId"], [SourceColumnName = "PostId", DestinationColumnName = "PostId"], [SourceColumnName = "Date", DestinationColumnName = "InteractionDate"], [SourceColumnName = "Score", DestinationColumnName = "Score"], [SourceColumnName = "CreationDate", DestinationColumnName = "CreateDate"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"raw comments" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "102f0b15-25a9-45c2-aad6-e471d6c9a096"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "eb84d8bc-fba6-4586-946d-516e8da9b809"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "raw.comments", ItemKind = "Table"]}[Data],
  #"Changed column type with locale" = Table.TransformColumnTypes(#"Navigation 3", {{"Score", Int64.Type}, {"PostId", Int64.Type}, {"UserId", Int64.Type}, {"Id", Int64.Type}}),
  #"Changed column type with locale 1" = Table.TransformColumnTypes(#"Changed column type with locale", {{"CreationDate", type datetime}}),
  #"Inserted date" = Table.AddColumn(#"Changed column type with locale 1", "Date", each DateTime.Date([CreationDate]), type nullable date),
  #"Filtered rows" = Table.SelectRows(#"Inserted date", each [UserId] <> null),
  #"Filtered rows 1" = Table.SelectRows(#"Filtered rows", each [PostId] <> null)
in
  #"Filtered rows 1";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "raw posts_DataDestination", IsNewTarget = false], Settings = [Kind = "Manual", AllowCreation = false, ColumnSettings = [Mappings = {[SourceColumnName = "Id", DestinationColumnName = "Id"], [SourceColumnName = "OwnerUserId", DestinationColumnName = "UserId"], [SourceColumnName = "AnswerCount", DestinationColumnName = "AnswerCount"], [SourceColumnName = "CommentCount", DestinationColumnName = "CommentCount"], [SourceColumnName = "FavoriteCount", DestinationColumnName = "FavoriteCount"], [SourceColumnName = "Type", DestinationColumnName = "Type"], [SourceColumnName = "ViewCount", DestinationColumnName = "ViewCount"], [SourceColumnName = "Score", DestinationColumnName = "Score"], [SourceColumnName = "CreationDate", DestinationColumnName = "CreationDate"], [SourceColumnName = "ClosedDate", DestinationColumnName = "ClosedDate"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"raw posts" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "102f0b15-25a9-45c2-aad6-e471d6c9a096"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "eb84d8bc-fba6-4586-946d-516e8da9b809"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "raw.posts", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 3", {"AcceptedAnswerId", "CommunityOwnedDate", "LastActivityDate", "LastEditDate", "LastEditorUserId", "ParentId", "Tags"}),
  #"Changed column type with locale" = Table.TransformColumnTypes(#"Removed columns", {{"ViewCount", Int64.Type}, {"Score", Int64.Type}, {"PostTypeId", Int64.Type}, {"OwnerUserId", Int64.Type}, {"FavoriteCount", Int64.Type}, {"CommentCount", Int64.Type}, {"AnswerCount", Int64.Type}, {"Id", Int64.Type}}),
  #"Changed column type with locale 1" = Table.TransformColumnTypes(#"Changed column type with locale", {{"CreationDate", type datetime}, {"ClosedDate", type datetime}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type with locale 1", {"PostTypeId"}, #"raw posttypes", {"Id"}, "raw posttypes", JoinKind.LeftOuter),
  #"Expanded raw posttypes" = Table.ExpandTableColumn(#"Merged queries", "raw posttypes", {"Type"}, {"Type"}),
  #"Filtered rows" = Table.SelectRows(#"Expanded raw posttypes", each [Id] <> null)
in
  #"Filtered rows";
shared #"raw posttypes" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "102f0b15-25a9-45c2-aad6-e471d6c9a096"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "eb84d8bc-fba6-4586-946d-516e8da9b809"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "raw.posttypes", ItemKind = "Table"]}[Data]
in
  #"Navigation 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "raw users_DataDestination", IsNewTarget = false], Settings = [Kind = "Manual", AllowCreation = false, ColumnSettings = [Mappings = {[SourceColumnName = "Id", DestinationColumnName = "Id"], [SourceColumnName = "DownVotes", DestinationColumnName = "DownVotes"], [SourceColumnName = "UpVotes", DestinationColumnName = "UpVotes"], [SourceColumnName = "Views", DestinationColumnName = "ViewCount"], [SourceColumnName = "Reputation", DestinationColumnName = "ReputationScore"], [SourceColumnName = "Email", DestinationColumnName = "Email"], [SourceColumnName = "CreationDate", DestinationColumnName = "CreationDate"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"raw users" = let
  Source = Lakehouse.Contents([]),
  #"Navigation 1" = Source{[workspaceId = "102f0b15-25a9-45c2-aad6-e471d6c9a096"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "eb84d8bc-fba6-4586-946d-516e8da9b809"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "raw.users", ItemKind = "Table"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 3", {"LastAccessDate", "AccountId"}),
  #"Filtered rows" = Table.SelectRows(#"Removed columns", each [Id] <> null)
in
  #"Filtered rows";
shared #"raw users_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "102f0b15-25a9-45c2-aad6-e471d6c9a096"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "ae275ebc-5f9d-4f2c-ac99-cb8abcfac17f"]}[Data],
  TableNavigation = Navigation_2{[Schema = "business", Item = "Dim_User"]}[Data]
in
  TableNavigation;
shared #"raw posts_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "102f0b15-25a9-45c2-aad6-e471d6c9a096"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "ae275ebc-5f9d-4f2c-ac99-cb8abcfac17f"]}[Data],
  TableNavigation = Navigation_2{[Schema = "business", Item = "Dim_Posts"]}[Data]
in
  TableNavigation;
shared #"raw comments_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "102f0b15-25a9-45c2-aad6-e471d6c9a096"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "ae275ebc-5f9d-4f2c-ac99-cb8abcfac17f"]}[Data],
  TableNavigation = Navigation_2{[Schema = "business", Item = "Fact_Interaction"]}[Data]
in
  TableNavigation;
