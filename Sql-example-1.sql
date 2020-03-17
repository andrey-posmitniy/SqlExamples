/*
Задача:

В базе данных MS SQL Server есть статьи и тэги.
Одной статье может соответствовать много тэгов, а тэгу — много статей.
Напишите SQL запрос для выбора всех пар «Тема статьи – тэг».
Если у статьи нет тэгов, то её тема всё равно должна выводиться.
*/



/*
Таблицы:

Articles - статьи
	Поля, важные для выполнения задачи:
		ArticleId bigint
		Name nvarchar(255)
	Код создания:
		CREATE TABLE Articles (
			ArticleId bigint IDENTITY(1,1) NOT NULL,
			[Name] [nvarchar](255) NOT NULL,
			CONSTRAINT [PK_Articles] PRIMARY KEY NONCLUSTERED (ArticleId ASC)
		)
	Заполнение данными:
		set IDENTITY_INSERT Articles ON
		insert into Articles (ArticleId, Name)
			values	(1, 'Статья 1'),
					(2, 'Статья 2'),
					(3, 'Статья 3'),
					(4, 'Статья 4')
		set IDENTITY_INSERT Articles OFF

Tags - теги
	Поля, важные для выполнения задачи:
		TagId bigint
		Text nvarchar(255)
	Код создания:
		CREATE TABLE Tags (
			TagId bigint IDENTITY(1,1) NOT NULL,
			[Text] [nvarchar](255) NOT NULL,
			CONSTRAINT [PK_Tags] PRIMARY KEY NONCLUSTERED (TagId ASC)
		)
	Заполнение данными:
		set IDENTITY_INSERT Tags ON
		insert into Tags (TagId, Text)
			values	(1, 'Тег 1'),
					(2, 'Тег 2'),
					(3, 'Тег 3'),
					(4, 'Тег 4')
		set IDENTITY_INSERT Articles OFF

ArticleTags - таблица-связка между статьями и тегами
	Поля, важные для выполнения задачи:
		ArticleId bigint
		TagId bigint
	Код создания:
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
	Заполнение данными:
		insert into ArticleTags (ArticleId, TagId)
			values	
				(1, 1), (1, 2),		-- У статьи 1 - теги 1, 2
				(2, 2), (2, 3),		-- У статьи 2 - теги 2, 3
				(3, 4)				-- У статьи 3 - тег 4
									-- У статьи 4 - тегов нет


Очистка всех данных:
	delete from ArticleTags
	delete from Tags
	delete from Articles

Удаление всех таблиц:
	drop TABLE ArticleTags
	drop TABLE Tags
	drop TABLE Articles


*/


-- Выборка всех пар "Тема статьи-тег".
-- Если у статьи нет тегов - тема все-равно должна выводиться.
select ar.Name as ArticleName, t.Text as TagText
from Articles ar
left join ArticleTags art on ar.ArticleId = art.ArticleId
left join Tags t on art.TagId = t.TagId
