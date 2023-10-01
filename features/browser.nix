{ inputs, user, ... }:

{
  programs.firefox = {
    enable = true;

    profiles."${user.name}" = {
      extensions = [
        inputs.firefox-addons.packages."x86_64-linux".ublock-origin
        inputs.firefox-addons.packages."x86_64-linux".darkreader
        inputs.firefox-addons.packages."x86_64-linux".multi-account-containers
        inputs.firefox-addons.packages."x86_64-linux".return-youtube-dislikes
        inputs.firefox-addons.packages."x86_64-linux".facebook-container
        inputs.firefox-addons.packages."x86_64-linux".clearurls
      ];

      search = {
        default = "DuckDuckGo";
        force = true;
        order = [ "DuckDuckGo" ];
      };

      settings = {
        "browser.bookmarks.addedImportButton" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.pinned" = [];
        "browser.tabs.drawInTitlebar" = true;
        "browser.tabs.inTitlebar" = 1;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.placeholderName.private" = "DuckDuckGo";
      };

      userChrome = "";
      userContent = "";
    };
  };
}
