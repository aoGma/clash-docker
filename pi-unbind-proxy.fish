#!/usr/bin/env fish

set FISH_CONFIG "$HOME/.config/fish/config.fish"

# 删除代理相关环境变量设置
for key in http_proxy ftp_proxy https_proxy ALL_PROXY all_proxy
    sed -i "/set -gx $key/d" $FISH_CONFIG
end

# 清除 git 的代理配置
git config --global --unset http.proxy
git config --global --unset https.proxy

# 可选：提示用户手动 source
echo "✔️ Fish 代理配置已清除，如需立即生效，请执行："
echo "   source $FISH_CONFIG"