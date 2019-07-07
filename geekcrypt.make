#!/bin/sh

## hyphop ##

DPI=150

[ -s text/front.txt ] || \
    ./geekcrypt -r < text/crypt.txt > text/front.txt

c=2 ./geekcrypt < text/front.txt | tee text/crypt.txt
# make svg front pic
C="#ffffff" ./tools/txt2svg text/crypt.txt > pics/geekcrypt.1.svg
C="#000000" ./tools/txt2svg text/crypt.txt > pics/geekcrypt.1.black.svg
# make svg back pic
FANCY=1 ./tools/txt2svg ./geekcrypt > pics/geekcrypt.2.svg

for i in pics/geekcrypt.?.svg pics/geekcrypt.?.black.svg; do
     inkscape -D -T -d $DPI -i TEXT -j -e "${i%.*}.png" "$i"
     inkscape -D -T -d $DPI -i TEXT -j -E "${i%.*}.eps" "$i"
#     inkscape -D -T -d $DPI -i TEXT -j -m "${i%.*}.wmf" "$i"
#     inkscape -D -T -d $DPI -i TEXT -j -M "${i%.*}.emf" "$i"
done

#    -E "${i%.*}.eps" \
#    -m "${i%.*}.wmf" \
#    -M "${i%.*}.emf" \

for i in pics/geekcrypt.?.example.svg pics/geekcrypt.example.*.svg; do
#   convert -density $DPI $i ${i%.*}.png
   inkscape -d $DPI -e "${i%.*}.png" "$i"
done

for r in pics/geekcrypt.?.svg; do
    echo "[i] $r"
done

for i in pics/geekcrypt.example.white pics/geekcrypt.example.black ; do
    convert $i.png -resize 1280 $i.small.png
    convert $i.png -resize 1280 -quality 75 $i.small.jpg
done

echo "[i] well done! enjoy!">&2
