{ pkgs-unstable, ... }:

{
  environment.systemPackages = [
    pkgs-unstable.brave-origin
  ];

  environment.etc."brave/policies/recommended/optional.json".text = builtins.toJSON {
    "RestoreOnStartup" = 5;
    "BookmarkBarEnabled" = true;
    "EnableMediaRouter" = false;
    "WebRtcIPHandling" = "disable_non_proxied_udp";
    "BackgroundModeEnabled" = false;
    "BravePlaylistEnabled" = false;
    "PasswordManagerEnabled" = false;
    "AutofillAddressEnabled" = false;
    "AutofillCreditCardEnabled" = false;
  };

  environment.etc."brave/policies/managed/strict.json".text = builtins.toJSON {
    "BraveAIChatEnabled" = false;
    "BraveRewardsDisabled" = true;
    "BraveWalletDisabled" = true;
    "BraveVPNDisabled" = true;
    "TorDisabled" = true;
    "BraveP3AEnabled" = false;
    "BraveStatsPingEnabled" = false;
    "BraveWebDiscoveryEnabled" = false;
    "BraveNewsDisabled" = true;
    "BraveTalkDisabled" = true;
    "MetricsReportingEnabled" = false;
    "SafeBrowsingExtendedReportingEnabled" = false;
    "UrlKeyedAnonymizedDataCollectionEnabled" = false;
  };
}
