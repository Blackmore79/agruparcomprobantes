#!/bin/bash
usage="$(basename "$0") [-h] [-c n -i n -o n] -- Agrupar varias comprobantes de pago en una pagina.

Donde:
    -h  muestra esta ayuda
    -i pdf con comprobantes de pago
    -o pdf con las comprobantes agrupados
    -c elementos por clumna
        Opcional
        default 2
    -f elementos por fila
        Opcional
        default 2

Ejemplo:
  $(basename "$0") -c 2 -f 2 -i entrada.pdf -o salida.pdf
  
"

infile=""
outfile=""
folder=$PWD
col=2
row=2

while getopts ':h:i:o:c:f:' option; do
  case "${option}" in
    h) echo "$usage"
       exit
       ;;
    i) infile=$OPTARG
       ;;
    o) outfile=$OPTARG
       ;;
    c) col=$OPTARG
       ;; 
    f) row=$OPTARG
       ;;     
    :) printf "no paso el parametro -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

if [ -z "$infile" ]; then
    echo "INGRESE UN PDF DE ENTRADA"
    echo "$usage"
    exit 1
fi

if [ -z "$outfile" ]; then
    echo "INGRESE EL NOMBRE DEL PDF DE SALIDA"
    echo "$usage"
    exit 1
fi

### Verifiamos que se pase un pdf
if [ ! -f $infile ]; then
    echo "$usage"
    exit 1
fi

echo $(date +%H:%M:%S) "- iniciando el proceso"

echo $(date +%H:%M:%S) "- separando el DPF"
pdfseparate $infile $folder/p4g3-%d.pdf

pdfs=$(find $folder -name "p4g3*.pdf" -print0 | sort -zV | xargs -r0 echo)

### Convertimos los PDF en JPG
echo $(date +%H:%M:%S) "- pdf to jpg"
convert -density 150 -trim -quality 100 +repage $pdfs $folder/p4g3-%d.jpg



### Listamos los jpgs de forma ordenada
jpgs=$(find $folder -name "p4g3*.jpg" -print0 | sort -zV | xargs -r0 echo)

### Listamos los jpgs de forma ordenada
echo $(date +%H:%M:%S) "- pdf trim"
#convert $pdfs -fuzz 50% -trim +repage $folder/p4g3-%d.jpg
#mogrify -fuzz 10% -trim +repage $pdfs $folder/p4g3-%d.jpg
listarray=($jpgs)
for ((i = 0; i < ${#listarray[@]}; i++))
do
    mogrify -fuzz 10% -trim +repage ${listarray[$i]} ${listarray[$i]}

    w=$(identify -format "%w" ${listarray[$i]})
    h=$(identify -format "%h" ${listarray[$i]})

    if [ $w -gt 500 ]; then
      nh=$((h-50))
      size="$w""x""$nh""+55+25"
      convert -crop $size ${listarray[$i]} ${listarray[$i]}
      mogrify -fuzz 10% -trim +repage ${listarray[$i]} ${listarray[$i]}
    fi
done

### Cortamos las imagenes
#echo $(date +%H:%M:%S) "- CROP CROP CROP"
#convert -crop 456x598+76+72 $jpgs $folder/p4g3-%d.jpg

formato="$col""x""$row"

### Montamos las imagenes en una pagina
echo $(date +%H:%M:%S) "- Haciendo el collage"
montage  -mode Concatenate  -tile $formato -geometry +20+20 -background white $jpgs $folder/m0nt4g3.jpg

### Listamos los jpgs de forma ordenada
m=$(find $folder -name "m0nt4g3*.jpg" -print0 | sort -zV | xargs -r0 echo)

### convertimos las imagenes montadas en un pdf
convert $m +compress $folder/$outfile
echo $(date +%H:%M:%S) "- Limpiamos"
rm $folder/p4g3*
rm $folder/m0nt4g3*
echo $(date +%H:%M:%S) "- Se genero el archivo $outfile"