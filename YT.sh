#!/bin/bash

# --- [ RENK TANIMLARI ] ---
RED='\033[0;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; NC='\033[0m'

# --- [ HAFIZA YOLU ] ---
# Android dahili hafızasındaki Download klasörü
STORAGE_PATH="/sdcard/Download/ZorgoMedia"

header() {
    clear
    echo -e "${RED}      ███████╗ ██████╗ ██████╗  ██████╗  ██████╗ ${NC}"
    echo -e "${RED}      ╚══███╔╝██╔═══██╗██╔══██╗██╔════╝ ██╔═══██╗${NC}"
    echo -e "  ${Y}>>> ZORGO-DL | TELEFON DAHİLİ HAFIZA MODU <<<  ${NC}"
    echo -e "${RED}─────────────────────────────────────────────────────${NC}"
}

# Klasörü oluştur
mkdir -p "$STORAGE_PATH"

header
echo -n -e "${G}YouTube Linkini Yapıştır: ${NC}"; read url

echo -e "\n${B}[ KALİTE SEÇİMİ ]${NC}"
echo -e "1) En Yüksek Kalite (4K/1080p MP4)"
echo -e "2) Sadece Müzik (MP3)"
echo -n -e "\n${Y}Seçiminiz: ${NC}"; read choice

echo -e "\n${Y}[*] Operasyon Başlatıldı. Dahili hafızaya aktarılıyor...${NC}"

case $choice in
    1)
        # Video + Ses birleştir ve Dahili Hafızaya at
        yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
        -o "$STORAGE_PATH/%(title)s.%(ext)s" "$url"
        ;;
    2)
        # Sesi ayıkla ve MP3 olarak Dahili Hafızaya at
        yt-dlp -x --audio-format mp3 --audio-quality 0 \
        -o "$STORAGE_PATH/%(title)s.%(ext)s" "$url"
        ;;
    *)
        echo -e "${RED}[!] Geçersiz seçim.${NC}"; exit 1 ;;
esac

if [ $? -eq 0 ]; then
    echo -e "\n${G}[✓] BAŞARILI: Video şuraya kaydedildi:${NC}"
    echo -e "${W}$STORAGE_PATH${NC}"
    echo -e "${Y}[!] Galerinizi kontrol edin!${NC}"
else
    echo -e "\n${RED}[X] HATA: İndirme başarısız oldu. İzinleri kontrol edin.${NC}"
fi
