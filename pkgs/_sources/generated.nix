# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  cmp-path = {
    pname = "cmp-path";
    version = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1";
    src = fetchFromGitHub ({
      owner = "hrsh7th";
      repo = "cmp-path";
      rev = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1";
      fetchSubmodules = false;
      sha256 = "sha256-G/I2SH4Uidr25/4fjrtcK3VfxWwD9MSN+ODcB6zjvVo=";
    });
  };
  magma-nvim = {
    pname = "magma-nvim";
    version = "8b1d928f88dab299f8da2930624185814ae2a9af";
    src = fetchFromGitHub ({
      owner = "dccsillag";
      repo = "magma-nvim";
      rev = "8b1d928f88dab299f8da2930624185814ae2a9af";
      fetchSubmodules = false;
      sha256 = "sha256-rm+OqNPVpMh0rTM4BW8HrvLKpJN7864BnKTdpkgikpg=";
    });
  };
  manix = {
    pname = "manix";
    version = "d08e7ca185445b929f097f8bfb1243a8ef3e10e4";
    src = fetchFromGitHub ({
      owner = "mlvzk";
      repo = "manix";
      rev = "d08e7ca185445b929f097f8bfb1243a8ef3e10e4";
      fetchSubmodules = false;
      sha256 = "sha256-GqPuYscLhkR5E2HnSFV4R48hCWvtM3C++3zlJhiK/aw=";
    });
  };
  neozoom-nvim = {
    pname = "neozoom-nvim";
    version = "de0e27a3e619ed3f79232ba8daf0ae1a8e92bfea";
    src = fetchFromGitHub ({
      owner = "nyngwang";
      repo = "NeoZoom.lua";
      rev = "de0e27a3e619ed3f79232ba8daf0ae1a8e92bfea";
      fetchSubmodules = false;
      sha256 = "sha256-A8RiK5dNRglJJfsaGxnyj3lOah1m8Zvmj1upeN4tYVI=";
    });
  };
  one-small-step-for-vimkind = {
    pname = "one-small-step-for-vimkind";
    version = "59ec6f57545a42e68995994bfa57479da5e68b74";
    src = fetchFromGitHub ({
      owner = "jbyuki";
      repo = "one-small-step-for-vimkind";
      rev = "59ec6f57545a42e68995994bfa57479da5e68b74";
      fetchSubmodules = false;
      sha256 = "sha256-bpYfScckecKSFj6ne0qiowza4fbkYxo7wsvHMypG1g4=";
    });
  };
}
