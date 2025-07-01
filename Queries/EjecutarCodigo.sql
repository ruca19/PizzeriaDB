/*
Nombres de funciones:
	Tablas.TotalIngresos			– Ingresos entre 2 fechas
	Tablas.PizzaActiva				– Comprobar disponibilidad pizza
	Tablas.PizzasMenosVentas		– Top 2 Pizzas con menos ventas en un periodo
	Tablas.PizzasMasVentas			– Top 2 Pizzas con mas ventas en un periodo
Nombre de Vistas:
	Tablas.VentasUltimaSemana		– Ventas Ultimos 7 Dias
	Tablas.VentasDiaPorPizza        – Ver Venta Diaria por pizzas
	Tablas.VentasDiaTotales         – Ver totales y cantidades de ventas
	Tablas.StockPizzas				– Ver Disponibilidad o stock disponible
Nombre de Triggers:
	Tablas.TRIG_RegistrarModificacionesOrder_Details			-- Registrar modificaciones de la Tabla order_details en tabla Admins.ModifTablas
	Tablas.TRIG_RegistrarModificacionesOrders					-- Registrar modificaciones de la Tabla orders en tabla Admins.ModifTablas
	Tablas.TRIG_RegistrarModificacionesPizza_Types				-- Registrar modificaciones de la Tabla pizza_types en tabla Admins.ModifTablas
	Tablas.TRIG_RegistrarModificacionesPizzas					-- Registrar modificaciones de la Tabla pizzas en tabla Admins.ModifTablas
	Tablas.TRIG_Ordenes											-- Revertir pedido si se ingresa una cantidad menor a 1 en tabla order_details
Nombre de SP
	Tablas.DEL_EliminarPedido									-- Eliminar un pedido si cliente ya no quiere de tablas orders y order_details
	Tablas.INS_PedidoPizza										-- Insertar pedido en tablas orders y order_details
	Tablas.INS_NuevaPizza										-- Añadir un nuevo tipo de pizza en tablas pizzas y pizza_types
	Tablas.UPD_DisponibilidadPizza								-- Cambiar disponibilidad de la pizza en el menu
	Tablas.UPD_ModificarPedido									-- Modificar un pedido existente solo si esta en el menu
*/

-- Llamadas a SP
EXEC Tablas.DEL_EliminarPedido
    @order_id = 48620,  
    @order_details_id = 48621

EXEC Tablas.INS_PedidoPizza 
	@pizza_id = 'ital_supr_l', 
	@quantity = 1;

EXEC Tablas.INS_NuevaPizza 
	@pizza_type_id='marg', 
	@name='The Margherita Pizza', 
	@category='Classic', 
	@ingredients='Tomato, Mozzarella Cheese, Basil, Olive Oil', 
	@price_s=10, 
	@price_m=13.5, 
	@price_l=16, 
	@activo = 0;

EXEC Tablas.UPD_DisponibilidadPizza 
	@pizza_id = 'marg_m',
	@activo = 1;

EXEC Tablas.UPD_ModificarPedido
    @order_id = 21351,
    @order_details_id = 48621,
    @new_pizza_id = 'ital_supr_l',
    @new_quantity = 2;


-------------------------------------------------------------------------------------------------------------------------------------------

-- Llamadas Vistas
SELECT * FROM Tablas.VentasUltimaSemana
SELECT * FROM Tablas.VentasDiaPorPizza 
SELECT * FROM Tablas.VentasDiaTotales
SELECT * FROM Tablas.StockPizzas

-------------------------------------------------------------------------------------------------------------------------------------------

-- Llamadas a Funciones
-- Funciones Escalares
SELECT Tablas.TotalIngresos('2015-01-01', '2015-01-31') AS VentasTotales;
SELECT Tablas.PizzaActiva('bbq_ckn_l');

-- Funciones Tabla
SELECT * FROM Tablas.PizzasMenosVentas('2015-01-01', '2015-01-31');
SELECT * FROM Tablas.PizzasMasVentas('2015-01-01', '2015-01-31');

--------------------------------------------------------------------------------------------------------------------------------------------
-- SCHEMAS
-- Tablas
select * from Tablas.pizzas
select * from Tablas.orders
select * from Tablas.order_details
select * from Tablas.pizza_types

--  Admins
select * from Admins.ModifTablas

