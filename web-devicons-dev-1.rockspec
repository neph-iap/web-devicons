package = "web-devicons"
version = "dev-1"
source = {
  url = "git://github.com/neph-iap/web-devicons",
  tag = "v1.0",
}
description = {
  summary = "3 or above to work properly.",
  detailed = "Nvim-web-devicons requires version 2.3 or above to work properly. If you are unable to update please use your plugin manager to pin version of nvim-web-dev icons to `nerd-v2-compat` tag.",
  homepage = "https://github.com/neph-iap/web-devicons",
  license = "MIT",
}
build = {
  type = "builtin",
  modules = {
    vim = "lua/vim.lua",
    ["web-devicons"] = "lua/web-devicons.lua",
    ["web-devicons.icons-default"] = "lua/web-devicons/icons-default.lua",
    ["web-devicons.icons-light"] = "lua/web-devicons/icons-light.lua",
  },
}
