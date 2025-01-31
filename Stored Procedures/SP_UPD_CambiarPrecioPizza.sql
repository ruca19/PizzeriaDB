-- Modificar precio de una pizza existente en tabla pizzas
CREATE PROC Tablas.UPD_CambiarPrecio(
			@pizza_id VARCHAR(50),
			@price DECIMAL(10,2)
)
AS
set nocount on
IF EXISTS(SELECT * FROM Tablas.pizzas WHERE pizza_id = @pizza_id)
BEGIN 
	UPDATE Tablas.pizzas SET price = @price WHERE pizza_id = @pizza_id
	PRINT 'Precio cambiado correctamente'
END
ELSE
	PRINT 'No se ha podido cambiar el precio'


