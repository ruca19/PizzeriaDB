-- Añadir un nuevo tipo de pizza en tablas pizzas y pizza_types
CREATE PROC Tablas.INS_NuevaPizza(
			@pizza_type_id VARCHAR(50),
			@name VARCHAR(100),
			@category VARCHAR(50),
			@ingredients VARCHAR(100),
			@price_s DECIMAL(10, 2),
			@price_m DECIMAL(10, 2),
			@price_l DECIMAL(10, 2),
			@activo BIT
)
AS
set nocount on
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Tablas.pizza_types(pizza_type_id, name, category, ingredients)
		VALUES(@pizza_type_id, @name, @category, @ingredients);

		INSERT INTO Tablas.pizzas(pizza_id, pizza_type_id, size, price, activo)
		VALUES
		(@pizza_type_id + '_s', @pizza_type_id, 'S', @price_s, @activo),
		(@pizza_type_id + '_l', @pizza_type_id, 'L', @price_l, @activo),
		(@pizza_type_id + '_m', @pizza_type_id, 'M', @price_m, @activo);

		COMMIT TRANSACTION;
		PRINT 'Nuevos tipos pizza ingresados correctamente'
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		PRINT 'No se pudo ingresar el nuevo tipo de pizza' + ERROR_MESSAGE()
	END CATCH
END


EXEC Tablas.INS_NuevaPizza 
@pizza_type_id='marg', 
@name='The Margherita Pizza', 
@category='Classic', 
@ingredients='Tomato, Mozzarella Cheese, Basil, Olive Oil', 
@price_s=10, 
@price_m=13.5, 
@price_l=16, 
@activo = 0;

