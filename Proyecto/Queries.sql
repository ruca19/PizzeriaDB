-- Pizzas con mas ventas
SELECT TOP(2) SUM(od.quantity * p.price) as Ingresos, p.pizza_id as NombrePizza
FROM Tablas.order_details od
JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id
JOIN Tablas.orders o ON od.order_id = o.order_id
WHERE o.date BETWEEN '2015-12-01' AND '2015-12-31'
GROUP BY p.pizza_id
ORDER BY Ingresos DESC

-- Pizzas con menos ventas
SELECT TOP(2) SUM(od.quantity * p.price) as Ingresos, p.pizza_id as NombrePizza
FROM Tablas.order_details od
JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id
JOIN Tablas.orders o ON od.order_id = o.order_id
WHERE o.date BETWEEN '2015-12-01' AND '2015-12-31'
GROUP BY p.pizza_id
ORDER BY Ingresos ASC

-- Que tipo y cuantas pizzas se han vendido en un dia
SELECT DISTINCT p.pizza_id as NombrePizza, SUM(od.quantity) as CantidadVendida
FROM Tablas.order_details od
JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id 
JOIN Tablas.orders o ON od.order_id = o.order_id
WHERE o.date = '2015-01-30'
GROUP BY p.pizza_id
ORDER BY CantidadVendida Desc

-- Buscar pizzas que tengan Bacon
SELECT p.pizza_id as NombrePizza, SUM(p.price) as Precio
FROM Tablas.pizzas p
JOIN Tablas.pizza_types pt ON p.pizza_type_id = pt.pizza_type_id 
WHERE pt.ingredients LIKE '%aco%'
GROUP BY p.pizza_id

-- Buscar pizzas activas Veganas y Clasicas con precio menor o igual a 12
SELECT p.pizza_id AS NombrePizza, pt.category AS Categoria, p.price AS Precio
FROM Tablas.pizzas p
JOIN Tablas.pizza_types pt ON p.pizza_type_id = pt.pizza_type_id 
WHERE pt.category IN ('Veggie', 'Classic') AND p.price <= 12 AND p.activo = 1
ORDER BY Precio ASC;

-- Pizza mas cara 
SELECT TOP 1 p.pizza_id AS NombrePizza, pt.category AS Categoria, p.price as Precio
FROM Tablas.pizzas p
JOIN Tablas.pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC


-- Pizza mas barata
SELECT TOP 1 p.pizza_id AS NombrePizza, pt.category AS Categoria, p.price as Precio
FROM Tablas.pizzas p
JOIN Tablas.pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price ASC

-- Ventas por dia semanal de diciembre 2015
SELECT 
    DATENAME(WEEKDAY, o.date) AS NombreDia,
    SUM(od.quantity) AS CantidadPizzas,
    ROUND(SUM(p.price), 0) AS TotalVentas
FROM Tablas.orders o
JOIN Tablas.order_details od ON o.order_id = od.order_id
JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id
WHERE o.date BETWEEN '2015-12-01' AND '2015-12-31'
GROUP BY DATENAME(WEEKDAY, o.date)
ORDER BY CASE 
            WHEN DATENAME(WEEKDAY, o.date) = 'Monday' THEN 1
            WHEN DATENAME(WEEKDAY, o.date) = 'Tuesday' THEN 2
            WHEN DATENAME(WEEKDAY, o.date) = 'Wednesday' THEN 3
            WHEN DATENAME(WEEKDAY, o.date) = 'Thursday' THEN 4
            WHEN DATENAME(WEEKDAY, o.date) = 'Friday' THEN 5
            WHEN DATENAME(WEEKDAY, o.date) = 'Saturday' THEN 6
            WHEN DATENAME(WEEKDAY, o.date) = 'Sunday' THEN 7
         END;



-- Tablas
select * from Tablas.pizzas
select * from Tablas.orders
select * from Tablas.order_details
select * from Tablas.pizza_types

--  Admins
select * from Admins.ModifTablas
