-- CREAR TABLAS
CREATE TABLE Tablas.orders(
			order_id INT PRIMARY KEY,
			date DATE NOT NULL,
			time TIME NOT NULL
);


CREATE TABLE Tablas.pizza_types(
			pizza_type_id VARCHAR(50) PRIMARY KEY,
			name VARCHAR(100) NOT NULL,
			category VARCHAR(50) NOT NULL,
			ingredients VARCHAR(100) NOT NULL

)


CREATE TABLE Tablas.pizzas(
			pizza_id VARCHAR(50) PRIMARY KEY,
			pizza_type_id VARCHAR(50) NOT NULL,
			size VARCHAR(3) NOT NULL,
			price FLOAT NOT NULL,
			FOREIGN KEY (pizza_type_id) REFERENCES Tablas.pizza_types(pizza_type_id)
)


CREATE TABLE Tablas.order_details(
			order_details_id INT PRIMARY KEY,
			order_id INT NOT NULL,
			pizza_id VARCHAR(50) NOT NULL,
			quantity INT NOT NULL,
			FOREIGN KEY (order_id) REFERENCES Tablas.orders(order_id),
			FOREIGN KEY (pizza_id) REFERENCES Tablas.pizzas(pizza_id)
);






-- INSERTAR DATOS EN TABLAS 
BULK INSERT Tablas.order_details
FROM 'C:\kaggle\pizza-sales\order_details.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2);


BULK INSERT Tablas.orders
FROM 'C:\kaggle\pizza-sales\orders.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2);


BULK INSERT Tablas.pizza_types
FROM 'C:\kaggle\pizza-sales\pizza_types.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2);


BULK INSERT Tablas.pizzas
FROM 'C:\kaggle\pizza-sales\pizzas.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2);
