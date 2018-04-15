-- AwesomeWM configuration by Tim Visée.
-- Slighty modified from the default configuration template.

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local vicious = require("vicious")
local cairo = require("lgi").cairo;

-- Load Debian menu entries
require("debian.menu")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.get_configuration_dir() .. "themes/default/theme.lua")
-- TODO: Include this in the custom theme?
beautiful.wallpaper = awful.util.get_configuration_dir() .. "themes/default/background.jpg"
beautiful.border_width = 0
beautiful.useless_gap = 4

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymachinemenu = {
   { "logoff", function() awesome.quit() end},
   { "reboot", function() awful.util.spawn("sudo reboot") end},
   { "shutdown", function() awful.util.spawn("sudo shutdown now") end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Machine", mymachinemenu },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "Open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a CPU usage widget
mycpu = wibox.widget.progressbar()
mycpu:set_width(15)
mycpu:set_height(30)
mycpu:set_vertical(true)
mycpu.forced_height = 5
-- mycpu.background_color = gears.color("#555555")
mycpu.background_color = gears.color("#222222")
mycpu.max_value = 100
mycpucontainer = wibox.container.rotate(mycpu, 'east')

--vicious.register(mycpu, vicious.widgets.cpu,
--    function (widget, args)
--        return args[1]
--    end, 2)

-- Create a memory usage widget
mymem = wibox.widget.progressbar()
mymem:set_width(15)
mymem:set_height(30)
mymem:set_vertical(true)
mymem.forced_height = 5
mymem.color = gears.color("#00ff00")
-- mymem.background_color = gears.color("#555555")
mymem.background_color = gears.color("#222222")
mymemcontainer = wibox.container.rotate(mymem, 'east')

vicious.register(mymem, vicious.widgets.mem,
    function (widget, args)
        return args[1]
    end, 2)

-- Create a CPU usage graph
ctext = wibox.widget.textbox()
mycpugraph = wibox.widget.graph()
mycpugraph:set_width(50):set_height(20)
mycpugraph.min_value = 0
mycpugraph.max_value = 100
mycpugraph.stack = true
-- mycpugraph:set_background_color("#3c3c45")
mycpugraph:set_background_color("#222222")
-- mycpugraph:set_stack_colors({ "#FF5656", "#88A175", "#AECF96", "#FF0000" })
--mycpugraph:set_stack_colors({ "#1c2626", "#29302b", "#394130", "#484c32" })
mycpugraph:set_stack_colors({ "#7e3e3e", "#ab4747", "#7e3e3e", "#ab4747" })

mycpulabel = wibox.widget.textbox()
mycpulabel.align = "right"

vicious.register(ctext, vicious.widgets.cpu,
    function (widget, args)
        mycpugraph:add_value(args[2], 1) -- Core 1, color 1
        mycpugraph:add_value(args[3], 2) -- Core 2, color 2
        mycpugraph:add_value(args[4], 3) -- Core 3, color 3
        mycpugraph:add_value(args[5], 4) -- Core 4, color 4

        mycpu:set_value(args[1])
        mycpulabel:set_markup_silently('<span color="#d09a58">' .. args[1] .. '%</span> ')
    end, 2)

mycpugraphstack = wibox.layout.stack()
mycpugraphstack:add(mycpugraph)
mycpugraphstack:add(mycpulabel)

-- Create a network label
mynet = wibox.widget.textbox()
mynetdown = wibox.widget.textbox("?")
mynetup = wibox.widget.textbox("?")

mynetdowngraph = wibox.widget.graph()
mynetdowngraph:set_width(50):set_height(20)
mynetdowngraph.min_value = 0
mynetdowngraph.scale = true
mynetdowngraph:set_background_color("#222222")
mynetdowngraph.color = gears.color("#7e3e3e")

mynetupgraph = wibox.widget.graph()
mynetupgraph:set_width(50):set_height(20)
mynetupgraph.min_value = 0
mynetupgraph.scale = true
mynetupgraph:set_background_color("#222222")
mynetupgraph.color = gears.color("#7e3e3e")

function round(x)
    return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

--vicious.register(mynet, vicious.widgets.net,
--    function (widget, args)
--        return args["eth0 down_kb"]
--    end, 2)
vicious.register(mynet, vicious.widgets.net,
    function (widget, args)
        -- Get the download speed and unit
		if tonumber(args["{enp3s0 down_mb}"]) > 1 then
        	downval = tonumber(args["{enp3s0 down_mb}"])
            downunit = 'M'
		elseif tonumber(args["{enp3s0 down_kb}"]) > 0.2 then
        	downval = tonumber(args["{enp3s0 down_kb}"])
            downunit = 'K'
		else
        	downval = tonumber(args["{enp3s0 down_b}"])
            downunit = 'B'
		end

        -- Get the upload speed and unit
		if tonumber(args["{enp3s0 up_mb}"]) > 1 then
        	upval = tonumber(args["{enp3s0 up_mb}"])
            upunit = 'M'
		elseif tonumber(args["{enp3s0 up_kb}"]) > 0.2 then
        	upval = tonumber(args["{enp3s0 up_kb}"])
            upunit = 'K'
		else
        	upval = tonumber(args["{enp3s0 up_b}"])
            upunit = 'B'
		end

        -- Only show decimals for values less than 10
        if(downval >= 10) then
            downval = round(downval)
        end
        if(upval >= 10) then
            upval = round(upval)
        end

        -- Render the speed labels
        mynetdown:set_markup_silently(' <span color="#d4c675">' .. downval .. downunit .. '</span> ')
        mynetup:set_markup_silently(' <span color="#d09a58">' .. upval .. upunit .. '</span> ')

        -- Update the graphs
        mynetdowngraph:add_value(tonumber(args["{enp3s0 down_b}"]), 1)
        mynetupgraph:add_value(tonumber(args["{enp3s0 up_b}"]), 1)
    end, 2)

-- Networking icons
mynetdownicon = wibox.widget.textbox()
mynetdownicon.font = "GLYPHICONS Halflings 9"
mynetdownicon:set_markup_silently('<span color="#d4c675">&#xE197;</span>')
mynetupicon = wibox.widget.textbox()
mynetupicon.font = "GLYPHICONS Halflings 9"
mynetupicon:set_markup_silently('<span color="#d09a58">&#xE198;</span>')

mynetdownstack = wibox.layout.stack()
mynetdownstack:add(mynetdowngraph)
mynetdownstack:add(wibox.widget {
    mynetdownicon,
    mynetdown,
    layout = wibox.layout.align.horizontal
})

mynetupstack = wibox.layout.stack()
mynetupstack:add(mynetupgraph)
mynetupstack:add(wibox.widget {
    mynetupicon,
    mynetup,
    layout = wibox.layout.align.horizontal
})

widgetnet = wibox.widget {
    mynetdownstack,
    mynetupstack,
    layout = wibox.layout.align.horizontal
}

-- Create an uptime widget
myuptime = wibox.widget.textbox()
vicious.register(myuptime, vicious.widgets.uptime,
	function (widget, args)
		if args[1] > 0 then
			return ' <span color="#d4c675">' .. args[1] .. "d" .. '</span> '
		elseif args[2] > 0 then
			return ' <span color="#d4c675">' .. args[2] .. "h" .. '</span> '
		else
			return ' <span color="#d4c675">' .. args[3] .. "m" .. '</span> '
		end
	end, 15)

myuptimelabel = wibox.widget.textbox()
myuptimelabel.font = "GLYPHICONS Halflings 9"
myuptimelabel:set_markup_silently('<span color="#d4c675">&#xE278;</span>')

widgetuptime = wibox.widget {
	myuptimelabel,
	myuptime,
	layout = wibox.layout.align.horizontal
}


-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
                )

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, false)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "Home", "Code", "Edit", "IM", "Music", "Game", "7", "Sys", "Bull$hit" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            widgetnet,
            widgetuptime,
            mytextclock,
            mycpucontainer,
            mymemcontainer,
            mycpugraphstack,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Start locker script, to auto lock the screen when inactive
awful.util.spawn_with_shell('~/.config/awesome/locker')

-- Lock the screen
function lock_screen()
    -- Sync the disks
    naughty.notify({ preset = naughty.config.presets.normal,
                        title = "Locking screen...",
                        text = "Syncing all cached data to disks, please wait..." })
    awful.util.spawn("sync")

    -- Lock the screen
    awful.util.spawn("xautolock -locknow")
end

-- Lock the screen using Ctrl+Super+L
globalkeys = awful.util.table.join(globalkeys,
    awful.key({ "Mod1", "Control" }, "l", lock_screen)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal("mouse::enter", function(c)
--    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
--        and awful.client.focus.filter(c) then
--        client.focus = c
--    end
--end)

client.connect_signal("focus", function(c)
                                    c.border_color = beautiful.border_focus
                                end)
client.connect_signal("unfocus", function(c)
                                    c.border_color = beautiful.border_normal
                                end)
-- }}}

-- Auto start applications
do
    -- List of programs to automatically start
    local cmds = {}

    -- Start compton if installed
    if awful.util.file_readable("/usr/bin/compton") then
        -- TODO: Don't kill compton, just don't start it again when already running
        table.insert(cmds, "pkill compton")
        table.insert(cmds, "compton -b --blur-kern '15,15,0.140858,0.182684,0.227638,0.272532,0.313486,0.346456,0.367879,0.375311,0.367879,0.346456,0.313486,0.272532,0.227638,0.182684,0.140858,0.182684,0.236928,0.295230,0.353455,0.406570,0.449329,0.477114,0.486752,0.477114,0.449329,0.406570,0.353455,0.295230,0.236928,0.182684,0.227638,0.295230,0.367879,0.440432,0.506617,0.559898,0.594521,0.606531,0.594521,0.559898,0.506617,0.440432,0.367879,0.295230,0.227638,0.272532,0.353455,0.440432,0.527292,0.606531,0.670320,0.711770,0.726149,0.711770,0.670320,0.606531,0.527292,0.440432,0.353455,0.272532,0.313486,0.406570,0.506617,0.606531,0.697676,0.771052,0.818731,0.835270,0.818731,0.771052,0.697676,0.606531,0.506617,0.406570,0.313486,0.346456,0.449329,0.559898,0.670320,0.771052,0.852144,0.904837,0.923116,0.904837,0.852144,0.771052,0.670320,0.559898,0.449329,0.346456,0.367879,0.477114,0.594521,0.711770,0.818731,0.904837,0.960789,0.980199,0.960789,0.904837,0.818731,0.711770,0.594521,0.477114,0.367879,0.375311,0.486752,0.606531,0.726149,0.835270,0.923116,0.980199,0.980199,0.923116,0.835270,0.726149,0.606531,0.486752,0.375311,0.367879,0.477114,0.594521,0.711770,0.818731,0.904837,0.960789,0.980199,0.960789,0.904837,0.818731,0.711770,0.594521,0.477114,0.367879,0.346456,0.449329,0.559898,0.670320,0.771052,0.852144,0.904837,0.923116,0.904837,0.852144,0.771052,0.670320,0.559898,0.449329,0.346456,0.313486,0.406570,0.506617,0.606531,0.697676,0.771052,0.818731,0.835270,0.818731,0.771052,0.697676,0.606531,0.506617,0.406570,0.313486,0.272532,0.353455,0.440432,0.527292,0.606531,0.670320,0.711770,0.726149,0.711770,0.670320,0.606531,0.527292,0.440432,0.353455,0.272532,0.227638,0.295230,0.367879,0.440432,0.506617,0.559898,0.594521,0.606531,0.594521,0.559898,0.506617,0.440432,0.367879,0.295230,0.227638,0.182684,0.236928,0.295230,0.353455,0.406570,0.449329,0.477114,0.486752,0.477114,0.449329,0.406570,0.353455,0.295230,0.236928,0.182684,0.140858,0.182684,0.227638,0.272532,0.313486,0.346456,0.367879,0.375311,0.367879,0.346456,0.313486,0.272532,0.227638,0.182684,0.140858'")
    else
        -- Show a warning if it's not installed
        naughty.notify({ preset = naughty.config.presets.normal,
                        title = "Compton not installed",
                        text = "Not starting the compton daemon, it's not installed." })
    end

    -- Start nm-applet if installed
    if awful.util.file_readable("/usr/bin/nm-applet") then
        table.insert(cmds, "/usr/bin/nm-applet")
    else
        -- Show a warning if it's not installed
        naughty.notify({ preset = naughty.config.presets.normal,
                        title = "nm-applet not installed",
                        text = "Not starting the network manager, it's not installed." })
    end

    -- Start Telegram if installed
    if awful.util.file_readable("/opt/telegram/telegram") then
        table.insert(cmds, "/opt/telegram/telegram -startintray")
    end

    -- Invoke the start commands
    for _,i in pairs(cmds) do
        -- Show a notification
        naughty.notify({ preset = naughty.config.presets.normal,
                        title = "Autostarting application",
                        text = i })

        -- Invoke the command
        awful.util.spawn(i)
   end
end


-- Code testing space
-- TODO: Remove after testing
---- Create a surface
--local img = cairo.ImageSurface.create(cairo.Format.ARGB32, 50, 50)
--
---- Create a context
--local cr  = cairo.Context(img)
--
---- Set a red source
----cr:set_source_rgb(1, 0, 0)
---- Alternative:
--cr:set_source(gears.color("#ff0000"))
--
---- Add a 10px square path to the context at x=10, y=10
--cr:rectangle(10, 10, 10, 10)
--
---- Actually draw the rectangle on img
--cr:fill()
--
--screen.primary.mywibox.bgimage = img
