local utils = require('app/utils')
local config = require('app/config')
local ossBaseUrl = config.ossBaseUrl
local fileExists = utils.fileExists

local background = ngx.var.background
local image = ngx.var.image
local position = ngx.var.position
local xy_it = string.gmatch(ngx.var.position, "%d+")
local x = xy_it()
local y = xy_it()

local uri = string.format("/%s/%s_%s", background, image, position)
local distPath = '/oss-gif-watermark/www'..uri

if fileExists(distPath) then
  return ngx.exec(uri)
else
  utils.checkOssFile(background)
  utils.checkOssFile(image)
  utils.conver('/oss-gif-watermark/www/'..background..'/index', '/oss-gif-watermark/www/'..image..'/index', distPath, x, y)
  return ngx.exec(uri)
end
