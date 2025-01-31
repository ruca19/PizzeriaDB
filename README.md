# Sistema de Gestión de Base de Datos para Pizzería 🍕  

Este proyecto implementa una base de datos relacional para una pizzería, diseñada en SQL Server, que permite gestionar pedidos, ventas, y el menú de pizzas. Estructurado con roles, usuarios, y auditoría.  

## Características del proyecto🚀  
- **Esquemas organizados**:  
  - `Tablas`: Tablas principales de datos y lógica de negocio.  
  - `Admins`: Auditoría y elementos accesibles solo para administradores.  
- **Tablas Relacionales**:  
  - `orders`, `order_details`, `pizzas`, `pizza_types`.  
- **Elementos avanzados**:  
  - **Funciones**: Consultas útiles para ingresos, disponibilidad, y análisis de ventas.  
	- Tablas.TotalIngresos
    		– Ingresos entre 2 fechas
	- Tablas.PizzaActiva
  		-  Comprobar disponibilidad pizza
	- Tablas.PizzasMenosVentas
		- Top 2 Pizzas con menos ventas en un periodo
	- Tablas.PizzasMasVentas
  		-  Top 2 Pizzas con mas ventas en un periodo
  - **Vistas**: Resúmenes de ventas y stock de pizzas.  
	- Tablas.VentasUltimaSemana
  		- Ventas Ultimos 7 Dias
	- Tablas.VentasDiaPorPizza
  		- Ver Venta Diaria por pizzas
	- Tablas.VentasDiaTotales
  		- Ver totales y cantidades de ventas
	- Tablas.StockPizzas
  		- Ver Disponibilidad o stock disponible
  - **Triggers**: Auditoría de modificaciones y validaciones.  
	- Tablas.TRIG_RegistrarModificacionesOrder_Details			
		- Registrar modificaciones de la Tabla order_details en tabla Admins.ModifTablas
	- Tablas.TRIG_RegistrarModificacionesOrders					
		- Registrar modificaciones de la Tabla orders en tabla Admins.ModifTablas
	- Tablas.TRIG_RegistrarModificacionesPizza_Types				
		- Registrar modificaciones de la Tabla pizza_types en tabla Admins.ModifTablas
	- Tablas.TRIG_RegistrarModificacionesPizzas					
		- Registrar modificaciones de la Tabla pizzas en tabla Admins.ModifTablas
	- Tablas.TRIG_Ordenes											
		- Revertir pedido si se ingresa una cantidad menor a 1 en tabla order_details
	- Tablas.TRIG_PreciosPizzas									
		- No se permite insertar o modificar un precio negativo en tabla Pizzas
  - **Procedimientos Almacenados (SP)**: Automatización de operaciones comunes (pedidos, precios, etc.).  
	- Tablas.DEL_EliminarPedido									
		- Eliminar un pedido si cliente ya no quiere de tablas orders y order_details
	- Tablas.INS_PedidoPizza										
		- Insertar pedido en tablas orders y order_details
	- Tablas.INS_NuevaPizza										
		- Añadir un nuevo tipo de pizza en tablas pizzas y pizza_types
	- Tablas.UPD_CambiarPrecio									
		- Modificar precio de una pizza existente en tabla pizzas
	- Tablas.UPD_DisponibilidadPizza								
		- Cambiar disponibilidad de la pizza en el menu
	- Tablas.UPD_ModificarPedido									
		- Modificar un pedido existente solo si esta en el menu 
- **Roles y Permisos**:  
   	- Login
		- Jefe o Admin
		- Encargado
		- Empleado
	- Usuario
		- JefeEmpresa, Socio...
		- Encargado1, Encargado2....
		- Empleado1, Empleado2....
	- Roles
		- Jefe: Acceso a ambos Schemas, asi podrá monitorear ventas de cada empleado y posibles modificaciones o eliminaciones de pedidos. Tiene poder sobre todo
		- Encargado: Acceso a Schema Tablas. Ademas de lo que puede hacer un empleado, podrá modificar o eliminar un pedido existente, modificar precio y disponibilidad de una pizza y usar las funciones y vistas. Lo que no puede hacer es modificar las tablas, sp, triggers, funciones... que hayan en el SCHEMA Tablas
		- Empleado: Acceso a Schema Tablas. Solo podrá insertar pedido, ver ventas diarias, ver pizzas disponibles en el menú.  


## Licencia 📝  
Este proyecto está bajo la Licencia MIT.  

## Agradecimientos
- [Kaggle Pizza Place Sales](https://www.kaggle.com/datasets/mysarahmadbhat/pizza-place-sales/data)

## Aclaración
 Este proyecto es un ejercicio educativo creado con fines de aprendizaje y exploración. Su objetivo es practicar y demostrar conceptos específicos del Analisis de Datos aprendidos por mi. No está destinado a ser una solución definitiva o una práctica recomendada.
