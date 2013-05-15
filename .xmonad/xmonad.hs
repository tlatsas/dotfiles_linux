import XMonad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import System.Exit
import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet    as W
import qualified Data.Map           as M

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers

-- xmonad prompt and scratchpad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Scratchpad
import XMonad.Util.WorkspaceCompare
import qualified XMonad.Prompt as P
import XMonad.Prompt.Shell
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.IM
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Grid
import XMonad.Layout.LayoutHints
import Data.Ratio ((%))
import Data.List (isInfixOf)

-- Java workarounds
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

-- classic alt-tab
--import XMonad.Actions.CycleWindows


main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig { manageHook = myManageHook <+> manageDocks
            , modMask = mod4Mask
            , layoutHook = myLayoutHook
            , logHook = myLogHook xmproc
            , terminal = myTerminal
            , workspaces = myWorkspaces
            , borderWidth = myBorderWidth
            , normalBorderColor = myNormalBorderColor
            , focusedBorderColor = myFocusedBorderColor
            , keys = myKeys
            , startupHook = ewmhDesktopsStartup >> setWMName "LG3D"
            }

-- workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- terminal
myTerminal :: String
myTerminal = "urxvtc"

-- launcher
--myLauncher :: String
--myLauncher = "dmenu_run -nb '#232323' -nf '#9fbc00' -sb '#9fbc00' -sf '#141414' -p '$'"

-- window border size
myBorderWidth :: Dimension
myBorderWidth = 1

-- window border colors
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor = "#141414"
myFocusedBorderColor = "#9a9a9a"

-- hooks --
-- switch apps to workspace
myManageHook :: ManageHook
myManageHook = scratchpadManageHook ( W.RationalRect 0.25 0.25 0.5 0.5 ) <+> ( composeAll . concat $
                [[isFullscreen                      --> doFullFloat
                , className =? "Firefox"            --> doShift "1"
                , className =? "Xmessage"           --> doCenterFloat
                , className =? "Gimp"               --> doShift "9"
                -- chat
                , className =? "Pidgin"             --> doShift "4"
                , className =? "Skype"              --> doShift "4"
                , className =? "Emesene"            --> doShift "4"
                , className =? "Gajim.py"           --> doShift "4"
                , className =? "MPlayer"            --> doShift "5"
                , className =? "Smplayer"           --> doShift "5"
                , className =? "Thunderbird"        --> doShift "6"
                , className =? "Wine"               --> doShift "8"
                , title     =? "Minecraft Launcher" --> doShift "8"
                , title     =? "Minecraft Launcher" --> doFloat
                , className =? "Zenity"             --> doFloat
                -- , fmap ("libreoffice" `isInfixOf`) className --> doShift "3:doc"
                , className =? "MPlayer"            --> (ask >>= doF . W.sink)
                , className =? "Gcr-prompter"       --> doCenterFloat
                ]] )

-- logHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ myPP { ppOutput = hPutStrLn h
    , ppSort = fmap (.scratchpadFilterOutWorkspace) getSortByTag
    }

-- custom theme for xmobar
myPP :: PP
myPP = defaultPP
    {
        ppCurrent   = xmobarColor "#B4CDCD" "" . wrap "[" "]"
        , ppVisible = xmobarColor "#9CB1B1" "" . wrap "(" ")"
        , ppHidden  = xmobarColor "#C98F0A" ""
        , ppUrgent  = xmobarColor "#FFFFAF" "" . wrap "*" "*"
        , ppLayout  = xmobarColor "#698A8A" ""
        , ppTitle   = xmobarColor "#C9A34E" "" . shorten 60
        , ppSep     = xmobarColor "#B4CDCD" "" " :: "
    }

-- custom theme for shell
myXPConfig = defaultXPConfig
    {
        font = "xft:Dejavu Sans:size=8"
        , fgColor = "#9fbc00"
        , bgColor = "#232323"
        , bgHLight = "#9fbc00"
        , fgHLight = "#141414"
        , promptBorderWidth = 0
        , position = Bottom
        , historySize = 512
        , showCompletionOnTab = True
        , historyFilter = deleteConsecutive
    }

-- custom theme for tabs
myTabConfig = defaultTheme
    {
        inactiveColor = "#232323"
        , inactiveBorderColor = "#232323"
        , activeColor = "#232323"
        , activeBorderColor = "#9fbc00"
        , activeTextColor = "#9fbc00"
    }

-- layout
myLayoutHook = onWorkspace "1" webL
                $ onWorkspace "4" imL
                $ onWorkspace "5" fullL
                $ onWorkspace "6" webL
                $ onWorkspace "9" gimpL
                $ standardLayouts
    where
        standardLayouts = avoidStruts $ smartBorders $ (tiled ||| reflectTiled ||| Mirror tiled ||| Grid ||| Full ||| tabbed shrinkText myTabConfig)

        --Layouts
        tiled = layoutHintsWithPlacement (0.5, 0.5) (Tall 1 (3/100) (1/2))
        reflectTiled = (reflectHoriz tiled)
        full = noBorders Full
        fullL = avoidStruts $ smartBorders $ full
        tabs = tabbed shrinkText myTabConfig

        --Im Layout
        imL = avoidStruts $
              smartBorders $
              withIM ratio pidginRoster $
              withIM ratio emeseneRoster $
              withIM ratio gajimRoster $
              reflectHoriz $ withIM skypeRatio skypeRoster (reflectTiled ||| Grid) where
                ratio = (1%9)
                -- pidgin
                pidginRoster = And (ClassName "Pidgin") (Role "buddy_list")
                -- skype
                skypeRatio = (1%8)
                skypeRoster = (And (ClassName "Skype") (Not (Role "ConversationsWindow")))
                -- emesene
                emeseneRoster = (Resource "emesene" `And` Title "emesene" `And` ClassName "Emesene")
                -- gajim
                gajimRoster = And (ClassName "Gajim.py") (Role "roster")


        webL = avoidStruts $ smartBorders $ (tabs ||| tiled)

        gimpL = avoidStruts $ withIM (0.11) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.15) (Role "gimp-dock") (fullL ||| tabs)


-- keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
--    , ((modm .|. shiftMask, xK_p     ), spawn myLauncher)

    , ((modm,               xK_o    ), scratchpadSpawnActionTerminal "urxvt -name scratchpad")

    -- prompt
    , ((modm,               xK_p     ), shellPrompt myXPConfig)

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((mod1Mask,           xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Lock screen
    , ((modm .|. shiftMask, xK_l     ), spawn "slock")

    -- Screenshot using Scrot (desktop)
    , ((0,                  xK_Print ), spawn "scrot '/tmp/%Y-%m-%d-%H%M%S_$wx$h.png'")

    -- Screenshot using Scrot (selection)
    , ((modm,               xK_Print  ), spawn "sleep 0.2; scrot -s '/tmp/%Y-%m-%d-%H%M%S_$wx$h.png'")

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- play youtube videos
    , ((modm              , xK_y     ), spawn "~/bin/zenitube")

    -- Manage volume
    -- for amixer-osd see: https://github.com/tlatsas/dotfiles
    , ((0, xF86XK_AudioRaiseVolume),    spawn "~/bin/alsavol up")
    , ((0, xF86XK_AudioLowerVolume),    spawn "~/bin/alsavol down")
    , ((0, xF86XK_AudioMute),           spawn "~/bin/alsavol toggle")

    -- Control MPD from ncmpcpp
    , ((0, xF86XK_AudioPlay),           spawn "ncmpcpp toggle")
    , ((0, xF86XK_AudioStop),           spawn "ncmpcpp stop")
    , ((0, xF86XK_AudioPrev),           spawn "ncmpcpp prev")
    , ((0, xF86XK_AudioNext),           spawn "ncmpcpp next")

    -- Keyboard backlight
    , ((0, xF86XK_KbdBrightnessDown),      spawn "~/bin/kbd-backlight down")
    , ((0, xF86XK_KbdBrightnessUp),        spawn "~/bin/kbd-backlight up")

    -- Toggle touchpad on/off
    --, ((0, 0x1008ffa9),                 spawn "~/bin/touchpad-toggle")

    -- focus urgent window
    , ((modm              , xK_BackSpace), focusUrgent)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

