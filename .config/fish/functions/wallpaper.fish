function wallpaper

  if test $argv[1]
    set num $argv[1]

    if test $num -gt 310

      echo "Invalid user input: choose a number between 1 and 310"
      return
    end

  else
    set num (random 1 310)
  end

  # use 4 digits
  set pad_num (printf "%04d" $num)

  # get file name
  set file "/Users/$USER/Pictures/wallpapers/$pad_num.jpg"

  echo "Set wallpaper to $file"

  # set the wallpaper
  #osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$file\""
  # osascript -e "tell application \"System Events\" to set picture of current desktop to POSIX file \"$file\""
  # osascript -e "tell application \"System Events\" to set picture of second desktop to POSIX file \"$file\""
  osascript -e "tell application \"System Events\"
    tell every desktop
      set picture to \"$file\"
    end tell
  end tell"

  # osascript -e "
  #   tell application \"System Events\"
  #       set tlst to a reference to every desktop
  #       set picture of item 2 of tlst to \"$file\"
  #   end tell"
end
