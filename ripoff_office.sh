#!/bin/bash
######
#08.05.2017 / STA
#RipOff Microsoft Office 356 - leave Outlook & Outlook db's installed
######

#Get loggedin Users
loggedinuser=$(ls -l /dev/console | awk '{ print $3 }')
logfile=/tmp/officeripoff.log


#Delete in Appliactions Folder
echo "###### Delete Apps ######" >> $logfile
for app in "Excel" "Word" "Powerpoint" "OneNote"
do
  if [ -d "/Applications/Microsoft $app.app" ]; then
    rm -rf "/Applications/Microsoft $app.app"
    echo "$(date): Delete App: Microsoft $app" >> $logfile
  fi
done


#Delete User Containers
echo "###### Delete User Containers ######" >> $logfile
for container in "Excel" "Word" "Powerpoint" "oneneote.mac" "errorreporting" "netlib.shipassertprocess" "Office365ServiceV2" "RMS-XPCService"
do
  if [ -d "/Users/$loggedinuser/Library/Containers/com.microsoft.$container" ]; then
    rm -rf "/Users/$loggedinuser/Library/Containers/com.microsoft.$container"
    echo "$(date): Delete User Containers: /Users/$loggedinuser/Library/Containers/com.microsoft.$container" >> $logfile
  fi
done


#Delete Preferences
echo "###### Delete Preferences ######" >> $logfile
for preference in "Excel" "onenote.mac" "Powerpoint" "Word"
do
  if [ -e "/Library/Preferences/com.microsoft.$preference.plist" ]; then
    rm -f "/Library/Preferences/com.microsoft.$preference.plist"
    echo "$(date): Delete Preferences: /Library/Preferences/com.microsoft.$preference.plist" >> $logfile
  fi
done


#Forget Package Receipts
echo "###### Forget Package Receipts ######" >> $logfile
for pkg in "Excel" "OneNote" "PowerPoint" "Word"
do
  pkgname=$(pkgutil --pkgs | grep $pkg)
  if [ -n "$pkgname" ]; then
    pkgutil --forget com.microsoft.package.Microsoft_$pkg
    echo "$(date): Forget Package Receipts: com.microsoft.package.Microsoft_$pkg" >> $logfile
  fi
done

<<<<<<< HEAD

#Remove items from dock

for dockitem in "Microsoft%20Word.app" "Microsoft%20OneNote.app" "Microsoft%20PowerPoint.app" "Microsoft%20Excel.app"
do
dloc=$(defaults read "/Users/$loggedinuser/Library/Preferences/com.apple.dock.plist" persistent-apps | grep _CFURLString\" | awk -v x="$dockitem" '$0~x {print NR-1}')
=======
#Remove item from dock
echo "###### Remove Items from Dock ######" >> $logfile
dloc=$(defaults read "/Users/$loggedinuser/Library/Preferences/com.apple.dock.plist" persistent-apps | grep _CFURLString\" | awk '/Microsoft%20Word.app/ {print NR-1}')
if [ -n "$dloc" ]; then
  /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist
  echo "$(date): $dloc removed from dock" >> $logfile
fi

dloc=$(defaults read "/Users/$loggedinuser/Library/Preferences/com.apple.dock.plist" persistent-apps | grep _CFURLString\" | awk '/Microsoft%20OneNote.app/ {print NR-1}')
>>>>>>> origin/master
if [ -n "$dloc" ]; then
  /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist
  echo "$(date): $dloc removed from dock" >> $logfile
fi
done



<<<<<<< HEAD

=======
dloc=$(defaults read "/Users/$loggedinuser/Library/Preferences/com.apple.dock.plist" persistent-apps | grep _CFURLString\" | awk '/Microsoft%20PowerPoint.app/ {print NR-1}')
if [ -n "$dloc" ]; then
  /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist
  echo "$(date): $dloc removed from dock" >> $logfile
fi

dloc=$(defaults read "/Users/$loggedinuser/Library/Preferences/com.apple.dock.plist" persistent-apps | grep _CFURLString\" | awk '/Microsoft%20Excel.app/ {print NR-1}')
if [ -n "$dloc" ]; then
  /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist
  echo "$(date): $dloc removed from dock" >> $logfile
fi
>>>>>>> origin/master

killall Dock

echo "###### Office 2016 removed ######" >> $logfile