-- Revertir pedido si se ingresa una cantidad menor a 1 en tabla order_details
CREATE TRIGGER Tablas.TRIG_Ordenes
ON Tablas.order_details
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si alguna cantidad es menor a 1
    IF EXISTS (
        SELECT 1
        FROM INSERTED
        WHERE quantity < 1
    )
    BEGIN
        -- Si se encuentran cantidades menores a 1, se revierte la transacción
        RAISERROR ('No se permiten cantidad menor a 1.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;