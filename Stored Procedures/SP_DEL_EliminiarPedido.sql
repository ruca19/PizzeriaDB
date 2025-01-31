-- Eliminar un pedido si cliente ya no quiere de tablas orders y order_details
CREATE PROCEDURE Tablas.DEL_EliminarPedido
    @order_id INT,               -- ID del pedido
    @order_details_id INT        -- ID del detalle del pedido
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;
    BEGIN TRY
        -- 1. Verificar que el order_id y order_details_id existen y están relacionados
        IF NOT EXISTS (SELECT 1 
                       FROM Tablas.order_details 
                       WHERE order_details_id = @order_details_id AND order_id = @order_id)
        BEGIN
            -- Si no existe, imprimir un mensaje y salir
            PRINT 'El pedido no existe o es erróneo.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- 2. Eliminar datos de la tabla order_details
        DELETE FROM Tablas.order_details
        WHERE order_details_id = @order_details_id
          AND order_id = @order_id;

        -- 3. Verificar si quedan detalles del pedido
        IF NOT EXISTS (SELECT 1 
                       FROM Tablas.order_details 
                       WHERE order_id = @order_id)
        BEGIN
            -- Si no hay más detalles, eliminar el pedido en la tabla orders
            DELETE FROM Tablas.orders
            WHERE order_id = @order_id;
        END

        -- Confirmar la transacción
        COMMIT TRANSACTION;
        PRINT 'Pedido eliminado exitosamente.';
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, revertimos la transacción
        ROLLBACK TRANSACTION;
        PRINT 'Error al eliminar el pedido: ' + ERROR_MESSAGE();
    END CATCH
END;



select * from Tablas.pizzas
select * from Tablas.orders
select * from Tablas.order_details
select * from Tablas.pizza_types