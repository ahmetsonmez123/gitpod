FROM gitpod/workspace-full

# XFCE, VNC sunucusu ve Türkçe dil paketlerini kur
RUN sudo apt-get update && sudo apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    language-pack-tr \
    && sudo apt-get clean

# Türkçe klavye ve dil ayarlarını yapılandır
RUN echo "LANG=tr_TR.UTF-8" | sudo tee /etc/default/locale \
    && sudo localectl set-locale LANG=tr_TR.UTF-8 \
    && sudo localectl set-keymap tr \
    && echo 'setxkbmap tr' >> ~/.vnc/xstartup

# VNC sunucusunu başlat
CMD vncserver :1 -geometry 1280x800 -depth 24 && tail -f /dev/null
