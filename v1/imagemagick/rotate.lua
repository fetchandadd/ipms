local degrees = tonumber(ngx.var.degrees)
local format = ngx.var.format
ngx.req.read_body()  -- explicitly read the req body
local data = ngx.req.get_body_data()
if data then
	local magick = require "magick"
	local img = assert(magick.load_image_from_blob(data))
	img:rotate(degrees, 0,0,0)
	img:set_format(format)
	ngx.say(img:get_blob())
        img:destroy()
	return
end
