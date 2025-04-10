USE [ENCHERES_DB]
GO
/****** Object:  User [user_ench]    Script Date: 10/04/2025 16:57:01 ******/
CREATE USER [user_ench] FOR LOGIN [user_ench] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [user_ench]
GO
/****** Object:  Table [dbo].[ADRESSES]    Script Date: 10/04/2025 16:57:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADRESSES](
	[no_adresse] [int] IDENTITY(1,1) NOT NULL,
	[rue] [varchar](100) NOT NULL,
	[code_postal] [varchar](10) NOT NULL,
	[ville] [varchar](50) NOT NULL,
	[adresse_eni] [bit] NOT NULL,
 CONSTRAINT [adresse_pk] PRIMARY KEY CLUSTERED 
(
	[no_adresse] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARTICLES_A_VENDRE]    Script Date: 10/04/2025 16:57:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARTICLES_A_VENDRE](
	[no_article] [int] IDENTITY(1,1) NOT NULL,
	[nom_article] [varchar](30) NOT NULL,
	[description] [varchar](300) NOT NULL,
	[photo] [int] NULL,
	[date_debut_encheres] [date] NOT NULL,
	[date_fin_encheres] [date] NOT NULL,
	[statut_enchere] [int] NOT NULL,
	[prix_initial] [int] NOT NULL,
	[prix_vente] [int] NULL,
	[id_utilisateur] [varchar](30) NOT NULL,
	[no_categorie] [int] NOT NULL,
	[no_adresse_retrait] [int] NOT NULL,
 CONSTRAINT [articles_vendus_pk] PRIMARY KEY CLUSTERED 
(
	[no_article] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORIES]    Script Date: 10/04/2025 16:57:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIES](
	[no_categorie] [int] IDENTITY(1,1) NOT NULL,
	[libelle] [varchar](30) NOT NULL,
 CONSTRAINT [categorie_pk] PRIMARY KEY CLUSTERED 
(
	[no_categorie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uc_categories] UNIQUE NONCLUSTERED 
(
	[libelle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ENCHERES]    Script Date: 10/04/2025 16:57:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ENCHERES](
	[id_utilisateur] [varchar](30) NOT NULL,
	[no_article] [int] NOT NULL,
	[montant_enchere] [int] NOT NULL,
	[date_enchere] [datetime] NOT NULL,
 CONSTRAINT [enchere_pk] PRIMARY KEY CLUSTERED 
(
	[id_utilisateur] ASC,
	[no_article] ASC,
	[montant_enchere] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLES]    Script Date: 10/04/2025 16:57:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLES](
	[ROLE] [nvarchar](50) NOT NULL,
	[IS_ADMIN] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ROLE] ASC,
	[IS_ADMIN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UTILISATEURS]    Script Date: 10/04/2025 16:57:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UTILISATEURS](
	[pseudo] [varchar](30) NOT NULL,
	[nom] [varchar](40) NOT NULL,
	[prenom] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[telephone] [varchar](15) NULL,
	[mot_de_passe] [varchar](68) NOT NULL,
	[credit] [int] NOT NULL,
	[administrateur] [bit] NOT NULL,
	[no_adresse] [int] NOT NULL,
 CONSTRAINT [utilisateur_pk] PRIMARY KEY CLUSTERED 
(
	[pseudo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uc_utilisateurs] UNIQUE NONCLUSTERED 
(
	[pseudo] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ADRESSES] ADD  DEFAULT ((0)) FOR [adresse_eni]
GO
ALTER TABLE [dbo].[ARTICLES_A_VENDRE] ADD  DEFAULT ((0)) FOR [statut_enchere]
GO
ALTER TABLE [dbo].[UTILISATEURS] ADD  DEFAULT ((10)) FOR [credit]
GO
ALTER TABLE [dbo].[UTILISATEURS] ADD  DEFAULT ((0)) FOR [administrateur]
GO
ALTER TABLE [dbo].[ARTICLES_A_VENDRE]  WITH CHECK ADD  CONSTRAINT [articles_vendus_categories_fk] FOREIGN KEY([no_categorie])
REFERENCES [dbo].[CATEGORIES] ([no_categorie])
GO
ALTER TABLE [dbo].[ARTICLES_A_VENDRE] CHECK CONSTRAINT [articles_vendus_categories_fk]
GO
ALTER TABLE [dbo].[ARTICLES_A_VENDRE]  WITH CHECK ADD  CONSTRAINT [encheres_adresse_fk] FOREIGN KEY([no_adresse_retrait])
REFERENCES [dbo].[ADRESSES] ([no_adresse])
GO
ALTER TABLE [dbo].[ARTICLES_A_VENDRE] CHECK CONSTRAINT [encheres_adresse_fk]
GO
ALTER TABLE [dbo].[ARTICLES_A_VENDRE]  WITH CHECK ADD  CONSTRAINT [ventes_utilisateur_fk] FOREIGN KEY([id_utilisateur])
REFERENCES [dbo].[UTILISATEURS] ([pseudo])
GO
ALTER TABLE [dbo].[ARTICLES_A_VENDRE] CHECK CONSTRAINT [ventes_utilisateur_fk]
GO
ALTER TABLE [dbo].[ENCHERES]  WITH CHECK ADD  CONSTRAINT [encheres_articles_vendus_fk] FOREIGN KEY([no_article])
REFERENCES [dbo].[ARTICLES_A_VENDRE] ([no_article])
GO
ALTER TABLE [dbo].[ENCHERES] CHECK CONSTRAINT [encheres_articles_vendus_fk]
GO
ALTER TABLE [dbo].[ENCHERES]  WITH CHECK ADD  CONSTRAINT [encheres_utilisateurs_encherisseur_fk] FOREIGN KEY([id_utilisateur])
REFERENCES [dbo].[UTILISATEURS] ([pseudo])
GO
ALTER TABLE [dbo].[ENCHERES] CHECK CONSTRAINT [encheres_utilisateurs_encherisseur_fk]
GO
ALTER TABLE [dbo].[UTILISATEURS]  WITH CHECK ADD  CONSTRAINT [utilisateur_adresse_fk] FOREIGN KEY([no_adresse])
REFERENCES [dbo].[ADRESSES] ([no_adresse])
GO
ALTER TABLE [dbo].[UTILISATEURS] CHECK CONSTRAINT [utilisateur_adresse_fk]
GO
