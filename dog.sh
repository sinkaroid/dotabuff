#!/bin/bash
#sin

RED=$(tput setaf 1) 
GREEN=$(tput setaf 2) 
CYAN=$(tput setaf 6) 
WHITE=$(tput setaf 7) 

begin=$(date +"%s")
echo -e "${RED} "
echo "  Sin . (dbuff [dotabuff match scraper])"
echo -e "${RED}
    .__________   __        ___.           _____  _____         .__     
  __| _/\   _  \_/  |______ \_ |__  __ ___/ ____\/ ____\   _____|  |__  
 / __ | /  /_\  \   __\__  \ | __ \|  |  \   __//   __\   /  ___/  |  \ 
/ /_/ | \  \_/   \  |  / __ \| \_\ \  |  /|  |   |  |     \___ \|   Y  /
\____ |  \_____  /__| (____  /___  /____/ |__|   |__| /\ /____  >___|  |
     \/        \/          \/    \/                   \/      \/     \/                                                                                                                         
"
echo "${WHITE}"
echo "usage : ['matchid']"

#get
read -p "${GREEN}matchid?: " kode
read -p "${WHITE}${kode} Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1 
echo -e "try to get /${GREEN}$kode ..
${WHITE}"
wget -q -nv -O ${kode}.html https://www.dotabuff.com/matches/${kode};
cat ${kode}.html | grep -P -o '<div class="header-content-container">.*?<section class="team-advantages">' | sed 's/<div class="header-content-container">/<link rel="stylesheet" type="text\/css" href="https:\/www.dotabuff.com\/assets\/application-e7ef665e3507f32bde962adb761b238493bc35b62a4fe37ccff9fdc8d9ced7ba.css">/' | sed 's/src="/src="https:\/www.dotabuff.com/g' | sed 's/https:\/www.dotabuff.comhttps/https/g' > ${kode}-.html
rm ${kode}.html;

title="$(cat ${kode}-.html | grep -oP '(?<=<dd>)[^<]*')"
echo "${CYAN}"Overview: [${title}]
start "" "${kode}-.html"
FILEPATH="${kode}-.html"
echo "parsed on >> "$(realpath $(dirname $FILEPATH))/$(basename $FILEPATH)
#length
termin=$(date +"%s")
difftimelps=$(($termin-$begin))
echo "${WHITE}$(($difftimelps / 60)) minutes and $(($difftimelps % 60)) sec. elapsed ${RED}dotabuff.sh"