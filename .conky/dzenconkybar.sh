# dzenconkybar - launch conkybar with dzen2

#FG='#9fbc00'
FG='#7BB146'
BG='#232323'

FONT='Sans Mono:size=8'

conky -c $HOME/.conky/conkybar-dzen | dzen2 -e '' -h '16' -w '1366' -ta l -fg ${FG} -bg ${BG} -fn "${FONT}"
