chmod +x ./suspender.sh
cp ./suspender.sh /usr/bin/suspender
cp ./suspender.service /etc/systemd/system/suspender.service
systemctl daemon-reload
systemctl enable suspender.service
systemctl start suspender.service
