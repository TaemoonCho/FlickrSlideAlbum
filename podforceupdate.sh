#! /bin/sh

function clear_pods {
  echo "Kill The Xcode process."
  PID=`ps -eaf | grep Xcode | grep -v grep | awk '{print $2}'`
  if [[ "" !=  "$PID" ]]; then
    echo "Xcode is running. Now shutting down Xcode"
    kill -9 $PID
  fi
  echo "Clear DerivedData of XCode builds"
  rm -Rf ~/Library/Developer/Xcode/DerivedData
  echo "Clear cocoa pod caches."
  rm -Rf "${HOME}/Library/Caches/CocoaPods"
  echo "Delete cocoa pods."
  rm -Rf "`pwd`/Pods/"
  echo "Delete `pwd`/FlickrSlideAlbum.xcworkspace"
  rm -Rf "`pwd`/FlickrSlideAlbum.xcworkspace"
  pod update
  echo "Starting pod install"
  pod install
  open FlickrSlideAlbum.xcworkspace
}


read -p "If Continue this task, Quit Xcode and remove current pods. Are you sure (y/n)?" choice
case "$choice" in
  y|Y ) clear_pods;;
 * ) echo "Canceled";;
esac
