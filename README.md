# Agrupar Comprobantes

Script de Bash pasar de un pdf con una comprobantes de pago por pagina a un pdf con varias comprobantes por pagina.

#### Requiere imagemagick instalado en el equipo.

http://www.imagemagick.org

## Modo de uso:

agruparcomprobantes.sh -c 2 -f 2 -i uno-comprobate-por-pagina.pdf -o cuatro-comprobantes-por-pagina.pdf

- -h muestra esta ayuda
- -i pdf con comprobantes de pago
- -o pdf con las comprobantes agrupados
- -c elementos por clumna
  Opcional
  default 2
- -f elementos por fila
  Opcional
  default 2
