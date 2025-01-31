-- No se permite insertar o modificar un precio negativo en tabla Pizzas
CREATE TRIGGER Tablas.TRIG_PreciosPizzas
ON Tablas.Pizzas
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si algún precio es negativo en las filas afectadas
    IF EXISTS (
        SELECT 1
        FROM INSERTED
        WHERE price < 0
    )
    BEGIN
        -- Si se encuentran precios negativos, se revierte la transacción
        RAISERROR ('No se permiten precios negativos.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


select * from Tablas.pizzas
select * from Tablas.orders
select * from Tablas.order_details
select * from Tablas.pizza_types

select * from Admins.ModifTablas
update Tablas.pizzas set price = 12.75 where pizza_id = 'bbq_ckn_s'