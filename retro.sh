#!/bin/bash

LEAK_ANGLES=$(shuf -i 0-360 -n 1)
LEAK_LENGTH=$(shuf -i 30-135 -n 1)
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
    cp "${1}" /tmp/test.jpg
    cp "${1}" /tmp/out.jpg
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
	vintage="noise=c0s=25"
	vibrance="vibrance=-0.25"
	temperature="colortemperature=temperature=15000"
	equalizer="eq=gamma=0.55:contrast=1.25:saturation=0.5:brightness=0.05"
	vignette="vignette=angle=PI/3.4:mode=forward,scale=1.15*iw:-1,crop=iw/1.15:ih/1.15"
   ;;
   "-fuji_qs800")
	bloom="split [a][b];
             [b] boxblur=0.5,
                    format=gbrp [b];
             [b][a] blend=all_mode=screen:shortest=1"

	blur="gblur=sigma=0.4"
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

  *)
    echo -e "\nUsage example: ./retro input.jpg -fuji_qs400 -leak_none 1\n\nFilter list:\n-agfa_lebox\n-agfa_scala\n-agfa_apx\n-lomo_fish\n-lomo_wide\n-lomo_lca\n-ilford_color\n-ilford_hp5\n-ilford_xp2\n-fuji_qs-outdoors\n-fuji_qs400\n-fuji_qs200\n-fuji_instax\n-holga_120"
    exit 1
    ;;
esac





case "$3" in
  *"leak"*)
    ffmpeg -y -filter_complex "${LEAK_STR}${LEAK_MID}${LEAK_END}" -i "${1}" /tmp/test.jpg
    ./filmgrain.sh -a 75 -A 0 -n multiplicative /tmp/test.jpg /tmp/grain.jpg

    ffmpeg -y -i /tmp/grain.jpg -vf "hqdn3d=8:6:12:9,
                ${temperature},
		${vibrance},
                ${equalizer},
                ${blur},
                ${chromatic},
                ${lens},
                ${vignette},
                ${bloom}" /tmp/out.jpg
    ;;
  *)
    ./filmgrain.sh -a 100 -A 50 -d 100 -D 100 -m no "${1}" /tmp/grain.jpg
    ffmpeg -y -i /tmp/test.jpg -vf "${temperature},
                ${vibrance},
                ${equalizer},
                ${blur},
                ${chromatic},
                ${lens},
                ${vignette},
                ${bloom}" /tmp/out.jpg

    ;;
esac

if [[ "$FILE_TS" != "0" ]]; then
	ffmpeg -y -filter_complex "drawtext=fontfile=fonts/e1234.ttf:fontsize=(h/25):x=w-tw-(h/10):y=h-th-(h/10):text='%{pts\:gmtime\:$FILE_TS\:%d-%m-%Y %T}':fontcolor=orange@0.6:box=1:boxcolor=orange@0:shadowcolor=black@0:shadowx=1:shadowy=1" -i /tmp/out.jpg /tmp/test_out.jpg
else
	cp /tmp/out.jpg /tmp/test_out.jpg
fi

ffplay -i /tmp/test_out.jpg


rm /tmp/test.jpg
rm /tmp/out.jpg
rm /tmp/grain.jpg
