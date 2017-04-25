function blur(img)
    local sigma = assert(ngx.var.arg_sigma, 'sigma: missing')
    local radius = assert(ngx.var.arg_radius, 'radius: missing')
    img:blur(tonumber(sigma), tonumber(radius))
    return img
end

function format(img)
    local format = assert(ngx.var.arg_format, 'format: missing')
    img:set_format(format)
    return img
end

function quality(img)
    local quality = assert(ngx.var.arg_quality, 'quality: missing')
    quality = assert(string.match(quality, '[1-9]%d*'), 'quality: doesn\'t match pattern')
    img:set_quality(tonumber(quality))
    return img
end

function rotate(img)
    local degrees = assert(ngx.var.arg_degrees, 'degrees: missing')
    degrees = assert(string.match(degrees, '[1-9]%d*'), 'degrees: doesn\'t match pattern')
    img:rotate(tonumber(degrees))
    return img
end

function thumb(img)
    local size = assert(ngx.var.arg_size, 'size: missing')
    size = ngx.unescape_uri(size)
    img:thumb(size)
    return img
end

function main()
    -- explicitly read the req body as pointed out in manual: https://github.com/openresty/lua-nginx-module#ngxreqget_body_data
    ngx.req.read_body()
    local bodyData = ngx.req.get_body_data()

    if bodyData then
        local magick = require "magick"
        local split_each = require 'split'.each

        local img = assert(magick.load_image_from_blob(bodyData), 'can\'t read image from body')

        local sequencePath = ngx.var.sequence
        local sequence = split_each(sequencePath, '/')

        local enabledFunctions = {
            ["blur"] = true,
            ["format"] = true,
            ["quality"] = true,
            ["rotate"] = true,
            ["thumb"] = true
        }

        local trace = {}

        -- call commands in sequence
        for command in sequence do
            if enabledFunctions[command] and trace[command] == nil then
                trace[command] = true
                img = _G[command](img)
            end
        end

        return img
    end
end

-- Calling main execution
local status, values = pcall(main)

-- Error handling
if not status then
    local cjson = require "cjson"
    -- value holds the error
    local error = values
    local body = cjson.encode({
        status = "500 Internal Server Error",
        message = error
    })
    ngx.header["Content-Type"] = "application/json"
    ngx.status = 500
    ngx.say(body)
else
    -- values holds the image
    local img = values
    ngx.say(img:get_blob())
    img:destroy()
end