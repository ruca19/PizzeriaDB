-- Modificar un pedido existente solo si esta en el menu
CREATE PROCEDURE Tablas.UPD_ModificarPedido
    @order_id INT,               
    @order_details_id INT,       
    @new_pizza_id VARCHAR(50),   
    @new_quantity INT            
AS
SET NOCOUNT ON;
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        -- 1. Verificar que el order_id y order_details_id existen y están relacionados
        IF NOT EXISTS (SELECT 1 
                       FROM Tablas.order_details 
                       WHERE order_details_id = @order_details_id AND order_id = @order_id)
        BEGIN
            PRINT 'El pedido no existe o es erróneo.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 2. Verificar que la nueva pizza está activa
        IF NOT EXISTS (SELECT 1 
                       FROM Tablas.pizzas 
                       WHERE pizza_id = @new_pizza_id AND activo = 1)
        BEGIN
            PRINT 'No se puede modificar el pedido. La nueva pizza seleccionada no está activa.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 3. Actualizar la pizza_id y la quantity en order_details
        UPDATE Tablas.order_details
        SET pizza_id = @new_pizza_id,
            quantity = @new_quantity
        WHERE order_details_id = @order_details_id;

        -- 4. Actualizar la fecha y la hora en orders
        UPDATE Tablas.orders
        SET date = CAST(GETDATE() AS DATE),
            time = CAST(GETDATE() AS TIME)
        WHERE order_id = @order_id;

        -- Confirmar la transacción
        COMMIT TRANSACTION;
        PRINT 'Pedido modificado exitosamente.';
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, revertimos la transacción
        ROLLBACK TRANSACTION;
        PRINT 'Error al modificar el pedido: ' + ERROR_MESSAGE();
    END CATCH
END;



EXEC Tablas.UPD_ModificarPedido
    @order_id = 21360,
    @order_details_id = 48630,
    @new_pizza_id = 'ital_supr_m',
    @new_quantity = 1;


select * from Tablas.pizzas
select * from Tablas.orders
select * from Tablas.order_details
select * from Tablas.pizza_types