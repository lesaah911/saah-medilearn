#!/bin/bash
# Règles iptables vm-firewall
# Saah_MediLearn Plateforme

# Activer le forwarding
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

# Vider les règles existantes
iptables -F
iptables -t nat -F

# NAT et forwarding
iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
iptables -A FORWARD -i ens34 -o ens33 -j ACCEPT
iptables -A FORWARD -i ens33 -o ens34 \
-m state --state RELATED,ESTABLISHED -j ACCEPT

# Sauvegarder
netfilter-persistent save