#!/usr/bin/env fish
set CURR_DIR (cd (dirname (status -f)) ; pwd)
set CLASH_CFG_MIXED_PORT (grep CLASH_CFG_MIXED_PORT $CURR_DIR/.env | awk -F '=' '{print $2}' | tr -d '\r')

echo "CLASH_CFG_MIXED_PORT: $CLASH_CFG_MIXED_PORT"

set FISH_CONFIG "$HOME/.config/fish/config.fish"

# 删除旧的代理设置
for key in http_proxy ftp_proxy https_proxy ALL_PROXY all_proxy
    sed -i "/set -gx $key/d" $FISH_CONFIG
end

# 添加新的代理设置
echo "set -gx http_proxy http://127.0.0.1:$CLASH_CFG_MIXED_PORT/" >> $FISH_CONFIG
echo "set -gx ftp_proxy http://127.0.0.1:$CLASH_CFG_MIXED_PORT/" >> $FISH_CONFIG
echo "set -gx https_proxy http://127.0.0.1:$CLASH_CFG_MIXED_PORT/" >> $FISH_CONFIG
echo "set -gx ALL_PROXY socks5://127.0.0.1:$CLASH_CFG_MIXED_PORT" >> $FISH_CONFIG
echo "set -gx all_proxy socks5://127.0.0.1:$CLASH_CFG_MIXED_PORT" >> $FISH_CONFIG

# 设置 git 代理（仍用 bash 风格）
git config --global http.proxy "socks5://127.0.0.1:$CLASH_CFG_MIXED_PORT"
git config --global https.proxy "socks5://127.0.0.1:$CLASH_CFG_MIXED_PORT"