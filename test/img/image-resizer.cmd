magick mogrify -crop 1:1 -quality 20 -gravity center  -extent 1:1 -path 1x1/ *.jpg
magick mogrify -crop 4:3 -quality 20 -gravity center  -extent 4:3 -path 4x3/ *.jpg
magick mogrify -crop 16:9 -quality 20 -gravity center  -extent 16:9  -path 16x9/ *.jpg
