Config {
    font = "xft:Sans Mono:size=8"
    , bgColor = "#232323"
    , fgColor = "#C9A34E"
    , position = TopW L 90
    , lowerOnStart = True
    , commands = [
        Run Weather "LGAV" [
            "-t"
            , "☀ <tempC><fc=#b4cdcd>°C</fc>"
            , "-L",         "12"
            , "-H",         "33"
            , "--normal",   "#AFFF5F"
            , "--high",     "red"
            , "--low",      "#64FFE0"
        ] 36000
        , Run Date "%a %b %d %H:%M" "date" 10
        , Run Battery [
            "-t", "⚡ <left><fc=#b4cdcd>%</fc>"
            , "-L",         "10"
            , "-H",         "70"
            , "--high",     "#AFFF5F"
            , "--normal",   "#E7FF54"
            , "--low",      "red"
        ] 600
        , Run Com "~/bin/alsavol" [] "vol" 5
        , Run Kbd [
            ("us", "us"), ("gr", "gr")
        ]
        , Run MultiCpu [
            "-L","3"
            , "-H","50"
            , "--normal","#AFFF5F"
            , "--high","red"
            , "-t", "☢ <total><fc=#b4cdcd>%</fc>"
        ] 20
        , Run ThermalZone 0 [
            "-t","✇ <temp><fc=#b4cdcd>°C</fc>"
        ] 30
        ,Run Network "wlan0" [
            "-L", "8"
            , "-H", "32"
            , "-l", "#64FFE0"
            , "-n", "#AFFF5F"
            , "-h", "#B64949"
            , "-t", "⇅ <fc=#b4cdcd><rx></fc>↲ <fc=#b4cdcd><tx></fc>↱"
        ] 20
        ,Run Network "eth0" [
            "-L", "8"
            , "-H", "32"
            , "-l", "#64FFE0"
            , "-n", "#AFFF5F"
            , "-h", "#B64949"
            , "-t", "⇆ <fc=#b4cdcd><rx></fc>↲ <fc=#b4cdcd><tx></fc>↱"
        ] 20
        , Run StdinReader
    ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = "%StdinReader% }{ <fc=#b4cdcd>%kbd%</fc> : ♫ <fc=#b4cdcd>%vol%</fc> : %multicpu% %thermal0% : %wlan0%%eth0% : %battery% : %LGAV% : <fc=#b4cdcd>%date%</fc> "
}
