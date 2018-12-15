local _M = {}
local http = require "resty.http"

local config = require('app/config')
local ossBaseUrl = config.ossBaseUrl

function _M.fileExists(fileName)
  local f=io.open(fileName,"r")
  if f~=nil then io.close(f) return true else return false end
end

function _M.conver(background, image, output, x, y)
  os.execute(config.convert.." -coalesce "..background.." -gravity NorthWest -geometry +"..x.."+"..y.." null: "..image.." -layers composite -layers optimize "..output.." > /dev/null 2>&1");
end

function _M.decodeBase64url(data)
  s1, _  = string.gsub(data, "_", "/")
  s2, _ = string.gsub(s1, "-", "+")
  return ngx.decode_base64(s2)
end

function _M.writeFile(fileName, data)
  local file, err =io.open(fileName, "w+")
  if not file then
    ngx.log(ngx.ERR, err)
    return err
  else
    file:write(data)
    file:close()
  end
end

function _M.checkOssFile(uri)
  local realPath = '/oss-gif-watermark/www/'..uri..'/index'
  os.execute('mkdir -p /oss-gif-watermark/www/'..uri)
  if not _M.fileExists(realPath) then
    decodedPath = _M.decodeBase64url(uri)
    ossPath = ossBaseUrl..'/'..decodedPath
    local httpc = http.new()
    local res, err = httpc:request_uri(ossPath)
    if not res then
      ngx.log(ngx.ERR, err)
      return
    end
    _M.writeFile(realPath, res.body)
  end
end

print(
  _M.conver("t.gif", "qrcode.png", "out.gif", 10, 10)
)

return _M
