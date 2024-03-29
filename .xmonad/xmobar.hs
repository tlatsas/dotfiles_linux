Config {
    font = "xft:Dejavu Sans:size=8"
    , bgColor = "#232323"
    , fgColor = "#C9A34E"
    , position = TopW L 90
    , lowerOnStart = True

    -- refresh rate is in tenths of second
    , commands = [
        Run Weather "LGAV" [
            "-t"
            , "☀ <tempC><fc=#b4cdcd>°C</fc>"
            , "-L",         "12"
            , "-H",         "33"
            , "--normal",   "#85B400"
            , "--high",     "red"
            , "--low",      "#64FFE0"
        ] 36000
        , Run Date "%a %b %d %H:%M" "date" 300
        , Run Battery [
            "-t", "⚡ <left><fc=#b4cdcd>%</fc>"
            , "-L",         "15"
            , "-H",         "60"
            , "--high",     "#85B400"
            , "--normal",   "#E7FF54"
            , "--low",      "red"
        ] 600
        , Run Kbd [
            ("us", "us"), ("gr", "gr")
        ]
        , Run MultiCpu [
            "-L","3"
            , "-H","50"
            , "--normal","#AFFF5F"
            , "--high","red"
            , "-t", "☢ <total><fc=#b4cdcd>%</fc>"
        ] 30
        , Run Memory [
            "-t", "♽ <usedratio><fc=#b4cdcd>%</fc>"
            , "-L",         "20"
            , "-H",         "70"
            , "--high",     "red"
            , "--normal",   "#85B400"
        ] 50
        , Run ThermalZone 5 [
            "-t","✇ <temp><fc=#b4cdcd>°C</fc>"
        ] 80
        , Run PipeReader "/tmp/.volume-pipe" "vol_pipe"
        , Run UnsafeStdinReader
    ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = "%UnsafeStdinReader% }{ <fc=#b4cdcd>%kbd%</fc> : ♫ <fc=#b4cdcd>%vol_pipe%</fc> : %multicpu% %memory% %thermal5% : %battery% : %LGAV% : <fc=#b4cdcd>%date%</fc> "
}
