-- Registrar Inicios de Sesion para ver si empleados han ido a trabajar
CREATE PROCEDURE Admins.INS_FichajeUsuario
    @Usuario NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si el usuario existe
    IF EXISTS (SELECT 1 FROM Admins.LoginUsuarios WHERE Usuario = @Usuario)
    BEGIN
        -- Registrar el inicio de sesión si el usuario existe
        INSERT INTO Admins.LoginUsuarios (Usuario)
        VALUES (@Usuario);

        PRINT 'Inicio de sesión registrado exitosamente.';
    END
    ELSE
    BEGIN
        PRINT 'El usuario no existe. No se puede registrar el inicio de sesión.';
    END
END;

