# Script to make a logging RPi for SMesh
# rename corrupted repositories on Pete's SD cards
sudo mv /var/lib/apt/lists/deb.debian.org_debian_dists_bookworm-updates_contrib_binary-arm64_Packages BadBlock1
sudo mv /var/lib/apt/lists/deb.debian.org_debian_dists_bookworm-updates_contrib_i18n_Translation-en BadBlock2

sudo apt -y install x11-apps xterm git pipx
sudo apt update
sudo apt -y upgrade
pipx ensurepath
pipx install poetry
pipx ensurepath
source .bashrc
cd
mkdir Documents
cd Documents
mkdir github
cd github
git clone https://github.com/josdo/smesh
cd smesh/snode
source /home/pi/.bashrc
poetry install
#  Not necessary but sometimes useful when debugging
pipx install meshtastic
pipx ensurepath
echo "$(echo '@reboot source /home/pi/.bashrc; cd /home/pi/Documents/github/smesh/snode; /home/pi/.local/bin/poetry install; /home/pi/.local/bin/poetry run python scripts/read_aqi.py /dev/ttyUSB0 >>data/read_aqi_stdouterr_log.txt 2>&1' ;) " | crontab  -
crontab -l
#Control-c out of this after you see it work
poetry run python scripts/read_aqi.py /dev/ttyUSB0
