{pkgs, ...}: let
  tor-browser = "${pkgs.tor-browser-bundle-bin}/bin/tor-browser";
  mpv = "${pkgs.mpv}/bin/mpv";
in {
  programs.newsboat = {
    enable = true;
    extraConfig = ''
      refresh-on-startup yes

      feed-sort-order lastupdated
      text-width         72

      bind-key j down feedlist
      bind-key k up feedlist
      bind-key j next articlelist
      bind-key k prev articlelist
      bind-key J next-feed articlelist
      bind-key K prev-feed articlelist
      bind-key j down article
      bind-key k up article

      macro y set browser "${mpv} %u" ; open-in-browser ; set browser "${tor-browser} %u" -- "Open video on mpv"
    '';
    urls = [
      {
        url = "https://www.novinky.cz/rss";
        tags = ["news" "czech"];
      }
      {
        url = "https://zpravy.aktualne.cz/rss/";
        tags = ["news" "czech"];
      }
      {
        url = "https://www.krimi-plzen.cz/rss";
        tags = ["news" "czech"];
      }
      {
        url = "https://www.irozhlas.cz/rss/irozhlas";
        tags = ["news" "czech"];
      }
      {
        url = "http://feeds.feedburner.com/odemcene-clanky";
        tags = ["news" "czech"];
      }
      {
        url = "https://www.theguardian.com/international/rss";
        tags = ["news" "english"];
      }
      {
        url = "https://root.cz/rss/clanky";
        tags = ["tech" "czech"];
      }
      {
        url = "https://root.cz/rss/zpravicky";
        tags = ["tech" "czech"];
      }
      {
        url = "https://www.archlinux.org/feeds/news/";
        tags = ["tech" "english"];
      }
      {
        url = "https://news.ycombinator.com/rss";
        tags = ["tech" "english"];
      }
      {
        url = "https://feeds.arstechnica.com/arstechnica/index";
        tags = ["tech" "english"];
      }
      {
        url = "http://www.osel.cz/rss/rss.php";
        tags = ["sci" "czech"];
      }
      {
        url = "https://vesmir.cz/cz/vesmir-rss-odemcene-clanky.html";
        tags = ["sci" "czech"];
      }
      {
        url = "https://www.mff.cuni.cz/cs/articlesRss";
        tags = ["sci" "czech"];
      }
      {
        url = "https://api.quantamagazine.org/feed/";
        tags = ["sci" "english"];
      }
      {
        url = "http://feeds.nature.com/nature/rss/current";
        tags = ["sci" "english"];
      }
      {
        url = "http://export.arxiv.org/rss/quant-ph";
        tags = ["sci" "english" "papers"];
      }
      {
        url = "http://export.arxiv.org/rss/math-ph";
        tags = ["sci" "english" "papers"];
      }
      {
        url = "http://export.arxiv.org/rss/gr-qc";
        tags = ["sci" "english" "papers"];
      }
      {
        url = "http://export.arxiv.org/rss/cs";
        tags = ["sci" "english" "papers"];
      }
    ];
  };
}
