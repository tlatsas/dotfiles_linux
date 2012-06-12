Config {
    font = "xft:Sans Mono:size=8"
    , bgColor = "#232323"
    , fgColor = "#C9A34E"
    , position = TopW L 90
    , lowerOnStart = True
    , commands = [
        Run Weather "LGAV" [
            "-t"
                , " <tempC>°C"
            , "-L",         "12"
            , "-H",         "33"
            , "--normal",   "#AFFF5F"
            , "--high",     "red"
            , "--low",      "#64FFE0"
        ] 36000
        , Run Date "%a %b %d %H:%M" "date" 10
        , Run Battery [
            "-t", "bat <left>%"
            , "-L",         "10"
            , "-H",         "70"
            , "--high",     "#AFFF5F"
            , "--normal",   "#E7FF54"
            , "--low",      "red"
        ] 600
        , Run Com "~/bin/alsavol" [] "vol" 5
        , Run Com "~/bin/xkb-switch" [] "keys" 5
        , Run StdinReader
    ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = "%StdinReader% }{ <fc=#b4cdcd>%keys%</fc> :: vol <fc=#b4cdcd>%vol%</fc> :: %battery% :: <fc=#b4cdcd>%date%</fc> :: %LGAV% "
}
