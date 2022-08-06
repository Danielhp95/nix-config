{ config, ... }:
{

  programs.mako = {
    enable = true;
    anchor = "top-right";
    defaultTimeout = 10000;
    sort = "-time";
    maxVisible = 5;

    # look
    borderSize = 5;
    borderRadius = 3;
    font = "FontAwesome 12";
    height = 300;
    width = 600;

    icons = true; # Show icons
    # icon-location = "_left_";  Seems to not exist...

    # TODO: add self colors
    # colours
    #backgroundColor = background;
    #borderColor = primary;
    #progressColor = "over ${secondary}";
    #textColor = foreground;
  };
  # TODO: progress- color for mako notifications todo with brightness and volume

  # TODO: Look into group-by for combining notifications into one?
  # - i.e: Volume / brightness increase decrease
}
