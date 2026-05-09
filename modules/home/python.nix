{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [ tkinter ]))
    ty
    ruff
  ];

  programs.uv = {
    enable = true;
    settings = { 
      exclude-newer = "7 days";
    };
  };
}
