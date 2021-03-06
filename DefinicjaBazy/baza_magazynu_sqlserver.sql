USE [master]
GO
/****** Object:  Database [magazyn]    Script Date: 15.03.2020 12:03:19 ******/
CREATE DATABASE [magazyn]
GO

USE [magazyn]
GO

CREATE LOGIN pracownik   
   WITH PASSWORD = 'Haslo1234'
GO 

/****** Object:  User [pracownik]    Script Date: 15.03.2020 12:03:19 ******/
CREATE USER [pracownik] FOR LOGIN [pracownik] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [pracownik]
GO

/****** Object:  Table [dbo].[dostawcy]    Script Date: 15.03.2020 12:03:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dostawcy](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[nazwa] [varchar](50) NOT NULL,
	[skrocona_nazwa] [varchar](20) NOT NULL,
	[adres] [varchar](100) NULL,
	[tagi] [varchar](100) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[zamawiac_automatycznie] [bit] NULL,
	[czestotliwosc] [int] NOT NULL,
	[dzien_zamowienia] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[grupy_produktow]    Script Date: 15.03.2020 12:03:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grupy_produktow](
	[id] [tinyint] IDENTITY(1,1) NOT NULL,
	[nazwa] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pozycje_magazynowe]    Script Date: 15.03.2020 12:03:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pozycje_magazynowe](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[opis] [varchar](50) NOT NULL,
	[id_dostawcy] [smallint] NOT NULL,
	[numer_katalogowy] [varchar](50) NOT NULL,
	[kod_kreskowy] [varchar](50) NULL,
	[zakladany_stan] [int] NOT NULL,
	[zamawiac_automatycznie] [bit] NOT NULL,
	[ilosc_w_opakowaniu] [tinyint] NOT NULL,
	[id_grupy_produktow] [tinyint] NOT NULL,
 CONSTRAINT [PK__pozycje___3213E83F106F07B1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pracownicy]    Script Date: 15.03.2020 12:03:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pracownicy](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[nazwisko] [varchar](30) NOT NULL,
	[imie] [varchar](30) NOT NULL,
	[status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stany_magazynowe]    Script Date: 15.03.2020 12:03:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stany_magazynowe](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_pozycji] [smallint] NOT NULL,
	[ilosc] [smallint] NOT NULL,
	[rodzaj] [tinyint] NOT NULL,
	[id_pracownika] [smallint] NOT NULL,
	[data_zamowienia] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Index [ix_pozycjemagazynowe_iddostawcy]    Script Date: 15.03.2020 12:03:19 ******/
CREATE NONCLUSTERED INDEX [ix_pozycjemagazynowe_iddostawcy] ON [dbo].[pozycje_magazynowe]
(
	[id_dostawcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ix_pozycjemagazynowe_idgrupyproduktow]    Script Date: 15.03.2020 12:03:19 ******/
CREATE NONCLUSTERED INDEX [ix_pozycjemagazynowe_idgrupyproduktow] ON [dbo].[pozycje_magazynowe]
(
	[id_grupy_produktow] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ix_stany_magazynowe_idpoz]    Script Date: 15.03.2020 12:03:19 ******/
CREATE NONCLUSTERED INDEX [ix_stany_magazynowe_idpoz] ON [dbo].[stany_magazynowe]
(
	[id_pozycji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ix_stany_magazynowe_idpoz_rodzaj_ilosc]    Script Date: 15.03.2020 12:03:19 ******/
CREATE NONCLUSTERED INDEX [ix_stany_magazynowe_idpoz_rodzaj_ilosc] ON [dbo].[stany_magazynowe]
(
	[id_pozycji] ASC,
	[rodzaj] ASC,
	[ilosc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dostawcy] ADD  DEFAULT ('#') FOR [tagi]
GO
ALTER TABLE [dbo].[dostawcy] ADD  DEFAULT ((0)) FOR [zamawiac_automatycznie]
GO
ALTER TABLE [dbo].[dostawcy] ADD  DEFAULT ((0)) FOR [czestotliwosc]
GO
ALTER TABLE [dbo].[dostawcy] ADD  DEFAULT ('-') FOR [dzien_zamowienia]
GO
ALTER TABLE [dbo].[pozycje_magazynowe] ADD  DEFAULT ((0)) FOR [zakladany_stan]
GO
ALTER TABLE [dbo].[pozycje_magazynowe] ADD  DEFAULT ((0)) FOR [zamawiac_automatycznie]
GO
ALTER TABLE [dbo].[pozycje_magazynowe] ADD  CONSTRAINT [DF__pozycje_m__ilosc__45F365D3]  DEFAULT ((1)) FOR [ilosc_w_opakowaniu]
GO
ALTER TABLE [dbo].[pracownicy] ADD  CONSTRAINT [DF__pracownic__statu__6EF57B66]  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[stany_magazynowe] ADD  CONSTRAINT [DF__stany_mag__id_pr__70DDC3D8]  DEFAULT ((1)) FOR [id_pracownika]
GO
ALTER TABLE [dbo].[stany_magazynowe] ADD  DEFAULT (getdate()) FOR [data_zamowienia]
GO
ALTER TABLE [dbo].[pozycje_magazynowe]  WITH CHECK ADD FOREIGN KEY([id_dostawcy])
REFERENCES [dbo].[dostawcy] ([id])
GO
ALTER TABLE [dbo].[pozycje_magazynowe]  WITH CHECK ADD FOREIGN KEY([id_grupy_produktow])
REFERENCES [dbo].[grupy_produktow] ([id])
GO
ALTER TABLE [dbo].[stany_magazynowe]  WITH CHECK ADD FOREIGN KEY([id_pozycji])
REFERENCES [dbo].[pozycje_magazynowe] ([id])
GO
ALTER TABLE [dbo].[stany_magazynowe]  WITH CHECK ADD FOREIGN KEY([id_pracownika])
REFERENCES [dbo].[pracownicy] ([id])
GO
USE [master]
GO
ALTER DATABASE [magazyn] SET  READ_WRITE 
GO
