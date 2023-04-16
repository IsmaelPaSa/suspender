chmod +x ./suspender.sh
cp ./suspender.sh /usr/share/suspender
systemctl daemon-reload
systemctl enable suspender.service
systemctl start suspender.service
