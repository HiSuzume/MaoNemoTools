# 切换工作路径(第一个参数)
cd $(dirname "$0")
# 添加安全文件夹防止提交失败(第一个参数)
git config --global --add safe.directory $(dirname "$0")
# 初始化Git仓库
git init
# 添加远程仓库(第二个参数)
git remote add origin "$1"
# 设置默认分支
git branch -M "main"
