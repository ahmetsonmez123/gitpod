FROM gitpod/workspace-full

# XFCE ve VNC sunucusunu kur
RUN sudo apt-get update && sudo apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    && sudo apt-get clean

# VNC sunucusunu yapılandır
RUN mkdir -p ~/.vnc \
    && echo "password" | vncpasswd -f > ~/.vnc/passwd \
    && chmod 600 ~/.vnc/passwd

# VNC sunucusunu başlat
CMD vncserver :1 -geometry 1280x800 -depth 24 && tail -f /dev/null
