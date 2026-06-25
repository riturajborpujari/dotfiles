hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@144",
    position = "0x0",
    scale    = 1,
	bitdepth = 10,
	cm		 = "srgb",
})

local terminal			= "kitty"
local launcher    		= "tofi-drun --drun-launch true"
local toggleAudioCtl	= "pidof pavucontrol && kill -2 $(pidof pavucontrol) || pavucontrol"
local meStream			= "ffplay -max_delay 0 -analyzeduration 0 -fflags +nobuffer -flags +low_delay -video_size 1080x720 -vf crop=w=500:h=450:x=420:y=150,hflip /dev/video0"

-- Event Handlers
hl.on("hyprland.start", function ()
	hl.exec_cmd("eww open-many bar paper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd("systemctl --user restart xdg-desktop-portal-hyprland")
end)

hl.on("window.active", function (window)
	if (window.active ~= nil) then
		hl.exec_cmd("eww update 'activeWindow=" .. window.title .. "'")
	else
		hl.exec_cmd("eww update 'activeWindow=Desktop'")
	end
end)

hl.on("window.destroy", function ()
	window = hl.get_active_window()
	if (window == nil) then
		hl.exec_cmd("eww update 'activeWindow=Desktop'")
	end
end)

hl.on("window.title", function (window)
	-- TODO: Check if a Title change for a non-active window affects the 
	--		 active window title being displayed
	hl.exec_cmd("eww update 'activeWindow=" .. window.title .. "'")
end)

hl.on("workspace.active", function (workspace)
	hl.exec_cmd("eww update activeWorkspaceId=" .. workspace.name)
end)

hl.on("screenshare.state", function (active, type, name)
	if (active == true) then
		hl.notification.create({
			text = "screenshare Active: " .. ", " .. type .. ", " .. name,
			timeout = 5000,
			icon = "ok",
		})
	else 
		hl.notification.create({
			text = "screenshare End: " .. ", " .. type .. ", " .. name,
			timeout = 5000,
			icon = "ok",
		})
	end
end)

-- Environment variables
hl.env("XCURSOR_SIZE"                        ,"24")
hl.env("HYPRCURSOR_SIZE"                     ,"24")
hl.env("GDK_DPI_SCALE"                       ,"1.3333")
hl.env("QT_SCALE_FACTOR"                     ,"1.3333")
hl.env("XDG_CURRENT_DESKTOP"                 ,"Hyprland")
hl.env("XDG_SESSION_TYPE"                    ,"wayland")
hl.env("XDG_SESSION_DESKTOP"                 ,"Hyprland")
hl.env("QT_QPA_PLATFORM"                     ,"wayland")
hl.env("QT_QPA_PLATFORMTHEME"                ,"qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION" ,"1")
hl.env("XCURSOR_SIZE"                        ,"24")
hl.env("HYPRCURSOR_THEME"                    ,"rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE"                     ,"36")
hl.env("GRIM_DEFAULT_DIR"                    ,"/home/rituraj/pictures/screenshots")
hl.env("WLLOCK_MEDIA_FILE"                   ,"$HOME/.local/share/wllock/lockscreen.mp4")
hl.env("GSK_RENDERER"                        ,"vulkan")
hl.env("GTK_THEME"                           ,"Gruvbox-Dark")

-- Permission Config
hl.config({
  ecosystem = {
    enforce_permissions = false,
  },
})
--hl.permission(".*", "screencopy", "ask")
--hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "ask")

hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,
        border_size = 1,
        col = {
            active_border   = "rgba(484848ff)",
            inactive_border = "rgba(282828ff)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = false,
            size      = 5,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Layout Configs
-- Dwindle
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
		force_split    = 2,
    },
})
-- Master
hl.config({
    master = {
		mfact = 0.59,
    },
})
-- Scrolling
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

-- Default Background
hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
		background_color		= 0x181818
    },
})

-- Input Config
hl.config({
    input = {
        kb_layout	 = "us+rupeesign(4)+level3(ralt_switch),in(asm)",
        kb_variant 	 = "",
        kb_model   	 = "",
        kb_options 	 = "grp:alt_caps_toggle",
        kb_rules   	 = "",
        follow_mouse = 0,
        sensitivity  = 0,
        touchpad     = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- Keybindings
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return",		hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",			hl.dsp.window.close())
hl.bind(mainMod .. " + Backspace",	hl.dsp.window.float(true))
hl.bind(mainMod .. " + E",			hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + R", 			hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + S", 			hl.dsp.exec_cmd("sh -c slurp -d | wl-copy"))
hl.bind(mainMod .. " + X", 			hl.dsp.exec_cmd("emacsclient --create-frame"))
hl.bind(mainMod .. " + Space",		hl.dsp.exec_cmd("/home/rituraj/.config/hypr/superscript.sh"))

-- Widget Controls
hl.bind(mainMod .. " + F9",  hl.dsp.exec_cmd(meStream))
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd(toggleAudioCtl))

-- Window Controls
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle"}))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
-- Focus
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.move({ direction = "down" }))
-- Resize
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.resize({ x = -80, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.resize({ x = 80, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -80, relative = true }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 80, relative = true }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspace Controls
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + CTRL + Return",			hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + CTRL + Return", 	hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + tab",					hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + tab",			hl.dsp.focus({ workspace = "e-1" }))

-- Audio Controls
hl.bind("XF86AudioRaiseVolume",			hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),	{ locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", 		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),  	{ locked = true, repeating = true })
hl.bind("ALT + XF86AudioRaiseVolume",	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"),	{ locked = true, repeating = true })
hl.bind("ALT + XF86AudioLowerVolume", 	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"),	{ locked = true, repeating = true })
hl.bind("XF86AudioMute",        		hl.dsp.exec_cmd("playerctl play-pause"),					   	{ locked = true, repeating = true })
hl.bind(mainMod .. " + XF86AudioMute",  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), 	{ locked = true, repeating = true })

-- Player Controls
hl.bind("CTRL + XF86AudioRaiseVolume",			hl.dsp.exec_cmd("playerctl position 5+"),	{ locked = true, repeating = true })
hl.bind("CTRL + XF86AudioLowerVolume", 			hl.dsp.exec_cmd("playerctl position 5-"),  	{ locked = true, repeating = true })
hl.bind("CTRL + SHIFT + XF86AudioRaiseVolume",	hl.dsp.exec_cmd("playerctl position 10+"),	{ locked = true, repeating = true })
hl.bind("CTRL + SHIFT + XF86AudioLowerVolume", 	hl.dsp.exec_cmd("playerctl position 10-"), 	{ locked = true, repeating = true })

-- Screenshot Controls
hl.bind(mainMod .. "+ P",			hl.dsp.exec_cmd('grim               "${GRIM_DEFAULT_DIR}/$(date \'+%d%b_%Hh%Mm%Ss.png\')"'))
hl.bind(mainMod .. "+ CTRL + P",	hl.dsp.exec_cmd('grim -g "$(slurp)" "${GRIM_DEFAULT_DIR}/$(date \'+%d%b_%Hh%Mm%Ss.png\')"'))

-- Zooming
local MAX_ZOOM = 7
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 3

local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + Z", zoom)
hl.bind("SUPER + equal", function()
    zoom(0.5)
end)
hl.bind("SUPER + minus", function()
    zoom(-0.5)
end)

-- Window Rules
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
	name  = "volume-control-float",
	match = { class = "org.pulseaudio.pavucontrol" },
	float = true
})

hl.window_rule({
	name  = "ffplay-bottom-right",
	match = { class = "ffplay" },
	float =	true,
	pin   = true,
	move  = "(monitor_w-window_w) (monitor_h-window_h - 40)",
	no_initial_focus = true,
})

hl.window_rule({
	name = "emacs-fullscreen",
	match = { class = "Emacs" },
	fullscreen = true,
})

hl.window_rule({
	name   = "xdg-portal-centered",
	match  = {class = "xdg-desktop-portal-gtk" },
	center = true,
	size   = "(monitor_w/1.7) (monitor_h/1.5)",
})

hl.window_rule({
	name   = "hyprland-share-picker-centered",
	match  = {class = "hyprland-share-picker" },
	center = true,
	size   = "(monitor_w/1.7) (monitor_h/1.5)",
})
