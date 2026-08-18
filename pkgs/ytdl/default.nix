{ writeShellApplication
, curl
, ffmpeg-full
, deno
}:

writeShellApplication {
  name = "ytdl";
  runtimeInputs = [ curl ffmpeg-full deno ];
  text = ''
    YTDLP_DIR="$HOME/.local/bin"
    YTDLP="$YTDLP_DIR/yt-dlp"

    export PATH="$YTDLP_DIR:$PATH"

    usage() {
      echo "Usage: ytdl <best|mp4|mp3> <url> [output_dir]"
      exit 1
    }

    [ $# -lt 2 ] && usage

    format="$1"
    url="$2"
    outdir="''${3:-$HOME/Downloads}"

    mkdir -p "$outdir"

    if [ ! -f "$YTDLP" ]; then
      echo "yt-dlp not found, downloading..."
      mkdir -p "$YTDLP_DIR"
      curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o "$YTDLP"
      chmod +x "$YTDLP"
    fi

    case "$format" in
      mp4) args=(-f 'bv*[vcodec^=avc]+ba[ext=m4a]/b' -o "$outdir/%(title)s.%(ext)s" "$url") ;;
      mp3) args=(--extract-audio --audio-format mp3 --audio-quality 0 -o "$outdir/%(title)s.%(ext)s" "$url") ;;
      best) args=(-f 'bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]/bv*+ba/b' -o "$outdir/%(title)s.%(ext)s" "$url") ;;
      *) echo "Error: invalid format" ;;
    esac

    if ! "$YTDLP" "''${args[@]}"; then
      read -rp "yt-dlp failed, do you want to update it? [y/n] " answer
      if [[ "$answer" =~ ^[Yy]$ ]]; then
        "$YTDLP" -U
      fi
    fi
  '';
}
