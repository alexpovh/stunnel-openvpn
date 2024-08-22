#!/bin/sh

# setup stunnel config
echo "output = $HOME/stunnel/stunnel.log
pid = $HOME/stunnel/stunnel.pid
client = yes
foreground = yes

[openvpn]
sni = some.domain.name
accept = 127.0.0.1:8443
connect = xx.xx.xx.xx:8443" > /opt/homebrew/etc/stunnel/stunnel.conf

# run stunnel at login
echo "<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>local.stunnel</string>
	<key>Program</key>
	<string>/opt/homebrew/bin/stunnel</string>
	<key>RunAtLoad</key>
	<true/>
	<key>KeepAlive</key>
	<true/>
</dict>
</plist>" > $HOME/Library/LaunchAgents/local.stunnel.plist

# create log/pid dir
mkdir $HOME/stunnel

# add routing
networksetup -setadditionalroutes "Wi-Fi" xx.xx.xx.xx 255.255.255.255 192.168.1.1
