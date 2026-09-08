hl.monitor({
    output   = "",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1,
	mirror = "DP-1"
})

hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@144",
    position = "0x0",
    scale    = 1,
	bitdepth = 10,
	cm		 = "srgb",
})

local terminal		   = "xdg-terminal-exec"
local launcher    	   = "tofi-drun --drun-launch true"
local superscript      = os.getenv("HOME") .. "/.config/hypr/superscript.sh"
local toggleAudioCtl   = "pidof pavucontrol && kill -2 $(pidof pavucontrol) || pavucontrol"
local meStream         = "ffplay -max_delay 0 -analyzeduration 0 -fflags +nobuffer -flags +low_delay -video_size 1080x720 -vf crop=w=500:h=300:x=420:y=270,hflip /dev/video0"
local screenshot       = 'grim "${GRIM_DEFAULT_DIR}/$(date \'+%d%b_%Hh%Mm%Ss.png\')"'
local regionScreenshot = 'grim -g "$(slurp)" "${GRIM_DEFAULT_DIR}/$(date \'+%d%b_%Hh%Mm%Ss.png\')"'

local startupCmds   = {
	"eww open-many statusbar titlebar",
	"sh ~/.config/hypr/hyprtracker.sh",
	"wlframe ~/Pictures/wallpaper.jpg",
	"hypridle",
}

-- Event Handlers
hl.on("hyprland.start", function ()
	-- Indicate graphical session start
	hl.exec_cmd("systemctl --user start hyprland-session.target")	

	for _, cmd in ipairs(startupCmds) do
		hl.exec_cmd(cmd)
	end
end)

hl.on("screenshare.state", function (active, type, name)
	--if (active == true) then
	--	hl.notification.create({
	--		text = "screenshare Active: " .. ", " .. type .. ", " .. name,
	--		timeout = 5000,
	--		icon = "ok",
	--	})
	--else 
	--	hl.notification.create({
	--		text = "screenshare End: " .. ", " .. type .. ", " .. name,
	--		timeout = 5000,
	--		icon = "ok",
	--	})
	--end
end)

-- Environment variables
hl.env("GDK_DPI_SCALE",                        "1.3333")
hl.env("QT_SCALE_FACTOR",                      "1.3333")
hl.env("XDG_CURRENT_DESKTOP",                  "Hyprland")
hl.env("XDG_SESSION_TYPE",                     "wayland")
hl.env("XDG_SESSION_DESKTOP",                  "Hyprland")
hl.env("QT_QPA_PLATFORM",                      "wayland")
hl.env("QT_QPA_PLATFORMTHEME",                 "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION",  "1")
hl.env("XCURSOR_SIZE",                         "32")
hl.env("XCURSOR_THEME",                        "Adwaita")
hl.env("HYPRCURSOR_THEME",                     "Adwaita")
hl.env("HYPRCURSOR_SIZE",                      "32")
hl.env("GRIM_DEFAULT_DIR",                     os.getenv("HOME") .. "/Pictures/Screenshots")
hl.env("GSK_RENDERER",                         "vulkan")

--hl.permission(".*", "screencopy", "ask")
--hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "ask")
hl.config({
	ecosystem = {
		enforce_permissions = false,
	},

    general = {
        gaps_in  = 0,
        gaps_out = 0,
        border_size = 1,
        col = {
            active_border   = "rgba(888888ff)",
            inactive_border = "rgba(181818ff)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "master",
    },
	master = {
		mfact = 0.59,
	},
    dwindle = {
        preserve_split = true,
		force_split    = 2,
    },

	cursor = {
		enable_hyprcursor = true,
	},

    decoration = {
        rounding         = 0,
        rounding_power   = 2,
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


	input = {
		kb_layout     = "us+rupeesign(4)+level3(ralt_switch),in(asm)",
		kb_variant    = "",
		kb_model      = "",
		kb_options    = "grp:alt_caps_toggle",
		kb_rules      = "",
		follow_mouse  = 0,
		sensitivity   = 0.0,
		accel_profile = "flat", -- No pointer acceleration please

		touchpad      = {
			natural_scroll = false,
		},
	},

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
		background_color		= 0x181818,
    },

	group = {
		auto_group               = true,
		group_on_movetoworkspace = true,
		col                      = {
			border_active			= "#a0a0a0",
		},
		groupbar = {
			font_family         = "Iosevka",
			font_size           = 18,
			height              = 22,
			enabled             = true,
			text_color          = "#efefef",
			text_color_inactive = "#a0a0a0",
			col                 = {
				active				= "#a0a0a0",
				inactive 			= "#484848",
			},
		},
	},
})

-- Keybindings
local mainMod = "SUPER"

hl.bind(mainMod .. " + SHIFT + Q",	hl.dsp.exit())
hl.bind(mainMod .. " + Return",		hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + X",			hl.dsp.exec_cmd("emacsclient --create-frame"))
hl.bind(mainMod .. " + Q",			hl.dsp.window.close())
hl.bind(mainMod .. " + Backspace",	hl.dsp.window.float(true))
hl.bind(mainMod .. " + E",			hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + R", 			hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + S", 			hl.dsp.exec_cmd("sh -c slurp -d | wl-copy"))
hl.bind(mainMod .. " + Space",	    hl.dsp.exec_cmd(superscript))

hl.bind(mainMod .. " + G",			hl.dsp.group.toggle())
hl.bind("ALT + Tab",				hl.dsp.group.next())

-- Widget Controls
hl.bind(mainMod .. " + F9",  hl.dsp.exec_cmd(meStream))
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd(toggleAudioCtl))

-- Window Controls
hl.bind(mainMod .. " + F",
		hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle"}))

-- Focus Change
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Position Change
hl.bind(mainMod .. " + ALT + h",
		hl.dsp.window.move({ direction = "left", group_aware = true }))
hl.bind(mainMod .. " + ALT + l",
		hl.dsp.window.move({ direction = "right", group_aware = true }))
hl.bind(mainMod .. " + ALT + k",
		hl.dsp.window.move({ direction = "up", group_aware = true }))
hl.bind(mainMod .. " + ALT + j",
		hl.dsp.window.move({ direction = "down", group_aware = true }))

-- Size Change
hl.bind(mainMod .. " + SHIFT + h",
		hl.dsp.window.resize({ x = -80, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + l",
		hl.dsp.window.resize({ x = 80, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + k",
		hl.dsp.window.resize({ x = 0, y = -80, relative = true }))
hl.bind(mainMod .. " + SHIFT + j",
		hl.dsp.window.resize({ x = 0, y = 80, relative = true }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspace Controls
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,
			hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,
			hl.dsp.window.move({ workspace = i }))
end

--hl.bind(mainMod .. " + CTRL + Return",			hl.dsp.workspace.toggle_special("magic"))
--hl.bind(mainMod .. " + SHIFT + CTRL + Return", 	hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + tab",
		hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + tab",
		hl.dsp.focus({ workspace = "e-1" }))

-- Audio Controls
hl.bind("XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume",
		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("ALT + XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"))
hl.bind("ALT + XF86AudioLowerVolume",
		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. " + XF86AudioMute",
		hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Player Controls
hl.bind("CTRL + XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("playerctl position 5+"))
hl.bind("CTRL + XF86AudioLowerVolume",
		hl.dsp.exec_cmd("playerctl position 5-"))
hl.bind("CTRL + SHIFT + XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("playerctl position 10+"))
hl.bind("CTRL + SHIFT + XF86AudioLowerVolume",
		hl.dsp.exec_cmd("playerctl position 10-"))

-- Screenshot Controls
hl.bind(mainMod .. "+ P",        hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. "+ CTRL + P", hl.dsp.exec_cmd(regionScreenshot))

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
	match = { class = "emacs" },
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
