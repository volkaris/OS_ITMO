

mkdir ~/test && echo "catalog test was created successfully" >> ~/report && touch ~/test/$(date +"%F_%R")

ping http://www.net_nikogo.ru || echo " $(date +"%F_%R")  error while connecting to site" >> ~/report

