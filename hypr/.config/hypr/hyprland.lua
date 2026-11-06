-- ~/.config/hypr/hyprland.lua
-- Перенос конфига с hyprlang на Lua (Hyprland 0.55+)
-- Вики: https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------
-- monitor=HDMI-A-2, 3840x2160@60, auto, 1.5
hl.monitor({
	output = "HDMI-A-2",
	mode = "3840x2160@60",
	position = "auto",
	scale = 1.5,
})

-- Запасной вариант (был закомментирован):
-- hl.monitor({ output = "HDMI-A-2", mode = "2560x1440@60", position = "auto", scale = 1 })

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "wofi --show drun"

-------------------
---- AUTOSTART ----
-------------------
-- hl.on("hyprland.start", function()
-- 	hl.exec_cmd("uwsm app -- quickshell -c noctalia-shell")
-- end)
hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- noctalia")
	hl.exec_cmd("uwsm app -- hypridle")
end)
--

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("WLR_NO_HARDWARE_CURSORS", "1")

--------------------------
---- NOCTALIA COLORS  ----
--------------------------
-- Раньше было: source = ~/.config/hypr/noctalia/noctalia-colors.conf
-- В Lua нет `source` для hyprlang-файлов, поэтому парсим $переменные сами.
-- Если Noctalia уже умеет генерировать .lua — лучше заменить это на require().
local noctalia = {}
do
	local path = os.getenv("HOME") .. "/.config/hypr/noctalia/noctalia-colors.conf"
	local f = io.open(path, "r")
	if f then
		for line in f:lines() do
			local name, value = line:match("^%s*%$([%w_]+)%s*=%s*(.-)%s*$")
			if name and value then
				noctalia[name] = value
			end
		end
		f:close()
	end
end

-- Цвета рамок: если Noctalia задаёт свои переменные (посмотри имена в
-- noctalia-colors.conf и подставь их ниже), используем их, иначе — дефолт.
-- Достаём hex из любого формата: rgb(cba6f7), rgba(cba6f7ff), #cba6f7
local function toColor(v, alpha)
	if not v then
		return nil
	end
	local hex = v:match("%(([0-9a-fA-F]+)%)") or v:match("#?([0-9a-fA-F]+)")
	if not hex then
		return nil
	end
	if #hex == 6 then
		hex = hex .. (alpha or "ee")
	end
	return "rgba(" .. hex .. ")"
end

local primary = toColor(noctalia.primary)
local activeBorder = primary and { colors = { primary } }
	or { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }
local inactiveBorder = toColor(noctalia.outline, "aa") or "rgba(595959aa)"

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 7,
		border_size = 1,
		col = {
			active_border = activeBorder,
			inactive_border = inactiveBorder,
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
		-- pseudotile = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
		-- Пробуждение монитора с DPMS по мыши/клавише (после hypridle)
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
	},

	input = {
		kb_layout = "us,ru",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:win_space_toggle,caps:none",
		kb_rules = "",

		follow_mouse = 1,
		scroll_factor = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
		},
	},
})

--------------------
---- ANIMATIONS ----
--------------------
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })
-- borderangle из старого конфига: в новом API такого leaf может не быть,
-- если при загрузке выскочит ошибка про "borderangle" — просто удали строку.
-- hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })

---------------------------
---- PER-DEVICE CONFIG ----
---------------------------
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"
local altMod = "ALT"

-- Скриншот области в буфер
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))

-- Основные бинды
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- hl.bind(mainMod .. " + CTRL + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + CTRL + SHIFT + M", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + T",             hl.dsp.layout("togglesplit")) -- dwindle

-- Фокус по hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Переключение воркспейсов на ALT + [0-9],
-- перенос окна на SUPER + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 -> клавиша 0
	hl.bind(altMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Прокрутка воркспейсов колесом
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Перемещение/ресайз окон мышью
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Мультимедийные клавиши (bindel -> locked + repeating)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Управление плеером (bindl -> locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- Игнорировать запросы maximize от приложений (раскомментируй при желании):
-- hl.window_rule({
--     name = "suppress-maximize-events",
--     match = { class = ".*" },
--     suppress_event = "maximize",
-- })

-- Фикс перетаскивания в XWayland (раскомментируй при необходимости):
-- hl.window_rule({
--     name = "fix-xwayland-drags",
--     match = {
--         class = "^$", title = "^$",
--         xwayland = true, float = true,
--         fullscreen = false, pin = false,
--     },
--     no_focus = true,
-- })
