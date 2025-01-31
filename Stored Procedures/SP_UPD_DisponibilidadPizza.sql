-- Cambiar disponibilidad de la pizza en el menu
CREATE PROC Tablas.UPD_DisponibilidadPizza(
    @pizza_id VARCHAR(50),
	@activo BIT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar si el tipo de pizza existe en la tabla pizzas
    IF EXISTS(SELECT 1 FROM Tablas.pizzas WHERE pizza_id = @pizza_id)
    BEGIN
        -- Actualizar el campo pizza_id a 1(si) o 0(no) segun disponibilidad 
        UPDATE Tablas.pizzas
        SET activo = @activo  
        WHERE pizza_id = @pizza_id;
        
        PRINT 'Disponibilidad cambiada correctamente.';
    END
    ELSE
        PRINT 'No se pudo cambiar la disponibilidad de la pizza';
END;

-- Ejemplo de ejecución del procedimiento almacenado
EXEC Tablas.UPD_DisponibilidadPizza 
@pizza_id = 'bbq_ckn_l',
@activo = 0;

select * from Tablas.pizzas
select * from Tablas.orders
select * from Tablas.order_details
select * from Tablas.pizza_types

select * from Admins.ModifTablas

