#!/bin/bash
clear
trap "./exit.sh" SIGINT
echo Katacoda Ubuntu Windows 8.1 by fb.com/thuong.hai.581

PS3='Choose your NGROK REGION you want to change (type 1, 2, 3, 4, 5, 6 then Enter): '
foods=("US" "AP" "AU" "SA" "JP" "IN")
select fav in "${foods[@]}"; do
    case $fav in
        "US")
            killall ngrok
	    nohup ./ngrok tcp --region us 30889 &>/dev/null &
            break
            ;;
        "AP")
            killall ngrok
	    nohup ./ngrok tcp --region ap 30889 &>/dev/null &
            break
            ;;
	"AU")
            killall ngrok
	    nohup ./ngrok tcp --region au 30889 &>/dev/null &
            break
            ;;
        "SA")
            killall ngrok
	    nohup ./ngrok tcp --region sa 30889 &>/dev/null &
            break
            ;;
	"JP")
            killall ngrok
	    nohup ./ngrok tcp --region jp 30889 &>/dev/null &
            break
            ;;
	"IN")
            killall ngrok
	    nohup ./ngrok tcp --region in 30889 &>/dev/null &
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo Change Ngrok Region Success!!!
./win8vm.sh


