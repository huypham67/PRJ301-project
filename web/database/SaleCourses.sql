USE [master]
GO
/****** Object:  Database [SaleCourses]    Script Date: 3/8/2024 7:40:59 PM ******/
CREATE DATABASE [SaleCourses]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SaleCourses', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SaleCourses.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SaleCourses_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SaleCourses_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SaleCourses] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SaleCourses].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SaleCourses] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SaleCourses] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SaleCourses] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SaleCourses] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SaleCourses] SET ARITHABORT OFF 
GO
ALTER DATABASE [SaleCourses] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SaleCourses] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SaleCourses] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SaleCourses] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SaleCourses] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SaleCourses] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SaleCourses] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SaleCourses] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SaleCourses] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SaleCourses] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SaleCourses] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SaleCourses] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SaleCourses] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SaleCourses] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SaleCourses] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SaleCourses] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SaleCourses] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SaleCourses] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SaleCourses] SET  MULTI_USER 
GO
ALTER DATABASE [SaleCourses] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SaleCourses] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SaleCourses] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SaleCourses] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SaleCourses] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SaleCourses] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SaleCourses] SET QUERY_STORE = ON
GO
ALTER DATABASE [SaleCourses] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SaleCourses]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 3/8/2024 7:40:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 3/8/2024 7:41:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[id] [varchar](50) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[image] [varchar](50) NOT NULL,
	[description] [varchar](300) NOT NULL,
	[price] [money] NULL,
	[duration] [varchar](50) NOT NULL,
	[cid] [int] NULL,
	[publicDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/8/2024 7:41:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[courseId] [varchar](50) NOT NULL,
	[transactionId] [varchar](50) NOT NULL,
	[quantity] [int] NULL,
	[totalPrice] [money] NULL,
 CONSTRAINT [PK_OrdersId] PRIMARY KEY CLUSTERED 
(
	[courseId] ASC,
	[transactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 3/8/2024 7:41:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[id] [varchar](50) NOT NULL,
	[userid] [int] NULL,
	[date] [datetime] NULL,
	[totalPrice] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/8/2024 7:41:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[role] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([id], [name]) VALUES (1, N'Web Development')
INSERT [dbo].[Categories] ([id], [name]) VALUES (2, N'Data Science')
INSERT [dbo].[Categories] ([id], [name]) VALUES (3, N'Mobile App Development')
INSERT [dbo].[Categories] ([id], [name]) VALUES (4, N'Machine Learning')
INSERT [dbo].[Categories] ([id], [name]) VALUES (5, N'Game Development')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'DS101', N'Introduction to Data Analysis', N'images/5.png', N'Get started with data analysis using Python and Pandas library.', 69.9900, N'8 weeks', 2, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'DS104', N'SQL for Data Science', N'images/6.png', N'Learn SQL basics and advanced queries for data manipulation and analysis.', 59.9900, N'6 weeks', 2, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'DS105', N'Introduction to Statistics', N'images/7.png', N'Gain a solid understanding of statistical concepts for data analysis.', 39.9900, N'4 weeks', 2, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'MD101', N'iOS App Development with Swift', N'images/8.png', N'Build iOS apps from scratch using Swift programming language and Xcode.', 89.9900, N'12 weeks', 3, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'MD102', N'Android App Development with Kotlin', N'images/9.png', N'Learn Android app development using Kotlin programming language and Android Studio.', 79.9900, N'10 weeks', 3, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'MD103', N'Cross-platform App Development', N'images/10.png', N'Develop apps that run on both iOS and Android platforms using frameworks like Flutter or React Native.', 99.9900, N'12 weeks', 3, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'ML101', N'Introduction to Machine Learning', N'images/11.png', N'Get an overview of machine learning concepts, algorithms, and applications.', 79.9900, N'10 weeks', 4, CAST(N'2024-03-08T16:57:52.110' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'ML102', N'Deep Learning Fundamentals', N'images/12.png', N'Learn the fundamentals of deep learning and neural networks.', 89.9900, N'12 weeks', 4, CAST(N'2024-03-08T16:57:52.110' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'WD101', N'HTML & CSS Fundamentals', N'images/1.png', N'Learn the basics of HTML and CSS for web development.', 39.9900, N'4 weeks', 1, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'WD102', N'JavaScript Basics', N'images/2.png', N'Get started with JavaScript and learn the basics of web development.', 49.9900, N'6 weeks', 1, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'WD103', N'Full Stack Web Development', N'images/3.png', N'Become proficient in both front-end and back-end web development.', 99.9900, N'12 weeks', 1, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
INSERT [dbo].[Courses] ([id], [name], [image], [description], [price], [duration], [cid], [publicDate]) VALUES (N'WD104', N'Responsive Web Design', N'images/4.png', N'Learn how to create responsive websites using HTML, CSS, and Bootstrap.', 59.9900, N'8 weeks', 1, CAST(N'2024-03-03T01:06:00.510' AS DateTime))
GO
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS101', N'TRAN426349838', 1, 69.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS101', N'TRAN508778438', 1, 69.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS101', N'TRAN535775398', 1, 69.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS101', N'TRAN662620064', 1, 69.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS101', N'TRAN762973510', 1, 69.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS101', N'TRAN789418856', 1, 69.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS104', N'TRAN322341010', 1, 59.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS104', N'TRAN587014023', 1, 59.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS104', N'TRAN958521639', 5, 299.9500)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'DS105', N'TRAN575046387', 1, 39.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'MD101', N'TRAN064859568', 2, 179.9800)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'MD101', N'TRAN326919801', 2, 179.9800)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'MD101', N'TRAN615914618', 1, 89.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'MD101', N'TRAN699145549', 1, 89.9900)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'WD101', N'TRAN119549002', 6, 239.9400)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'WD101', N'TRAN479444981', 6, 239.9400)
INSERT [dbo].[Orders] ([courseId], [transactionId], [quantity], [totalPrice]) VALUES (N'WD102', N'TRAN300320826', 1, 49.9900)
GO
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN064859568', 1, CAST(N'2024-08-03T10:49:33.000' AS DateTime), 179.9800)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN119549002', 1, CAST(N'2024-08-03T10:13:21.000' AS DateTime), 239.9400)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN300320826', 1, CAST(N'2024-08-03T11:20:35.000' AS DateTime), 49.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN322341010', 1, CAST(N'2024-08-03T09:49:27.000' AS DateTime), 59.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN326919801', 1, CAST(N'2024-08-03T11:20:35.000' AS DateTime), 179.9800)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN426349838', 1, CAST(N'2024-08-03T16:27:06.000' AS DateTime), 69.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN479444981', 1, CAST(N'2024-08-03T09:49:34.000' AS DateTime), 239.9400)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN508778438', 1, CAST(N'2024-08-03T11:22:39.000' AS DateTime), 69.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN535775398', 1, CAST(N'2024-08-03T10:31:04.000' AS DateTime), 69.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN575046387', 1, CAST(N'2024-08-03T11:22:39.000' AS DateTime), 39.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN587014023', 1, CAST(N'2024-08-03T16:45:49.000' AS DateTime), 59.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN615914618', 1, CAST(N'2024-08-03T10:23:50.000' AS DateTime), 89.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN662620064', 1, CAST(N'2024-08-03T11:23:22.000' AS DateTime), 69.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN699145549', 1, CAST(N'2024-08-03T10:24:03.000' AS DateTime), 89.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN762973510', 1, CAST(N'2024-08-03T10:53:47.000' AS DateTime), 69.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN789418856', 1, CAST(N'2024-08-03T09:49:19.000' AS DateTime), 69.9900)
INSERT [dbo].[Transactions] ([id], [userid], [date], [totalPrice]) VALUES (N'TRAN958521639', 1, CAST(N'2024-08-03T11:22:39.000' AS DateTime), 299.9500)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [username], [password], [role]) VALUES (1, N'huy', N'123', 1)
INSERT [dbo].[Users] ([id], [username], [password], [role]) VALUES (4, N'pdnh', N'123', 1)
INSERT [dbo].[Users] ([id], [username], [password], [role]) VALUES (5, N'pdnha', N'123', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_CategoryID] FOREIGN KEY([cid])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_CategoryID]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_CourseId] FOREIGN KEY([courseId])
REFERENCES [dbo].[Courses] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_CourseId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_TransactionId] FOREIGN KEY([transactionId])
REFERENCES [dbo].[Transactions] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_TransactionId]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_id] FOREIGN KEY([userid])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_id]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [CK_Price] CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [CK_Price]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK_Quantity] CHECK  (([quantity]>=(0)))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK_Quantity]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK_TotalPrice] CHECK  (([totalPrice]>=(0)))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK_TotalPrice]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [CK_TransactionTotalPrice] CHECK  (([totalPrice]>=(0)))
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [CK_TransactionTotalPrice]
GO
USE [master]
GO
ALTER DATABASE [SaleCourses] SET  READ_WRITE 
GO
