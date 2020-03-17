/*
������:

� ���� ������ MS SQL Server ���� ������ � ����.
����� ������ ����� ��������������� ����� �����, � ���� � ����� ������.
�������� SQL ������ ��� ������ ���� ��� ����� ������ � ���.
���� � ������ ��� �����, �� � ���� �� ����� ������ ����������.
*/



/*
�������:

Articles - ������
	����, ������ ��� ���������� ������:
		ArticleId bigint
		Name nvarchar(255)
	��� ��������:
		CREATE TABLE Articles (
			ArticleId bigint IDENTITY(1,1) NOT NULL,
			[Name] [nvarchar](255) NOT NULL,
			CONSTRAINT [PK_Articles] PRIMARY KEY NONCLUSTERED (ArticleId ASC)
		)
	���������� �������:
		set IDENTITY_INSERT Articles ON
		insert into Articles (ArticleId, Name)
			values	(1, '������ 1'),
					(2, '������ 2'),
					(3, '������ 3'),
					(4, '������ 4')
		set IDENTITY_INSERT Articles OFF

Tags - ����
	����, ������ ��� ���������� ������:
		TagId bigint
		Text nvarchar(255)
	��� ��������:
		CREATE TABLE Tags (
			TagId bigint IDENTITY(1,1) NOT NULL,
			[Text] [nvarchar](255) NOT NULL,
			CONSTRAINT [PK_Tags] PRIMARY KEY NONCLUSTERED (TagId ASC)
		)
	���������� �������:
		set IDENTITY_INSERT Tags ON
		insert into Tags (TagId, Text)
			values	(1, '��� 1'),
					(2, '��� 2'),
					(3, '��� 3'),
					(4, '��� 4')
		set IDENTITY_INSERT Articles OFF

ArticleTags - �������-������ ����� �������� � ������
	����, ������ ��� ���������� ������:
		ArticleId bigint
		TagId bigint
	��� ��������:
		CREATE TABLE ArticleTags (
			ArticleId bigint NOT NULL,
			TagId bigint NOT NULL,
			CONSTRAINT [PK_ArticleTags] PRIMARY KEY NONCLUSTERED (ArticleId ASC, TagId ASC)
		)
		GO
		ALTER TABLE ArticleTags WITH CHECK ADD FOREIGN KEY(ArticleId) REFERENCES Articles (ArticleId)
		GO
		ALTER TABLE ArticleTags WITH CHECK ADD FOREIGN KEY(TagId) REFERENCES Tags (TagId)
		GO
	���������� �������:
		insert into ArticleTags (ArticleId, TagId)
			values	
				(1, 1), (1, 2),		-- � ������ 1 - ���� 1, 2
				(2, 2), (2, 3),		-- � ������ 2 - ���� 2, 3
				(3, 4)				-- � ������ 3 - ��� 4
									-- � ������ 4 - ����� ���


������� ���� ������:
	delete from ArticleTags
	delete from Tags
	delete from Articles

�������� ���� ������:
	drop TABLE ArticleTags
	drop TABLE Tags
	drop TABLE Articles


*/


-- ������� ���� ��� "���� ������-���".
-- ���� � ������ ��� ����� - ���� ���-����� ������ ����������.
select ar.Name as ArticleName, t.Text as TagText
from Articles ar
left join ArticleTags art on ar.ArticleId = art.ArticleId
left join Tags t on art.TagId = t.TagId
