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

RUN echo 'keyboard-configuration keyboard-configuration/layout select Turkish' | debconf-set-selections && \
    && echo 'keyboard-configuration keyboard-configuration/layoutcode select tr' | debconf-set-selections && \
    && echo 'keyboard-configuration keyboard-configuration/model select Generic 105-key PC' | debconf-set-selections && \
    && echo 'keyboard-configuration keyboard-configuration/variant select Turkish' | debconf-set-selections && \
    && echo 'keyboard-configuration keyboard-configuration/optionscode string' | debconf-set-selections && \
    && DEBIAN_FRONTEND=noninteractive && apt-get install -y keyboard-configuration

# VNC sunucusunu başlat
CMD vncserver :1 -geometry 1280x800 -depth 24 && tail -f /dev/null
