# Agrupar Comprobantes

Pasar de un pdf con una comprobantes de pago por pagina a un pdf con varias comprobantes por pagina.

### Instalar

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
  
##### Requiere imagemagick 
http://www.imagemagick.org

en debian/ubuntu

```sh
$ wget http://www.imagemagick.org/download/ImageMagick.tar.gz
$ tar -xvf ImageMagick.tar.gz
$ cd ImageMagick-7.*
$ ./configure
$ make
$ sudo make install
$ sudo ldconfig /usr/local/lib
```
Probar si funciona

```sh
$ display
```
