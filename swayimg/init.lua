swayimg.text.visible = false                -- overlay visible state

swayimg.viewer.on_key("right", function()
	swayimg.viewer.open("next")
end)

swayimg.viewer.on_key("right", function()
	swayimg.viewer.open("prev")
end)

-- switch to gallery mode
swayimg.viewer.on_key("g", function()
  swayimg.mode = "gallery"
end)
