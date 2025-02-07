#!/bin/bash

waktu=$(date '+%Y-%m-%d %H:%M:%S')
HIJAU='\033[0;32m'
MERAH='\033[0;31m'
NORMAL='\033[0m'
BIRU='\033[0;34m'
PUTIH='\033[1;37m'

header(){
    printf "${HIJAU}
         ####################################
         ####################################
         #######                      #######
         #######                      #######${BIRU}
         #######  github.com/adilhyz  #######
         ###############      ###############
         ###############      ###############
         ###############      ###############
         ###############      ###############${MERAH}
         #######    ####      ####    #######
         #######    ####      ####    #######
         #######    ##############    #######
         #######    ##############    #######
         #######                      #######
         ####################################
         ####################################${PUTIH}
         ------------------------------------
              	  Shell Checker CLI
                Code By : Sanrei
         ------------------------------------
"
}

tatsumi(){
    domain="${1}"
    site="${domain}/${custom_path}"

    ngecurl=$(curl -s -I "$site")

    if [[ ! $ngecurl =~ "200 OK" ]]; then
        printf "${MERAH}NOT FOUND => $site\n"
    else
        # Ambil konten halaman
        ngecek=$(curl -s "$site" -L)

        # Regex untuk deteksi di title
        title_keywords="wso|HAWKZONE|lite|shell|Linux|backdoor|Tatsumi|shells|cyber|team|hacker|ECWS|nf_tracking|chosen|simple|000|{Ninja-Shell}"
        ngeganti=$(echo "$ngecek" | tr '[:upper:]' '[:lower:]')

        if [[ $ngeganti =~ ($title_keywords) ]]; then
            printf "${HIJAU}FOUND => $site\n"
            echo "$site" >> shell1.txt
        else
            printf "${MERAH}NOT FOUND (No Match in Title) => $site\n"
        fi
    fi
}    

header
echo ""
echo "List In This Directory: "
ls
echo "Delimiter list -> url"
echo -n "Masukan File List: "
read list

if [ ! -f "$list" ]; then
    echo "${MERAH}$list No Such File${NORMAL}"
    exit
fi

# Menanyakan path yang ingin dicek dengan format warna yang benar
echo -n "Masukkan path yang ingin dicek (contoh: wso.php): "
read custom_path

persend=1
sleep_time=3
itung=1

x=$(gawk '{ print $1 }' "$list")
IFS=$'\r\n' GLOBIGNORE='*' command eval 'url=($x)'

for (( i = 0; i < "${#url[@]}"; i++ )); do
    set_kirik=$(expr $itung % $persend)

    if [[ $set_kirik == 0 && $itung > 0 ]]; then
        sleep $sleep_time
    fi

    domain="${url[$i]}"
    tatsumi "$domain" &
    itung=$((itung+1))
done
