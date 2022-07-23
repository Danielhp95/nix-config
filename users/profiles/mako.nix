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

    # TODO: add self colors
    # colours
    #backgroundColor = background;
    #borderColor = primary;
    #progressColor = "over ${secondary}";
    #textColor = foreground;
  };
}
