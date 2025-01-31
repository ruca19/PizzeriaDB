-- Registrar modificaciones de la Tabla orders en tabla Admins.ModifTablas
CREATE TRIGGER Tablas.TRIG_RegistrarModificacionesOrders 
ON Tablas.orders -- Asociado a la tabla Pizzas de Schema Ventas
AFTER INSERT, UPDATE, DELETE 
AS
BEGIN
    SET NOCOUNT ON; 

    -- Variables para guardar los datos
    DECLARE @Evento CHAR(6); 
    DECLARE @Usuario NVARCHAR(100); 
	DECLARE @Tabla VARCHAR(50) = 'Orders';

    -- Obtener el nombre del usuario que hizo la modificación
    SET @Usuario = SYSTEM_USER;

    -- Registrar inserciones
    IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED) -- Verifica si es un INSERT (datos en INSERTED pero no en DELETED)
    BEGIN
        SET @Evento = 'INSERT'; -- Asigna el valor 'INSERT' a la variable @Evento

        INSERT INTO Admins.ModifTablas (Evento, Tabla, ID, DatosDespues, Usuario) 
        SELECT 
            @Evento, 
			@Tabla,
            i.order_id,
            CONCAT('Fecha: ', i.date, ', Hora: ', i.time), 
            @Usuario 
        FROM INSERTED i; 
    END

    -- Registrar actualizaciones
    IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED) -- Verifica si es un UPDATE (datos en INSERTED y en DELETED)
    BEGIN
        SET @Evento = 'UPDATE'; -- Asigna el valor 'UPDATE' a la variable @Evento

        INSERT INTO Admins.ModifTablas (Evento, Tabla, ID, DatosAntes, DatosDespues, Usuario) 
        SELECT 
            @Evento, 
			@Tabla,
            d.order_id, 
            CONCAT('Fecha: ', d.date, ', Hora: ', d.time),  -- Los datos antiguos (antes del cambio)
            CONCAT('Fecha: ', i.date, ', Hora: ', i.time), -- Los datos nuevos (después del cambio)
            @Usuario 
        FROM INSERTED i 
        INNER JOIN DELETED d ON i.order_id = d.order_id; -- Une INSERTED con DELETED para obtener las filas modificadas
    END

    -- Registrar eliminaciones
    IF NOT EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED) -- Verifica si es un DELETE (datos en DELETED pero no en INSERTED)
    BEGIN
        SET @Evento = 'DELETE'; -- Asigna el valor 'DELETE' a la variable @Evento

        INSERT INTO Admins.ModifTablas (Evento, Tabla, ID, DatosAntes, Usuario) 
        SELECT 
            @Evento, 
			@Tabla,
            d.order_id, 
            CONCAT('Fecha: ', d.date, ', Hora: ', d.time), -- Los datos antiguos (antes de la eliminación)
            @Usuario 
        FROM DELETED d; 
    END
END;
