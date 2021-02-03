
Leyenda gráfica del Diagrama ER:
- Las claves primarias se identifican en el diagrama en negrita. 
- Todas las claves, tanto foráneas como primarias, se identifican con un fondo azul cielo.

Observaciones:

Para definir el tipo de ID de producto, atributos y entidades relacionadas, he mirado varias ópticas y he concluído que: 

- La mayoría de ópticas trabajan con IDs de producto tipo varchar, únicas e irrepetibles por cada tipo de gafas.
- Una ID de producto de una marca se asocia a una combinación espefícia de montura, color de montura y cristales. Cualquier variación en alguno de estos atributos se traduce en una ID de producto diferente.
- El enunciado requería una relación uno-muchos entre proveedor y producto. Esta relación se establece a través de la entidad marca (cada marca puede tener diferentes productos, pero una marca solo se puede asociar a un proveedor). 
- Para evitar productos duplicados en la entidad producto, se establece como clave primaria únicamente la id de producto.


