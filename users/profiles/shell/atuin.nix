{

  # Remember that there are some manual steps
  # required after installation
  programs.atuin.enable = true;
  programs.atuin.enableZshIntegration = true;
  programs.atuin.settings.auto_sync = false; # disable sync
  programs.atuin.settings.search_mode = "fuzzy";

}
