import XMonad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import System.Exit

import qualified XMonad.StackSet    as W
import qualified Data.Map           as M

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers

-- xmonad prompt
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.Prompt as P
import XMonad.Prompt.Shell
import XMonad.Prompt
import XMonad.Prompt.AppendFile (appendFilePrompt)
import XMonad.Prompt.RunOrRaise

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.IM
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Grid
import Control.OldException(catchDyn,try)
import XMonad.Layout.ComboP
import XMonad.Layout.Column
import XMonad.Layout.Named
import XMonad.Layout.TwoPane
import Data.Ratio ((%))
import Data.List (isInfixOf)


main = do
    spawn "sh ${HOME}/.xmonad/autostart.sh"
    xmproc <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig { manageHook = myManageHook <+> manageDocks
            --, layoutHook = avoidStruts  $  layoutHook defaultConfig
            , layoutHook = myLayoutHook
            , logHook = dynamicLogWithPP xmobarPP { ppOutput = hPutStrLn xmproc, ppTitle = xmobarColor "green" "" . shorten 60 }
            , terminal = myTerminal
            , workspaces = myWorkspaces
            , borderWidth = myBorderWidth
            , normalBorderColor = myNormalBorderColor
            , focusedBorderColor = myFocusedBorderColor
            , keys = myKeys
            }


-- workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1:web", "2:code", "3:chat", "4:mail", "5:media", "6:docs", "7:dl", "8:games", "9:other" ]

-- terminal
myTerminal :: String
myTerminal = "urxvtc"

-- launcher
myLauncher :: String
myLauncher = "dmenu_run -nb '#232323' -nf '#9fbc00' -sb '#9fbc00' -sf '#141414' -p '$'"

-- window border size
myBorderWidth :: Dimension
myBorderWidth = 1

-- window border colors
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor = "#141414"
myFocusedBorderColor = "#e0e0e0"

-- hooks --
-- switch apps to workspace
myManageHook :: ManageHook
myManageHook = composeAll . concat $
                [[isFullscreen                      --> doFullFloat
                , className =? "Xmessage"           --> doCenterFloat
                , className =? "Gimp"               --> doShift "9:other"
                , className =? "Pidgin"             --> doShift "3:chat"
                , className =? "Skype"              --> doShift "3:chat"
                , className =? "Thunderbird"        --> doShift "4:mail"
                , className =? "MPlayer"            --> doShift "5:media"
                , className =? "SMPlayer"           --> doShift "5:media"
                , className =? "Wine"               --> doShift "8:games"
                , title     =? "Minecraft Launcher" --> doShift "8:games"
                , title     =? "Minecraft Launcher" --> doFloat
                , fmap ("libreoffice" `isInfixOf`) className --> doShift "5:doc"
                , className =? "MPlayer"            --> (ask >>= doF . W.sink)
                ]]

-- layout
myLayoutHook = onWorkspace "3:chat" imLayout $ onWorkspace "4:mail" webL $ onWorkspace "5:media" fullL $ onWorkspace "9:other" gimpLayout $ standardLayouts
    where
        standardLayouts = avoidStruts $ (tiled ||| reflectTiled ||| Mirror tiled ||| Grid ||| Full ||| simpleTabbed)

        --Layouts
        tiled = smartBorders (ResizableTall 1 (2/100) (1/2) [])
        reflectTiled = (reflectHoriz tiled)
        full = noBorders Full

        --Im Layout
        imLayout = avoidStruts $ smartBorders $ withIM ratio pidginRoster $ reflectHoriz $ withIM skypeRatio skypeRoster (tiled ||| reflectTiled ||| Grid) where
                chatLayout = Grid
                ratio = (1%9)
                skypeRatio = (1%8)
                pidginRoster = And (ClassName "Pidgin") (Role "buddy_list")
                skypeRoster = (ClassName "Skype") `And`
                               (Not (Title "Options")) `And`
                               (Not (Role "Chats")) `And`
                               (Not (Role "CallWindowForm"))

        webL = avoidStruts $ full ||| simpleTabbed ||| tiled ||| reflectHoriz tiled

        gimpLayout = withIM (0.11) (Role "gimp-toolbox") $
                reflectHoriz $
                withIM (0.15) (Role "gimp-dock") Full

        --VirtualLayout
        fullL = avoidStruts $ full


-- keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn myLauncher)

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

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

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
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
