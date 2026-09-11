# BaseDeDatos-U2-Ej08-CadenaSuministro
Base de Datos - Unidad 2 - Ejercicio 8

Consigna

Modelar la cadena de suministro de una mayorista de electrónica: depósitos, catálogo de productos, stock por depósito, proveedores internacionales con su precio de costo por producto, y órdenes de compra con su detalle de ítems.

Lógica

Producto ↔ Depósito: N:M con producto-deposito. El stock no es un atributo del producto (sería un único número global, inútil para operar) ni del depósito (no se sabría de qué artículo). cantidad_stock es atributo de la combinación producto + depósito, que es exactamente lo que pide el enunciado. ubicacion_fisica (pasillo/estante) va en la misma intermedia por el mismo motivo: el mismo producto ocupa distinta posición en cada almacén.

Producto ↔ Proveedor: N:M con producto-proveedor. Un producto lo proveen varios y un proveedor entrega varios. precio_costo pertenece al vínculo, no a las entidades. Se agregó fecha_vigencia porque el costo de un proveedor internacional cambia seguido y conviene poder identificar qué precio estaba vigente.

Orden de compra con detalle (orden-producto). La orden es la cabecera (número, fecha, estado, proveedor y depósito de destino) y orden-producto es el detalle línea por línea, con cantidad_pedida y precio_pactado. El precio pactado se guarda en el detalle y no se lee de producto-proveedor: el costo de lista cambia, pero lo que se pactó en esa orden tiene que quedar congelado para poder auditarla después.

Depósito de destino como relación, no como texto. La orden se relaciona N:1 con DEPOSITO (recibe_en) y N:1 con PROVEEDOR (se_emite_a). Esto cierra el circuito: se sabe a qué almacén físico impacta la mercadería cuando llega.

Integridad para que la recepción actualice el stock correctamente:

cantidad_recibida está en el detalle, separada de cantidad_pedida. Sin ese par no se pueden detectar entregas parciales ni faltantes.
El stock que se incrementa es el de la fila de producto-deposito que cruza el Id_Producto del detalle con el Id_Deposito de la cabecera de la orden. Si esa fila no existe (primera vez que ese producto entra a ese depósito), hay que crearla antes de sumar; si no, el movimiento se pierde.
Sobre las dos intermedias conviene declarar UNIQUE compuesto en sus FK (Id_Producto + Id_Deposito, Id_Producto + Id_Proveedor) para que no existan dos filas de stock del mismo producto en el mismo depósito, que es la forma más común de que los números dejen de cuadrar.
La actualización tiene que ser transaccional: sumar stock, actualizar cantidad_recibida y pasar la orden a Recibida se confirman juntos o no se confirma nada.
Solo deberían sumar stock las órdenes en estado válido, y una orden ya recibida no debería poder volver a procesarse (control de estado, para evitar duplicar el ingreso).
Restricciones de dominio: cantidad_stock >= 0, cantidad_recibida <= cantidad_pedida, y los productos del detalle deberían existir en producto-proveedor para el proveedor de esa orden (no se le puede pedir a un proveedor algo que no provee).

Nota sobre trazabilidad. El contexto menciona lotes de mercadería, pero el desarrollo requerido no los pide. Si se quisiera trazabilidad completa se agregaría una entidad LOTE (número de lote, fecha de vencimiento, orden de origen) entre la recepción y el stock, y producto-deposito pasaría a llevar el detalle por lote.

Resultado
<img width="3700" height="3779" alt="BaseDeDatos-U2-Ej08-CadenaSuministro" src="https://github.com/user-attachments/assets/1528ad27-a312-4d76-aa91-b3d816d545c1" />

