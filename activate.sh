rm -rf ~/.ssh/known_hosts

# Change the current working directory
cd "`dirname "$0"`"

./device/iproxy 4444:44 > /dev/null 2>&1 &


echo "Mounting"
./device/sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -p 4444 "root@localhost" 'mount -o rw,union,update /'
echo "Mounted!"

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 rm -rf /var/mobile/Media/Downloads/1

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 rm -rf /var/mobile/Media/1

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 mkdir /var/mobile/Media/Downloads/1

./device/sshpass -p alpine scp -rP 4444 -o StrictHostKeyChecking=no ./Activation root@localhost:/var/mobile/Media/Downloads/1

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 mv -f /var/mobile/Media/Downloads/1 /var/mobile/Media

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chown -R mobile:mobile /var/mobile/Media/1

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chmod -R 755 /var/mobile/Media/1

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chmod 644 /var/mobile/Media/1/Activation/activation_record.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chmod 644 /var/mobile/Media/1/Activation/data_ark.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chmod 644 /var/mobile/Media/1/Activation/com.apple.commcenter.device_specific_nobackup.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 killall backboardd sleep 12

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 mv -f /var/mobile/Media/1/Activation/FairPlay /var/mobile/Library/FairPlay

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chmod 755 /var/mobile/Library/FairPlay

ACT1=$(./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 find /private/var/containers/Data/System -name internal)

ACT2=$(./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 find /private/var/containers/Data/System -name activation_records)

echo $ACT1 

ACT2=${ACT1%?????????????????} 

echo $ACT2 ACT3=$ACT2/Library/internal/data_ark.plist

ACT4=$ACT2/Library/activation_records 

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 mkdir $ACT4

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 mv -f /var/mobile/Media/1/Activation/activation_record.plist $ACT4/activation_record.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chmod 755 $ACT4/activation_record.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chflags uchg $ACT4/activation_record.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chflags nouchg /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 mv -f /var/mobile/Media/1/Activation/com.apple.commcenter.device_specific_nobackup.plist /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 chown root:mobile /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist

./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 launchctl load /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist

 ./device/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 4444 reboot
