#!/bin/sh
BASH_COMMAND=`xdotool getwindowfocus getwindowname`
PreFocusApp=""

while [ true ]
do
  FocusApp=`xdotool getwindowfocus getwindowname`
  if [ "$FocusApp" = "$PreFocusApp" ] ; then
    echo "## continue"
    PreFocusApp=$FocusApp
    sleep 1
    continue
  fi

  if [ "$PreFocusApp" = "$BASH_COMMAND" ] && [ "$FocusApp" != "$BASH_COMMAND" ] ; then
    echo "## start"
    input-remapper-control --command start --device "AT Translated Set 2 keyboard" --preset "gui keybindings"
  elif [ "$PreFocusApp" != "$BASH_COMMAND" ] && [ "$FocusApp" = "$BASH_COMMAND" ] ; then
    echo "## stop"
    input-remapper-control --command stop --device "AT Translated Set 2 keyboard"
  fi

  PreFocusApp=$FocusApp
  sleep 1
done
