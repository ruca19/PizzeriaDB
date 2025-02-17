-- No se permite insertar o modificar un precio negativo en tabla Pizzas
CREATE TRIGGER Tablas.TRIG_PreciosPizzas
ON Tablas.Pizzas
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si alg�n precio es negativo en las filas afectadas
    IF EXISTS (
        SELECT 1
        FROM INSERTED
        WHERE price < 0
    )
    BEGIN
        -- Si se encuentran precios negativos, se revierte la transacci�n
        RAISERROR ('No se permiten precios negativos.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;