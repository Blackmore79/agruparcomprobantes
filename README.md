# Agrupar Comprobantes

Script de Bash pasar de un pdf con una comprobantes de pago por pagina a un pdf con varias comprobantes por pagina.

### Instalar

#### Instalar imagemagick 
http://www.imagemagick.org

```sh
$ sudo apt install imagemagick
```

#### Clone Git

```sh
$ git clone https://github.com/Blackmore79/agruparcomprobantes.git agruparcomprobantes && cd agruparcomprobantes
```

### Modo de uso:

```sh
$ gruparcomprobantes.sh -c 2 -f 2 -i uno-comprobate-por-pagina.pdf -o cuatro-comprobantes-por-pagina.pdf
```
Opciones: 

- -h muestra ayuda
- -i pdf con comprobantes de pago
- -o pdf con las comprobantes agrupados
- -c elementos por clumna
- -f elementos por fila

f y c son opcionales y por default tiene valor 2
  
 
