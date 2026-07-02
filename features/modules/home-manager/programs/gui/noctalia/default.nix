{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  kittyExe = lib.getExe pkgs.kitty;
  colors = config.internal.theme.colors;
in
{
  home.packages = with pkgs; [ noctalia-shell ];
  home.file.".config/noctalia/settings.json".text = /* json */ ''
    {
            "settingsVersion": 59,
            "bar": {
              "barType": "simple",
              "position": "left",
              "density": "comfortable",
              "showOutline": false,
              "showCapsule": false,
              "capsuleOpacity": 1,
              "capsuleColorKey": "none",
              "widgetSpacing": 1,
              "contentPadding": 0,
              "fontScale": 1,
              "enableExclusionZoneInset": false,
              "backgroundOpacity": 0.93,
              "useSeparateOpacity": false,
              "marginVertical": 4,
              "marginHorizontal": 4,
              "frameThickness": 8,
              "frameRadius": 12,
              "outerCorners": false,
              "hideOnOverview": true,
              "displayMode": "always_visible",
              "autoHideDelay": 500,
              "autoShowDelay": 150,
              "showOnWorkspaceSwitch": true,
              "widgets": {
                "left": [
                  {
                    "displayMode": "forceOpen",
                    "iconColor": "primary",
                    "id": "KeyboardLayout",
                    "showIcon": true,
                    "textColor": "primary"
                  },
                  {
                    "clockColor": "primary",
                    "customFont": "",
                    "formatHorizontal": "HH:mm",
                    "formatVertical": "HH mm ss",
                    "id": "Clock",
                    "tooltipFormat": "",
                    "useCustomFont": false
                  },
                  {
                    "displayMode": "alwaysShow",
                    "iconColor": "primary",
                    "id": "Volume",
                    "middleClickCommand": "pwvucontrol || pavucontrol",
                    "textColor": "primary"
                  },
                  {
                    "colorName": "primary",
                    "hideWhenIdle": false,
                    "id": "AudioVisualizer",
                    "width": 75
                  },
                  {
                    "displayMode": "alwaysShow",
                    "iconColor": "primary",
                    "id": "Microphone",
                    "middleClickCommand": "pwvucontrol || pavucontrol",
                    "textColor": "primary"
                  },
                  {
                    "applyToAllMonitors": false,
                    "displayMode": "alwaysShow",
                    "iconColor": "primary",
                    "id": "Brightness",
                    "textColor": "primary"
                  }
                ],
                "center": [
                  {
                    "characterCount": 2,
                    "colorizeIcons": false,
                    "emptyColor": "primary",
                    "enableScrollWheel": false,
                    "focusedColor": "secondary",
                    "followFocusedScreen": false,
                    "fontWeight": "bold",
                    "groupedBorderOpacity": 1,
                    "hideUnoccupied": false,
                    "iconScale": 0.8,
                    "id": "Workspace",
                    "labelMode": "index",
                    "occupiedColor": "primary",
                    "pillSize": 0.65,
                    "showApplications": false,
                    "showApplicationsHover": false,
                    "showBadge": true,
                    "showLabelsOnlyWhenOccupied": true,
                    "unfocusedIconsOpacity": 1
                  }
                ],
                "right": [
                  {
                    "deviceNativePath": "__default__",
                    "displayMode": "icon-always",
                    "hideIfIdle": true,
                    "hideIfNotDetected": false,
                    "id": "Battery",
                    "showNoctaliaPerformance": false,
                    "showPowerProfiles": false
                  },
                  {
                    "colorizeSystemIcon": "primary",
                    "colorizeSystemText": "none",
                    "customIconPath": "",
                    "enableColorization": true,
                    "icon": "rocket",
                    "iconColor": "none",
                    "id": "Launcher",
                    "useDistroLogo": false
                  },
                  {
                    "displayMode": "alwaysShow",
                    "iconColor": "primary",
                    "id": "Network",
                    "textColor": "primary"
                  },
                  {
                    "displayMode": "alwaysShow",
                    "iconColor": "primary",
                    "id": "Bluetooth",
                    "textColor": "primary"
                  },
                  {
                    "compactMode": false,
                    "diskPath": "/",
                    "iconColor": "primary",
                    "id": "SystemMonitor",
                    "showCpuCores": false,
                    "showCpuFreq": false,
                    "showCpuTemp": true,
                    "showCpuUsage": true,
                    "showDiskAvailable": false,
                    "showDiskUsage": false,
                    "showDiskUsageAsPercent": true,
                    "showGpuTemp": false,
                    "showLoadAverage": false,
                    "showMemoryAsPercent": true,
                    "showMemoryUsage": true,
                    "showNetworkStats": false,
                    "showSwapUsage": false,
                    "textColor": "primary",
                    "useMonospaceFont": true,
                    "usePadding": false
                  },
                  {
                    "blacklist": [],
                    "chevronColor": "primary",
                    "colorizeIcons": false,
                    "drawerEnabled": true,
                    "hidePassive": false,
                    "id": "Tray",
                    "pinned": []
                  }
                ]
              },
              "mouseWheelAction": "content",
              "reverseScroll": false,
              "mouseWheelWrap": true,
              "middleClickAction": "none",
              "middleClickFollowMouse": false,
              "middleClickCommand": "",
              "rightClickAction": "controlCenter",
              "rightClickFollowMouse": true,
              "rightClickCommand": "",
              "screenOverrides": [
                {
                  "enabled": true,
                  "name": "eDP-1"
                }
              ]
            },
            "general": {
              "avatarImage": "/home/draco/.face",
              "dimmerOpacity": 0,
              "showScreenCorners": false,
              "forceBlackScreenCorners": false,
              "scaleRatio": 1,
              "radiusRatio": 0.25,
              "iRadiusRatio": 0.6,
              "boxRadiusRatio": 1,
              "screenRadiusRatio": 1,
              "animationSpeed": 2,
              "animationDisabled": true,
              "compactLockScreen": false,
              "lockScreenAnimations": false,
              "lockOnSuspend": true,
              "showSessionButtonsOnLockScreen": true,
              "showHibernateOnLockScreen": true,
              "enableLockScreenMediaControls": false,
              "enableShadows": true,
              "enableBlurBehind": false,
              "shadowDirection": "bottom_right",
              "shadowOffsetX": 2,
              "shadowOffsetY": 3,
              "language": "",
              "allowPanelsOnScreenWithoutBar": true,
              "showChangelogOnStartup": true,
              "telemetryEnabled": false,
              "enableLockScreenCountdown": true,
              "lockScreenCountdownDuration": 15000,
              "autoStartAuth": false,
              "allowPasswordWithFprintd": true,
              "clockStyle": "custom",
              "clockFormat": "hh\\nmm",
              "passwordChars": false,
              "lockScreenMonitors": [],
              "lockScreenBlur": 0,
              "lockScreenTint": 0,
              "keybinds": {
                "keyUp": [
                  "Up"
                ],
                "keyDown": [
                  "Down"
                ],
                "keyLeft": [
                  "Left"
                ],
                "keyRight": [
                  "Right"
                ],
                "keyEnter": [
                  "Return",
                  "Enter"
                ],
                "keyEscape": [
                  "Esc"
                ],
                "keyRemove": [
                  "Del"
                ]
              },
              "reverseScroll": false,
              "smoothScrollEnabled": true
            },
            "ui": {
              "fontDefault": "Sans",
              "fontFixed": "monospace",
              "fontDefaultScale": 1,
              "fontFixedScale": 1,
              "tooltipsEnabled": true,
              "scrollbarAlwaysVisible": true,
              "boxBorderEnabled": true,
              "panelBackgroundOpacity": 1,
              "translucentWidgets": false,
              "panelsAttachedToBar": true,
              "settingsPanelMode": "window",
              "settingsPanelSideBarCardStyle": true
            },
            "location": {
              "name": "",
              "weatherEnabled": false,
              "weatherShowEffects": true,
              "weatherTaliaMascotAlways": false,
              "useFahrenheit": false,
              "use12hourFormat": false,
              "showWeekNumberInCalendar": false,
              "showCalendarEvents": true,
              "showCalendarWeather": true,
              "analogClockInCalendar": false,
              "firstDayOfWeek": 1,
              "hideWeatherTimezone": false,
              "hideWeatherCityName": false,
              "autoLocate": false
            },
            "calendar": {
              "cards": [
                {
                  "enabled": true,
                  "id": "calendar-header-card"
                },
                {
                  "enabled": true,
                  "id": "calendar-month-card"
                },
                {
                  "enabled": false,
                  "id": "weather-card"
                }
              ]
            },
            "wallpaper": {
              "enabled": true,
              "overviewEnabled": false,
              "directory": "/nixos-config/features/users/${user}/wallpapers",
              "monitorDirectories": [],
              "enableMultiMonitorDirectories": false,
              "showHiddenFiles": false,
              "viewMode": "recursive",
              "setWallpaperOnAllMonitors": true,
              "linkLightAndDarkWallpapers": true,
              "fillMode": "crop",
              "fillColor": "#000000",
              "useSolidColor": false,
              "automationEnabled": true,
              "wallpaperChangeMode": "random",
              "randomIntervalSec": 180,
              "transitionDuration": 1500,
              "transitionType": [
                "stripes"
              ],
              "skipStartupTransition": false,
              "transitionEdgeSmoothness": 0.05,
              "panelPosition": "follow_bar",
              "hideWallpaperFilenames": false,
              "useOriginalImages": true,
              "overviewBlur": 0.4,
              "overviewTint": 0.6,
              "useWallhaven": false,
              "wallhavenQuery": "",
              "wallhavenSorting": "relevance",
              "wallhavenOrder": "desc",
              "wallhavenCategories": "111",
              "wallhavenPurity": "100",
              "wallhavenRatios": "",
              "wallhavenApiKey": "",
              "wallhavenResolutionMode": "atleast",
              "wallhavenResolutionWidth": "",
              "wallhavenResolutionHeight": "",
              "sortOrder": "name",
              "favorites": []
            },
            "appLauncher": {
              "enableClipboardHistory": false,
              "autoPasteClipboard": false,
              "enableClipPreview": true,
              "clipboardWrapText": true,
              "enableClipboardSmartIcons": true,
              "enableClipboardChips": true,
              "clipboardWatchTextCommand": "wl-paste --type text --watch cliphist store",
              "clipboardWatchImageCommand": "wl-paste --type image --watch cliphist store",
              "position": "center",
              "pinnedApps": [
                "throne",
                "blueman-manager",
                "org.telegram.desktop"
              ],
              "sortByMostUsed": true,
              "terminalCommand": "${kittyExe} --hold --single-instance",
              "customLaunchPrefixEnabled": false,
              "customLaunchPrefix": "",
              "viewMode": "list",
              "showCategories": true,
              "iconMode": "tabler",
              "showIconBackground": false,
              "enableSettingsSearch": true,
              "enableWindowsSearch": true,
              "enableSessionSearch": true,
              "ignoreMouseInput": false,
              "screenshotAnnotationTool": "",
              "overviewLayer": true,
              "density": "default"
            },
            "controlCenter": {
              "position": "close_to_bar_button",
              "diskPath": "/",
              "shortcuts": {
                "left": [
                  {
                    "id": "Network"
                  },
                  {
                    "id": "Bluetooth"
                  },
                  {
                    "id": "WallpaperSelector"
                  },
                  {
                    "id": "NoctaliaPerformance"
                  }
                ],
                "right": [
                  {
                    "id": "Notifications"
                  },
                  {
                    "id": "PowerProfile"
                  },
                  {
                    "id": "KeepAwake"
                  },
                  {
                    "id": "NightLight"
                  }
                ]
              },
              "cards": [
                {
                  "enabled": false,
                  "id": "weather-card"
                },
                {
                  "enabled": true,
                  "id": "media-sysmon-card"
                },
                {
                  "enabled": true,
                  "id": "audio-card"
                },
                {
                  "enabled": true,
                  "id": "brightness-card"
                },
                {
                  "enabled": true,
                  "id": "shortcuts-card"
                },
                {
                  "enabled": true,
                  "id": "profile-card"
                }
              ]
            },
            "systemMonitor": {
              "cpuWarningThreshold": 80,
              "cpuCriticalThreshold": 90,
              "tempWarningThreshold": 80,
              "tempCriticalThreshold": 90,
              "gpuWarningThreshold": 80,
              "gpuCriticalThreshold": 90,
              "memWarningThreshold": 80,
              "memCriticalThreshold": 90,
              "swapWarningThreshold": 80,
              "swapCriticalThreshold": 90,
              "diskWarningThreshold": 80,
              "diskCriticalThreshold": 90,
              "diskAvailWarningThreshold": 20,
              "diskAvailCriticalThreshold": 10,
              "batteryWarningThreshold": 50,
              "batteryCriticalThreshold": 10,
              "enableDgpuMonitoring": false,
              "useCustomColors": false,
              "warningColor": "${colors.base0E}",
              "criticalColor": "${colors.base08}",
              "externalMonitor": "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor"
            },
            "noctaliaPerformance": {
              "disableWallpaper": true,
              "disableDesktopWidgets": true
            },
            "dock": {
              "enabled": false,
              "position": "bottom",
              "displayMode": "auto_hide",
              "dockType": "floating",
              "backgroundOpacity": 1,
              "floatingRatio": 1,
              "size": 1,
              "onlySameOutput": true,
              "monitors": [],
              "pinnedApps": [],
              "colorizeIcons": false,
              "showLauncherIcon": false,
              "launcherPosition": "end",
              "launcherUseDistroLogo": false,
              "launcherIcon": "",
              "launcherIconColor": "none",
              "pinnedStatic": false,
              "inactiveIndicators": false,
              "groupApps": false,
              "groupContextMenuMode": "extended",
              "groupClickAction": "cycle",
              "groupIndicatorStyle": "dots",
              "deadOpacity": 0.6,
              "animationSpeed": 1,
              "sitOnFrame": false,
              "showDockIndicator": false,
              "indicatorThickness": 3,
              "indicatorColor": "primary",
              "indicatorOpacity": 0.6
            },
            "network": {
              "bluetoothRssiPollingEnabled": false,
              "bluetoothRssiPollIntervalMs": 60000,
              "networkPanelView": "ethernet",
              "wifiDetailsViewMode": "list",
              "bluetoothDetailsViewMode": "grid",
              "bluetoothHideUnnamedDevices": false,
              "disableDiscoverability": false,
              "bluetoothAutoConnect": true
            },
            "sessionMenu": {
              "enableCountdown": true,
              "countdownDuration": 10000,
              "position": "center",
              "showHeader": true,
              "showKeybinds": true,
              "largeButtonsStyle": false,
              "largeButtonsLayout": "single-row",
              "powerOptions": [
                {
                  "action": "lock",
                  "command": "",
                  "countdownEnabled": true,
                  "enabled": true,
                  "keybind": "1"
                },
                {
                  "action": "suspend",
                  "command": "",
                  "countdownEnabled": true,
                  "enabled": true,
                  "keybind": "2"
                },
                {
                  "action": "hibernate",
                  "command": "",
                  "countdownEnabled": true,
                  "enabled": true,
                  "keybind": "3"
                },
                {
                  "action": "reboot",
                  "command": "",
                  "countdownEnabled": true,
                  "enabled": true,
                  "keybind": "4"
                },
                {
                  "action": "logout",
                  "command": "",
                  "countdownEnabled": true,
                  "enabled": true,
                  "keybind": "5"
                },
                {
                  "action": "shutdown",
                  "command": "",
                  "countdownEnabled": true,
                  "enabled": true,
                  "keybind": "6"
                },
                {
                  "action": "rebootToUefi",
                  "command": "",
                  "countdownEnabled": true,
                  "enabled": true,
                  "keybind": "7"
                },
                {
                  "action": "userspaceReboot",
                  "command": "",
                  "countdownEnabled": true,
                  "enabled": false,
                  "keybind": ""
                }
              ]
            },
            "notifications": {
              "enabled": true,
              "enableMarkdown": false,
              "density": "compact",
              "monitors": [],
              "location": "top_right",
              "overlayLayer": true,
              "backgroundOpacity": 0.25,
              "respectExpireTimeout": false,
              "lowUrgencyDuration": 1,
              "normalUrgencyDuration": 2,
              "criticalUrgencyDuration": 3,
              "clearDismissed": true,
              "saveToHistory": {
                "low": true,
                "normal": true,
                "critical": true
              },
              "sounds": {
                "enabled": false,
                "volume": 0.5,
                "separateSounds": false,
                "criticalSoundFile": "",
                "normalSoundFile": "",
                "lowSoundFile": "",
                "excludedApps": "discord,firefox,chrome,chromium,edge"
              },
              "enableMediaToast": false,
              "enableKeyboardLayoutToast": false,
              "enableBatteryToast": true
            },
            "osd": {
              "enabled": true,
              "location": "top_right",
              "autoHideMs": 2000,
              "overlayLayer": true,
              "backgroundOpacity": 1,
              "enabledTypes": [
                0,
                1,
                2
              ],
              "monitors": []
            },
            "audio": {
              "volumeStep": 5,
              "volumeOverdrive": false,
              "spectrumFrameRate": 30,
              "visualizerType": "wave",
              "spectrumMirrored": true,
              "mprisBlacklist": [],
              "preferredPlayer": "",
              "volumeFeedback": false,
              "volumeFeedbackSoundFile": ""
            },
            "brightness": {
              "brightnessStep": 5,
              "enforceMinimum": true,
              "enableDdcSupport": false,
              "backlightDeviceMappings": []
            },
            "colorSchemes": {
              "useWallpaperColors": false,
              "predefinedScheme": "CurrentTheme",
              "darkMode": true,
              "schedulingMode": "off",
              "manualSunrise": "06:30",
              "manualSunset": "18:30",
              "generationMethod": "tonal-spot",
              "monitorForColors": "",
              "syncGsettings": true
            },
            "templates": {
              "activeTemplates": [],
              "enableUserTheming": false
            },
            "nightLight": {
              "enabled": false,
              "forced": false,
              "autoSchedule": true,
              "nightTemp": "4000",
              "dayTemp": "6500",
              "manualSunrise": "06:30",
              "manualSunset": "18:30"
            },
            "hooks": {
              "enabled": false,
              "wallpaperChange": "",
              "darkModeChange": "",
              "screenLock": "",
              "screenUnlock": "",
              "performanceModeEnabled": "",
              "performanceModeDisabled": "",
              "startup": "",
              "session": "",
              "colorGeneration": ""
            },
            "plugins": {
              "autoUpdate": false,
              "notifyUpdates": true
            },
            "idle": {
              "enabled": true,
              "screenOffTimeout": 630,
              "lockTimeout": 1200,
              "suspendTimeout": 2700,
              "fadeDuration": 2,
              "screenOffCommand": "",
              "lockCommand": "",
              "suspendCommand": "",
              "resumeScreenOffCommand": "",
              "resumeLockCommand": "",
              "resumeSuspendCommand": "",
              "customCommands": "[]"
            },
            "desktopWidgets": {
              "enabled": true,
              "overviewEnabled": true,
              "gridSnap": true,
              "gridSnapScale": false,
              "monitorWidgets": [
                {
                  "name": "eDP-1",
                  "widgets": [
                    {
                      "hideMode": "hidden",
                      "id": "MediaPlayer",
                      "roundedCorners": false,
                      "scale": 1.2247273738958495,
                      "showAlbumArt": true,
                      "showBackground": true,
                      "showButtons": true,
                      "showVisualizer": true,
                      "visualizerType": "linear",
                      "x": 1440,
                      "y": 980
                    }
                  ]
                }
              ]
            }
          }
  '';
  home.file.".config/noctalia/colorschemes/CurrentTheme/CurrentTheme.json".text = /* json */ ''
    {
                  "dark": {
                    "mError": "${colors.base08}",
                    "mHover": "${colors.base0E}",
                    "mOnError": "${colors.base11}",
                    "mOnHover": "${colors.base11}",
                    "mOnPrimary": "${colors.base11}",
                    "mOnSecondary": "${colors.base11}",
                    "mOnSurface": "${colors.base05}",
                    "mOnSurfaceVariant": "${colors.base17}", 
                    "mOnTertiary": "${colors.base11}",
                    "mOutline": "${colors.base04}",
                    "mPrimary": "${colors.base17}",
                    "mSecondary": "${colors.base12}",
                    "mShadow": "${colors.base11}",
                    "mSurface": "${colors.base00}",
                    "mSurfaceVariant": "${colors.base01}",
                    "mTertiary": "${colors.base0E}"
                  },
                  "light": {
                    "mError": "${colors.base08}",
                    "mHover": "${colors.base08}",
                    "mOnError": "${colors.base06}",
                    "mOnHover": "${colors.base05}",
                    "mOnPrimary": "${colors.base05}",
                    "mOnSecondary": "${colors.base05}",
                    "mOnSurface": "${colors.base00}",
                    "mOnSurfaceVariant": "${colors.base02}",
                    "mOnTertiary": "${colors.base05}",
                    "mOutline": "${colors.base06}",
                    "mPrimary": "${colors.base0D}",
                    "mSecondary": "${colors.base12}",
                    "mShadow": "${colors.base06}",
                    "mSurface": "${colors.base05}",
                    "mSurfaceVariant": "${colors.base07}",
                    "mTertiary": "${colors.base0E}"
                  },
                  "name": "CurrentTheme"
                }
  '';
}
