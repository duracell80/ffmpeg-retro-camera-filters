#!/bin/bash

GRAIN_INTEN=$(shuf -i 5-45 -n 1)
LEAK_ANGLES=$(shuf -i 0-360 -n 1)
LEAK_LENGTH=$(shuf -i 30-100 -n 1)
LEAK_ROTATE=",scale=w=2*iw:h=2*ih,rotate=angle=${LEAK_ANGLES}"

LEAK_STR="[0]split[v0][v1];[v0]format=rgba,"
LEAK_END=":a=${LEAK_LENGTH}*(Y/H)${LEAK_ROTATE}[fg];[v1][fg]overlay=(W-w)/2:(H-h)/2:shortest=1"


if [ -z "$4" ]; then
	FILE_TS=0
else
	if [[ "$4" == "-1" ]]; then
                FILE_TS=3141592653
	elif [[ "$4" == "1" ]]; then
                FILE_TS=$(stat -c '%Y' "${1}")
		if [[ "$FILE_TS" -lt "100000" ]]; then
			FILE_TS=$(date +%s)
		fi
        elif [[ "$4" == "2" ]]; then
		FILE_TS=$(date +%s)
	elif [[ "$4" == "3" ]]; then
		TIME_TS=$(date +%s)
                FILE_TS=$(shuf -i 0-$TIME_TS -n 1)
	else
                FILE_TS=$4
        fi
fi



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
  "-leak_none")
    LEAK_MID="geq=r=0:g=0:b=0"
    ;;
  *)
    cp "${1}" /tmp/retrocam.jpg
    ;;
esac


case "$2" in
   "-fuji_instax")
    	bloom="split [a][b];
             [b] boxblur=2.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

	blur="gblur=sigma=0.5"
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
             [b] boxblur=0.7,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

	blur="gblur=sigma=0.5"
	lens="lenscorrection=k1=0.125:k2=0.015"
	chromatic="rgbashift=rh=-1.15:gh=1.15,unsharp=5:5:5"
	vintage="noise=c0s=3"
	vibrance="vibrance=0.55"
	temperature="colortemperature=temperature=5500"
	equalizer="eq=gamma=0.95:contrast=1.25:saturation=0.6:brightness=0.15"
	vignette="vignette=angle=PI/3.4:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
   ;;
   "-fuji_qs800")
	bloom="split [a][b];
             [b] boxblur=0.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

	blur="gblur=sigma=0.4"
	lens="lenscorrection=k1=0.125:k2=0.015"
	chromatic="rgbashift=rh=-1.175:gh=1.175"
	vintage="noise=c0s=6"
	vibrance="vibrance=0.25"
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
    "-kodak_fs")
        bloom="split [a][b];
             [b] boxblur=0.05,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.05"
        lens="lenscorrection=k1=0:k2=-0"
        chromatic="rgbashift=rh=0:gh=0"
        vintage="noise=c0s=3"
        vibrance="vibrance=0.675"
        temperature="colortemperature=temperature=6500"
        equalizer="eq=gamma=1.035:contrast=0.875:saturation=0.635:brightness=-0.085"
        vignette="vignette=angle=PI/9.75:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
    "-kodak_gold-200")
        bloom="split [a][b];
             [b] boxblur=0.200,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.25"
        lens="lenscorrection=k1=-0.0320:k2=-0.0320"
        chromatic="rgbashift=rh=0.0300:gh=0.0300"
        vintage="noise=c0s=4.4200"
        vibrance="vibrance=0.7500"
        temperature="colortemperature=temperature=6200"
        equalizer="eq=gamma=1.200:contrast=0.9200:saturation=0.5200:brightness=-0.100"
        vignette="vignette=angle=PI/4.75:mode=forward,scale=1.05*iw:-1,crop=iw/1.05:ih/1.05"
    ;;
    "-kodak_plus-200")
        bloom="split [a][b];
             [b] boxblur=0.200,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.25"
        lens="lenscorrection=k1=-0.0320:k2=-0.0320"
        chromatic="rgbashift=rh=0.0200:gh=0.0200"
        vintage="noise=c0s=2.200"
        vibrance="vibrance=0.550"
        temperature="colortemperature=temperature=7500"
        equalizer="eq=gamma=0.72:contrast=0.75200:saturation=0.5200:brightness=0.0225"
        vignette="vignette=angle=PI/4.75:mode=forward,scale=1.05*iw:-1,crop=iw/1.05:ih/1.05"
    ;;
    "-ilford_xp2")
        bloom="split [a][b];
             [b] boxblur=0.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.01"
        lens="lenscorrection=k1=-0.075:k2=-0.075"
        chromatic="rgbashift=rh=-0:gh=0,hue=s=0"
        vintage="noise=c0s=0"
        vibrance="vibrance=0.8"
        temperature="colortemperature=temperature=5500"
        equalizer="eq=gamma=0.5:contrast=1.5:saturation=0"
        vignette="vignette=angle=PI/3.4:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
    "-ilford_hp5")
        bloom="split [a][b];
             [b] boxblur=0.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.01"
        lens="lenscorrection=k1=-0.075:k2=-0.075"
        chromatic="rgbashift=rh=-0:gh=0,hue=s=0,unsharp=5:5:1"
        vintage="noise=c0s=7"
        vibrance="vibrance=0.5"
        temperature="colortemperature=temperature=7500"
        equalizer="eq=gamma=1.1:contrast=0.75:saturation=0.85"
        vignette="vignette=angle=PI/3.4:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
    "-ilford_color")
        bloom="split [a][b];
             [b] boxblur=0.01,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.01"
        lens="lenscorrection=k1=-0.075:k2=-0.075"
        chromatic="rgbashift=rh=-0.15:gh=0.15"
        vintage="noise=c0s=7"
        vibrance="vibrance=0.575"
        temperature="colortemperature=temperature=9500"
        equalizer="eq=gamma=1.155:contrast=0.85:saturation=0.65:brightness=-0.065"
        vignette="vignette=angle=PI/4.75:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
    "-agfa_lebox")
        bloom="split [a][b];
             [b] boxblur=0.05,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.05"
        lens="lenscorrection=k1=0.075:k2=0.075"
        chromatic="rgbashift=rh=-0.45:gh=0.45"
        vintage="noise=c0s=15"
        vibrance="vibrance=-0.0475"
        temperature="colortemperature=temperature=4500"
        equalizer="eq=gamma=1.025:contrast=0.85:saturation=0.85:brightness=-0.065"
        vignette="scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
    "-agfa_scala")
        bloom="split [a][b];
             [b] boxblur=0.05,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.05"
        lens="lenscorrection=k1=0.075:k2=0.075"
        chromatic="rgbashift=rh=-0.45:gh=0.45,hue=s=0,unsharp=5:5:1"
        vintage="noise=c0s=10"
        vibrance="vibrance=-0.0475"
        temperature="colortemperature=temperature=4500"
        equalizer="eq=gamma=1.025:contrast=1.15:saturation=0:brightness=-0.065"
        vignette="scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
    "-agfa_apx")
        bloom="split [a][b];
             [b] boxblur=0.05,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.05"
        lens="lenscorrection=k1=0.075:k2=0.075"
        chromatic="rgbashift=rh=-0.45:gh=0.45,hue=s=0,unsharp=3:3:1"
        vintage="noise=c0s=5"
        vibrance="vibrance=-0.0475"
        temperature="colortemperature=temperature=8500"
        equalizer="eq=gamma=1.275:contrast=1.05:saturation=0:brightness=-0.025"
        vignette="scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
    "-lomo_lca")
        bloom="split [a][b];
             [b] boxblur=1.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.01"
        lens="lenscorrection=k1=0.125:k2=0.015"
        chromatic="rgbashift=rh=-0.1:gh=0.1"
        vintage="noise=c0s=25"
        vibrance="vibrance=0.7"
        temperature="colortemperature=temperature=4500"
        equalizer="eq=gamma=1.2:contrast=1.8:saturation=1.2"
        vignette="vignette=angle=PI/1.75:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
    ;;
    "-lomo_wide")
        bloom="split [a][b];
             [b] boxblur=1.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.01"
        lens="lenscorrection=k1=0.125:k2=0.015"
        chromatic="rgbashift=rh=-0.1:gh=0.1"
        vintage="noise=c0s=25"
        vibrance="vibrance=0.7"
        temperature="colortemperature=temperature=4500"
        equalizer="eq=gamma=1.2:contrast=1.8:saturation=1.2"
        vignette="vignette=angle=PI/1.75:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.5"
     ;;
     "-lomo_fish")
        bloom="split [a][b];
             [b] boxblur=1.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.01"
        lens="v360=flat:fisheye:ih_fov=70:v_fov=70:h_fov=60:v_fov=45:w=360:h=360"
        chromatic="rgbashift=rh=-0.1:gh=0.1"
        vintage="noise=c0s=25"
        vibrance="vibrance=0.7"
        temperature="colortemperature=temperature=5500"
        equalizer="eq=gamma=1.3:contrast=1.6:saturation=1.3"
        vignette="vignette=angle=PI/1:mode=forward,scale=1.5*iw:-1,crop=w='min(iw\,ih)':h='min(iw\,ih)',scale=ih/1:ih/1,setsar=1"
     ;;
     "-holga_120")
        bloom="split [a][b];
             [b] boxblur=1.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.1"
        lens="lenscorrection=k1=-0.175:k2=-0.075"
        chromatic="rgbashift=rh=-0.01:gh=0.01"
        vintage="noise=c0s=5"
        vibrance="vibrance=0.8"
        temperature="colortemperature=temperature=3500"
        equalizer="eq=gamma=1.5:contrast=1.3:saturation=1.3"
        vignette="vignette=angle=PI/0.25:mode=forward,scale=1.5*iw:-1,crop=w='min(iw\,ih)':h='min(iw\,ih)',scale=ih/2:ih/2,setsar=1"
     ;;
     "-eink")
        bloom="split [a][b];
             [b] boxblur=0,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

        blur="gblur=sigma=0.0"
        lens="lenscorrection=k1=0:k2=0"
        chromatic="rgbashift=rh=0:gh=0"
        vintage="noise=c0s=1"
        vibrance="vibrance=-0.55"
        temperature="colortemperature=temperature=9500"
        equalizer="eq=gamma=0.5:contrast=0.5:saturation=0.3"
        vignette="vignette=angle=PI/20.25:mode=forward,scale=1.5*iw:-1:sws_dither=ed"
     ;;

  *)
    echo -e "\nUsage example: ./retro input.jpg -fuji_qs800 -leak_none 1\n\nFilter list:\n-agfa_lebox\n-agfa_scala\n-agfa_apx\n-kodak_fs\n-lomo_fish\n-lomo_wide\n-lomo_lca\n-ilford_color\n-ilford_hp5\n-ilford_xp2\n-fuji_qs-outdoor\n-fuji_qs400\n-fuji_qs800\n-fuji_instax\n-holga_120\n-eink"
    exit 1
    ;;
esac

# EXTRACT FILM GRAIN
BLEND_PC=$(echo "scale=2; $GRAIN_INTEN / 100" | bc)
convert "${1}" -remap pattern:gray30 /tmp/grain.gif


case "$3" in
  *"leak"*)

    ffmpeg -y -i "${1}" -vf "unsharp=3:3:1.5" /tmp/sharp.jpg
    ffmpeg -y -filter_complex "${LEAK_STR}${LEAK_MID}${LEAK_END}" -i /tmp/sharp.jpg /tmp/out.jpg

    ffmpeg -y -i /tmp/out.jpg -i /tmp/grain.gif -filter_complex "[0][1]blend=all_mode='overlay':all_opacity=${BLEND_PC}" /tmp/out_1.jpg

    ffmpeg -y -i /tmp/out_1.jpg -vf "${vintage},
                ${temperature},
		${vibrance},
                ${equalizer},
                ${blur},
                ${chromatic},
                ${lens},
                ${vignette},
                ${bloom}" /tmp/out_2.jpg
    ;;
  *)
    ffmpeg -y -i "${1}" -vf "hqdn3d=8:6:12:9" /tmp/sharp.jpg
    ffmpeg -y -i /tmp/sharp.jpg -vf "${vintage},
		${temperature},
                ${vibrance},
                ${equalizer},
                ${blur},
                ${chromatic},
                ${lens},
                ${vignette},
                ${bloom}" /tmp/out_2.jpg

    ;;
esac

#composite -gravity center /tmp/out_2.jpg /tmp/grain.gif /tmp/out.jpg
#ffmpeg -i /tmp/out_2.jpg -i /tmp/grain.gif -filter_complex "[0][1]blend=all_mode='overlay':all_opacity=0.7" /tmp/out.jpg

if [[ "$FILE_TS" != "0" ]]; then
	ffmpeg -y -filter_complex "drawtext=fontfile=fonts/e1234.ttf:fontsize=(h/25):x=w-tw-(h/10):y=h-th-(h/10):text='%{pts\:gmtime\:$FILE_TS\:%d-%m-%Y %T}':fontcolor=orange@0.6:box=1:boxcolor=orange@0:shadowcolor=black@0:shadowx=1:shadowy=1" -i /tmp/out_2.jpg /tmp/retrocam.jpg
else
	cp /tmp/out_2.jpg /tmp/retrocam.jpg
fi

ffplay -i /tmp/retrocam.jpg


#rm /tmp/out.jpg
#rm /tmp/out_1.jpg
#rm /tmp/out_2.jpg
#rm /tmp/sharp.jpg
#rm /tmp/grain.gif
