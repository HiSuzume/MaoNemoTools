require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.*"
import "android.net.*"

local j = require("cjson")

--华为手机使用EMUI主题，其他设备用安卓默认

pcall(function()activity.setTheme(luajava.bindClass("androidhwext.R").style.Theme_Emui)end)

activity.setContentView("layout")

--Author: HiSuzume

--不能保证永久使用

--Github:https://github.com/HiSuzume/MaoNemoTools

local toast = function(t)activity.showToast(t)end

function 输入对话框(hint,callback)
  local i = EditText()
  i.hint = hint
  local d = AlertDialog.Builder()
  .setTitle("输入")
  .setView(i)
  .setPositiveButton("确定",{onClick=lambda:callback(i.text)})
  .setNegativeButton("粘贴", nil)
  .create()
  .show()
  local b = d.getButton(d.BUTTON_NEGATIVE)
  b.onClick = function()
    i.text = activity.getSystemService(luajava.bindClass("android.text.ClipboardManager")).text
  end
end

function 提示对话框(text,callback)
  local i = TextView()
  i.text = text
  i.setTextIsSelectable(true)
  i.textSize = 17
  AlertDialog.Builder()
  .setTitle("提示")
  .setView(i)
  .setPositiveButton("确定",{onClick=lambda:(callback or function()end)()})
  .setNegativeButton("复制", {onClick=lambda:activity.getSystemService(luajava.bindClass("android.text.ClipboardManager")).setText(i.Text)})
  .show()
  local p = i.getLayoutParams()
  p.setMargins(100,50,100,50)
end

function 列表对话框(text,callback)
  AlertDialog.Builder()
  .setTitle("选项")
  .setItems(text,{onClick=function(d,i)
      callback(i+1)
    end})
  .setPositiveButton("关闭",{onClick=lambda:(callback or function()end)()})
  .show()
end

function 浏览器打开(url)
  activity.startActivity(Intent().setData(Uri.parse("nemo://com.codemao.nemo/openwith?type=5&url="..url)))
end

DKFXLJ.onClick = lambda:输入对话框("分享链接，以 https://nemo.codemao.cn/ 开头，完成后将在编程猫浏览器打开。仅限 Nemo 作品，Kitten 作品无法自动判断。",function(t)
  if t == "" then toast("未输入文本。") return end
  --emo.codemao.cn/qrcode?type=1&workid=193990525
  local u = t:match("type=1&workid=(.+)")
  u = "https://nemo.codemao.cn/w/" .. u
  浏览器打开(u)
end)

NZLLQ.onClick = lambda:输入对话框("http://",function(t)
  浏览器打开(t)
end)

CXXLSBH.onClick = lambda:输入对话框("训练师编号",function(t)
  if t == "" then toast("未输入文本。") return end
  --https://api.codemao.cn/creation-tools/v1/user/center/honor?user_id=11770768
  --[[Http.get("https://api.codemao.cn/creation-tools/v1/user/center/honor?user_id=" .. t,nil,nil,nil,function(c,d)
    local i = j.decode(d)
    提示对话框("  用户名：" .. i.nickname .. "\n" .. "  用户简介：" .. i.user_description .. "\n\n原始数据：" .. d)
  end)]]
  浏览器打开("https://shequ.codemao.cn/mobile/user/"..t)
end)

ZCD.onClick = lambda:列表对话框({
  "还没做"
},function(i)
  switch i
   case 1
    toast("都说了没做，故意找茬是不是（bushi）")
  end
end)
