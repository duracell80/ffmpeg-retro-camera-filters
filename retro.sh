#!/bin/bash

LEAK_ANGLES=$(shuf -i 0-360 -n 1)
LEAK_LENGTH=$(shuf -i 30-135 -n 1)
LEAK_ROTATE=",scale=w=2*iw:h=2*ih,rotate=angle=${LEAK_ANGLES}"

LEAK_STR="[0]split[v0][v1];[v0]format=rgba,"
LEAK_END=":a=${LEAK_LENGTH}*(Y/H)${LEAK_ROTATE}[fg];[v1][fg]overlay=(W-w)/2:(H-h)/2:shortest=1"

case "$3" in
  "-leak_red")
    LEAK_MID="geq=r=255:g=00:b=0"
    ;;
  "-leak_orange")
    LEAK_MID="geq=r=155:g=55:b=0"
    ;;
  "-leak_yellow")
    LEAK_MID="geq=r=255:g=255:b=0"
    ;;
  "-leak_green")
    LEAK_MID="geq=r=00:g=155:b=0"
    ;;
  "-leak_blue")
    LEAK_MID="geq=r=00:g=0:b=155"
    ;;
  "-leak_purple")
    LEAK_MID="geq=r=255:g=0:b=255"
    ;;

  *)
    cp "${1}" /tmp/test.jpg
    ;;
esac


case "$2" in
  "-fuji_instax")
    	bloom="split [a][b];
             [b] boxblur=4.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

	blur="gblur=sigma=1.5"
	lens="lenscorrection=k1=0:k2=0"
	chromatic="rgbashift=rh=-0.01:gh=0.01"
	vintage="noise=c0s=1"
	vibrance="vibrance=0.4"
	temperature="colortemperature=temperature=8000"
	equalizer="eq=gamma=1.25:contrast=1.05:saturation=0.9"
	vignette="drawbox=x=0:y=0:w=2:h=ih:color=black@0.5:thickness=fill"
    ;;
  "-fuji_qs400")
	bloom="split [a][b];
             [b] boxblur=1.2,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

	blur="gblur=sigma=1.5"
	lens="lenscorrection=k1=0.125:k2=0.015"
	chromatic="rgbashift=rh=-1.15:gh=1.15"
	vintage="noise=c0s=25"
	vibrance="vibrance=-0.25"
	temperature="colortemperature=temperature=15000"
	equalizer="eq=gamma=0.5:contrast=1.25:saturation=0.5:brightness=0.15"
	vignette="vignette=angle=PI/3.4:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
  "-fuji_qs800")
	bloom="split [a][b];
             [b] boxblur=1.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

	blur="gblur=sigma=1.5"
	lens="lenscorrection=k1=0.125:k2=0.015"
	chromatic="rgbashift=rh=-1.2:gh=1.2"
	vintage="noise=c0s=7"
	vibrance="vibrance=0.2"
	temperature="colortemperature=temperature=6000"
	equalizer="eq=gamma=1.5:contrast=1.1:saturation=0.8"
	vignette="vignette=angle=PI/3.4:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
  "-fuji_qs-outdoor")
        bloom="split [a][b];
             [b] boxblur=1.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.1"
        lens="lenscorrection=k1=0.125:k2=0.015"
        chromatic="rgbashift=rh=-0.2:gh=0.2"
        vintage="noise=c0s=20"
        vibrance="vibrance=0.5"
        temperature="colortemperature=temperature=5000"
        equalizer="eq=gamma=1.8:contrast=1.3:saturation=0.3"
        vignette="vignette=angle=PI/3.4:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
  *)
    echo "Usage example: ./retro input.jpg -fuji_qs400 -leak_green"
    exit 1
    ;;
esac





case "$3" in
  *"leak"*)
    ffmpeg -y -filter_complex "${LEAK_STR}${LEAK_MID}${LEAK_END}" -i "${1}" /tmp/test.jpg
    ffplay -vf "${vintage},
                ${vibrance},
                ${equalizer},
                ${blur},
                ${chromatic},
                ${lens},
                ${vignette},
                ${bloom}" -i /tmp/test.jpg
    ;;
  *)
    ffplay -vf "${temperature},
                ${vintage},
                ${vibrance},
                ${equalizer},
                ${blur},
                ${chromatic},
                ${lens},
                ${vignette},
                ${bloom}" -i /tmp/test.jpg

    ;;
esac


rm /tmp/test.jpg
