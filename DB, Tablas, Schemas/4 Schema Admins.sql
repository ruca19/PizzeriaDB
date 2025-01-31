-- Crear Tabla para observar modificaciones
CREATE TABLE Admins.ModifTablas(
	LogID INT IDENTITY (1,1) PRIMARY KEY,
	Evento CHAR(6),
	Tabla VARCHAR(50),
	ID VARCHAR(50),
	DatosAntes NVARCHAR(200),
	DatosDespues NVARCHAR(200),
	Usuario NVARCHAR(250),
	Fecha DATETIME DEFAULT GETDATE() --Fecha del cambio que es el actual
)
