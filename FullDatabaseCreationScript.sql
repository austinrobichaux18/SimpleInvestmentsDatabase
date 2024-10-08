USE [InvestmentsDatabase]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 9/10/2024 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Investments]    Script Date: 9/10/2024 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Investments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NULL,
	[ProductId] [int] NULL,
	[Amount] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Question3_GetTotalInvestmentPerClient]    Script Date: 9/10/2024 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create VIEW [dbo].[Question3_GetTotalInvestmentPerClient] 
AS
	SELECT c.Name AS Name, SUM(i.Amount) AS Total
	FROM Investments i
	JOIN Clients c ON i.ClientId = c.Id
	GROUP BY c.Name
GO
/****** Object:  Table [dbo].[Products]    Script Date: 9/10/2024 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Question4_GetTop3ProductsByInvestedAmount]    Script Date: 9/10/2024 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIEW [dbo].[Question4_GetTop3ProductsByInvestedAmount] 
AS
	SELECT TOP 3 p.Name AS ProductName, SUM(i.Amount) AS Total
	FROM Investments i
	JOIN Products p ON i.ProductId = p.Id
	GROUP BY p.Name
	ORDER BY Total DESC;
GO
ALTER TABLE [dbo].[Investments]  WITH CHECK ADD FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
GO
ALTER TABLE [dbo].[Investments]  WITH CHECK ADD FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
GO
ALTER TABLE [dbo].[Investments]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Investments]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[InitializeAndResetDatabase]    Script Date: 9/10/2024 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[InitializeAndResetDatabase]

AS

DROP Table IF EXISTS Investments;
DROP Table IF EXISTS Clients;
DROP Table IF EXISTS Products;

CREATE TABLE Clients (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);

CREATE TABLE Products (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);

-- we opt to auto increment the PK of this table (Identity(1,1)) because the PK of a many-to-many table is less important than primary tables
CREATE TABLE Investments (
	Id INT PRIMARY KEY IDENTITY(1,1),
    ClientId INT,
    ProductId INT,
    Amount DECIMAL(10, 2) NOT NULL,

    FOREIGN KEY (ClientID) REFERENCES Clients(Id),
    FOREIGN KEY (ProductID) REFERENCES Products(Id)
);

EXEC [dbo].[SeedData]
GO
/****** Object:  StoredProcedure [dbo].[Question1_GetProductNameAndClientNameByInvestmentId]    Script Date: 9/10/2024 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Question1_GetProductNameAndClientNameByInvestmentId]
    @InvestmentId INT
AS
    SELECT c.Name AS ClientName, p.Name AS ProductName
    FROM Investments i
    JOIN Clients c ON i.ClientId = c.Id
    JOIN Products p ON i.ProductId = p.Id
    WHERE i.Id = @InvestmentId;
GO
/****** Object:  StoredProcedure [dbo].[Question2_GetClientsAndProductsAboveAmount]    Script Date: 9/10/2024 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Question2_GetClientsAndProductsAboveAmount]
    @Amount DECIMAL(10, 2)
AS
BEGIN
	SELECT c.Name AS ClientName, p.Name AS ProductName
	FROM Clients c
	LEFT JOIN Investments i ON i.ClientId = c.Id AND i.Amount > @Amount
	LEFT JOIN Products p ON i.ProductId = p.Id
	ORDER BY  p.Name DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[SeedData]    Script Date: 9/10/2024 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[SeedData]

AS

INSERT INTO Clients (Id, Name) VALUES (1, 'John Doe');
INSERT INTO Clients (Id, Name) VALUES (2, 'Emily Davis');
INSERT INTO Clients (Id, Name) VALUES (3, 'Michael Brown');
INSERT INTO Clients (Id, Name) VALUES (4, 'Sarah Wilson');
INSERT INTO Clients (Id, Name) VALUES (5, 'David Miller');

INSERT INTO Products (Id, Name) VALUES (1, 'Energy Stocks');
INSERT INTO Products (Id, Name) VALUES (2, 'Healthcare Stocks');
INSERT INTO Products (Id, Name) VALUES (3, 'Consumer Goods Stocks');
INSERT INTO Products (Id, Name) VALUES (4, 'Financial Sector Stocks');
INSERT INTO Products (Id, Name) VALUES (5, 'Utilities Stocks');


INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (1, 1, 20000.00);
INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (1, 2, 15000.00);

INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (2, 3, 10000.00);
INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (2, 5, 5000.00);

INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (3, 4, 25000.00);
INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (3, 1, 10000.00);

INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (4, 2, 20000.00);

INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (5, 3, 30000.00);
INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (5, 4, 15000.00);


INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (1, 3, 5000.00); 
INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (2, 4, 12000.00);  
INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (4, 1, 10000.00); 
INSERT INTO Investments (ClientId, ProductId, Amount) VALUES (5, 2, 20000.00);
GO
