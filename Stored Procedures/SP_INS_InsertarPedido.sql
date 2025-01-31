-- Insertar pedido en tablas orders y order_details
CREATE PROCEDURE Tablas.INS_PedidoPizza
    @pizza_id VARCHAR(50),
    @quantity INT
AS
SET NOCOUNT ON
BEGIN
    -- Declaramos variables para capturar la fecha y hora actuales y el ID del pedido
    DECLARE @order_id INT;
    DECLARE @current_date DATE = CAST(GETDATE() AS DATE);
    DECLARE @current_time TIME = CAST(GETDATE() AS TIME);

    -- Verificamos si la pizza está activa
    IF NOT EXISTS (SELECT 1 FROM Tablas.pizzas WHERE pizza_id = @pizza_id AND activo = 1)
    BEGIN
        PRINT 'No se puede realizar el pedido, la pizza no está en el Menú.';
        RETURN;  -- Si la pizza no está activa, salimos del procedimiento sin hacer nada
    END

    BEGIN TRANSACTION;
    BEGIN TRY
        -- 1. Insertamos un nuevo registro en la tabla orders con la fecha y hora actuales
        INSERT INTO Tablas.orders (date, time)
        VALUES (@current_date, @current_time);

        -- 2. Obtenemos el order_id recién generado
        SET @order_id = SCOPE_IDENTITY();

        -- 3. Insertamos los detalles del pedido en la tabla order_details
        INSERT INTO Tablas.order_details (order_id, pizza_id, quantity)
        VALUES (@order_id, @pizza_id, @quantity);

        -- Confirmamos la transacción
        COMMIT TRANSACTION;
        PRINT 'Pedido insertado exitosamente.';
    END TRY
    BEGIN CATCH
        -- Si ocurre un error en TRY, revertimos la transacción
        ROLLBACK TRANSACTION;
        PRINT 'Error al insertar el pedido: ' + ERROR_MESSAGE();
    END CATCH
END;


EXEC Tablas.INS_PedidoPizza @pizza_id = 'marg_l', @quantity = 1;  
EXEC Tablas.INS_PedidoPizza @pizza_id = 'bbq_ckn_s', @quantity = 2; 
EXEC Tablas.INS_PedidoPizza @pizza_id = 'ital_supr_m', @quantity = 1; 

select * from Tablas.pizzas
select * from Tablas.orders
select * from Tablas.order_details
select * from Tablas.pizza_types
