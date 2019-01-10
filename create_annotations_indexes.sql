-- Recreate indexes
CREATE INDEX [article_url] ON [annotations] ([article_url] ASC) WITH (DROP_EXISTING = ON);
CREATE INDEX [user_id] ON [annotations] ([user_id] ASC) WITH (DROP_EXISTING = ON);
GO
