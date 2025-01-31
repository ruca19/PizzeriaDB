-- Total Ingresos entre 2 fechas
CREATE FUNCTION Tablas.TotalIngresos(
	@fecha_inicio DATE, 
	@fecha_fin DATE
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @total DECIMAL(10, 1);
    SELECT @total = SUM(od.quantity * p.price)
    FROM Tablas.order_details od
    JOIN Tablas.orders o ON od.order_id = o.order_id
    JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id
    WHERE o.date BETWEEN @fecha_inicio AND @fecha_fin;
    RETURN @total;
END;
--------------------------------------------------------------------------------------------------------------------

-- Comprobar disponibilidad de una pizza en el sistema
CREATE FUNCTION Tablas.PizzaActiva(
	@pizza_id VARCHAR(50)
)
RETURNS BIT
AS
BEGIN
    DECLARE @activo BIT;
    SELECT @activo = activo
    FROM Tablas.pizzas
    WHERE pizza_id = @pizza_id;
    RETURN @activo;
END;

------------------------------------------------------------------------------------------------------------------

-- Top 2 Pizzas con Menos ventas en un periodo seleccionado
CREATE FUNCTION Tablas.PizzasMenosVentas(
	@fecha_inicio DATE,
	@fecha_fin DATE
)
RETURNS TABLE
AS
RETURN

	SELECT TOP(2) SUM(od.quantity * p.price) as Ingresos, p.pizza_id as NombrePizza
	FROM Tablas.order_details od
	JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id
	JOIN Tablas.orders o ON od.order_id = o.order_id
	WHERE o.date BETWEEN @fecha_inicio AND @fecha_fin
	GROUP BY p.pizza_id
	ORDER BY Ingresos ASC

------------------------------------------------------------------------------------------------------------------

-- Top 2 Pizzas con Mas ventas en un periodo seleccionado
CREATE FUNCTION Tablas.PizzasMasVentas(
	@fecha_inicio DATE,
	@fecha_fin DATE
)
RETURNS TABLE
AS
RETURN

	SELECT TOP(2) SUM(od.quantity * p.price) as Ingresos, p.pizza_id as NombrePizza
	FROM Tablas.order_details od
	JOIN Tablas.pizzas p ON od.pizza_id = p.pizza_id
	JOIN Tablas.orders o ON od.order_id = o.order_id
	WHERE o.date BETWEEN @fecha_inicio AND @fecha_fin
	GROUP BY p.pizza_id
	ORDER BY Ingresos DESC

------------------------------------------------------------------------------------------------------------------

-- Funciones Escalares
SELECT Tablas.TotalIngresos('2025-01-01', '2025-01-31');
SELECT Tablas.PizzaActiva('bbq_ckn_l');

-- Funciones Tabla
SELECT * FROM Tablas.PizzasMenosVentas('2015-01-01', '2015-01-31');
SELECT * FROM Tablas.PizzasMasVentas('2015-01-01', '2015-01-31');

select * from Tablas.pizzas
select * from Tablas.orders
select * from Tablas.order_details
select * from Tablas.pizza_types