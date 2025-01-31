-- Ver Ventas Semanales
CREATE VIEW Tablas.VentasUltimaSemana AS
SELECT 
    p.pizza_id AS Pizza,
    p.size AS Tamaño,
    SUM(od.quantity) AS TotalVendidas,
    ROUND(SUM(od.quantity * p.price), 2) AS Ingresos
FROM Tablas.order_details od
JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id
JOIN Tablas.orders o ON od.order_id = o.order_id
WHERE o.date >= DATEADD(DAY, -7, GETDATE())
GROUP BY p.pizza_id, p.size;

---------------------------------------------------------------------------------------------------------------------------------------

-- Ver Venta Diaria por pizzas
CREATE VIEW Tablas.VentasDiaPorPizza AS
SELECT 
    p.pizza_id AS Pizza,
    p.size AS Tamaño,
    SUM(od.quantity) AS TotalVendidas,
    ROUND(SUM(od.quantity * p.price), 2) AS Ingresos
FROM Tablas.order_details od
JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id
JOIN Tablas.orders o ON od.order_id = o.order_id
WHERE o.date = CAST(GETDATE() AS DATE) -- Filtramos por el día actual
GROUP BY p.pizza_id, p.size;

----------------------------------------------------------------------------------------------------------------------------------------

-- Ver Venta Diaria Total
CREATE VIEW Tablas.VentasDiaTotales AS
SELECT 
    SUM(od.quantity) AS TotalVendidas,
    ROUND(SUM(od.quantity * p.price), 2) AS Ingresos
FROM Tablas.order_details od
JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id
JOIN Tablas.orders o ON od.order_id = o.order_id
WHERE o.date = CAST(GETDATE() AS DATE) -- Filtramos por el día actual

----------------------------------------------------------------------------------------------------------------------------------------

-- Ver pizzas disponibles del Menu
CREATE VIEW Tablas.StockPizzas
AS 
SELECT pizza_type_id as Pizza, size as Tamaño, price as Precio
FROM Tablas.pizzas
WHERE activo = 1;

----------------------------------------------------------------------------------------------------------------------------------------



select * from Tablas.pizzas
select * from Tablas.orders
select * from Tablas.order_details
select * from Tablas.pizza_types