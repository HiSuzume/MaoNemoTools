# 切换工作路径(第一个参数)
cd $(dirname "$0")
# 添加文件
git add .
# 提交文件的信息(第二个参数)
git commit -m "$1"
# 上传
git push -u origin main