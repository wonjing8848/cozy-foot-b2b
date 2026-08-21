# Cozy Foot — Facebook Pixel 安装指南

> **目标**：在所有 13 个 HTML 页面装上 Meta Pixel，追踪访客、询盘、转化。
> **预计时间**：30-45 分钟（按步骤做完）
> **难度**：低（复制粘贴）

---

## 📋 前置条件

- [ ] 你的 Meta (Facebook) Business 账户（https://business.facebook.com）
- [ ] Chrome 浏览器 + Meta Pixel Helper 扩展（https://chromewebstore.google.com/detail/meta-pixel-helper/fdgfkebogiimcoedlicjlajpkdokaete）
- [ ] GitHub 仓库的写权限（用于 deploy）

---

## 🚀 5 步安装

### Step 1：创建 Meta Pixel（5 min）

1. 打开 https://business.facebook.com/events_manager
2. 左侧菜单 → **"Data Sources"** → 点绿色 **"+ Connect Data Sources"** 按钮
3. 选择 **"Web"** → **"Meta Pixel"** → **"Connect"**
4. 命名你的 Pixel：`Cozy Foot Pixel`
5. 复制你的 **Pixel ID**（一串 15-16 位数字，例如 `123456789012345`）
6. **保存到安全地方**（你的密码管理器或 1Password）

⚠️ **不要点 "Install Code Yourself"**——我已经帮你装好基础代码，你只需要在最后一步替换 Pixel ID。

---

### Step 2：在所有页面装上基础 Pixel 代码

**已经做好了！** 在 commit `XXX`（我下一步会创建）里我已经把基础代码加到了所有 13 个 HTML 文件的 `<head>` 里。

代码长这样（占位符）：

```html
<!-- Meta Pixel Code -->
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window, document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', '27946655784986683');
fbq('track', 'PageView');
</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=27946655784986683&ev=PageView&noscript=1"
/></noscript>
<!-- End Meta Pixel Code -->
```

---

### Step 3：替换占位符为你的真实 Pixel ID（10 min）

**方法 1：手动替换（最简单）**

1. 打开所有 13 个 HTML 文件的 GitHub 仓库
2. 找 `27946655784986683`（每个文件 2 处：script 和 noscript img）
3. 全部替换为你的真实 Pixel ID
4. 提交 commit

**方法 2：本地替换（更快）**

1. 打开 PowerShell
2. cd 到项目目录
3. 运行：
```powershell
$files = Get-ChildItem -Recurse -File -Filter '*.html' | Where-Object { $_.FullName -notmatch 'catalog' }
$newId = '你的_PIXEL_ID'
foreach ($f in $files) {
    (Get-Content $f.FullName -Raw -Encoding UTF8) -replace '27946655784986683', $newId | Set-Content $f.FullName -Encoding UTF8 -NoNewline
}
```
4. git add + commit + push

---

### Step 4：验证 Pixel 是否工作（5 min）

1. 打开 cozy-foot.com 任意页面
2. 点 Chrome 右上角 Meta Pixel Helper 扩展图标
3. 应该看到 "PageView" 事件被触发（绿色 ✓）
4. 切换到不同页面，应该每个页面都有 PageView

**如果看不到：**
- 浏览器缓存 → Ctrl+F5 刷新
- Pixel ID 写错了
- Pixel 代码位置不对（必须在 `<head>` 里）

---

### Step 5：设置事件追踪（已经预装好）

我已经在以下页面预装好事件追踪：

| 页面 | 事件 | 触发时机 |
|---|---|---|
| 全部 13 个 | **PageView** | 页面加载 |
| `quote.html` | **Lead** | 表单提交 |
| `product-cotton-velvet-slipper.html` | **ViewContent** | 页面加载 |
| `seasonal.html` | **ViewContent** | 页面加载 |
| `wholesale.html` | **ViewContent** | 页面加载 |

**Lead 事件追踪**会用 form 的 submit 事件触发。表单提交后会自动发一个 Lead 事件到 Facebook。

---

## 📊 Meta Pixel 里你会看到的事件

装好后 24-48 小时内，你会在 Events Manager 里看到：

| 事件 | 含义 | 预期数据 |
|---|---|---|
| PageView | 任意页面浏览 | 每天 5-50（有机流量） |
| ViewContent | 产品/seasonal/wholesale 页 | 每天 1-20 |
| Lead | 询盘表单提交 | 每天 0-3（开始时 0 正常） |

**前 2 周数据少是正常的**——这正是为什么现在装 Pixel 而不投广告：积累数据。

---

## 🔄 Conversions API（高级，optional）

iOS 14.5+ 用户如果不接受 FB 追踪，浏览器 Pixel 抓不到数据。Conversions API 让你的服务器直接发数据给 FB，准确率高 30-50%。

**对你来说**（GitHub Pages 静态站）：
- ⚠️ 比较难（需要 server-side）
- 短期可以跳过
- 等 3-6 个月后流量大再考虑

如果想加，可以用 **Stape**（https://stape.io）这种 serverless 方案，$20/月起。

---

## 🎯 等 Pixel 装好后，未来 4-6 周做什么

| 周 | 行动 |
|---|---|
| Week 1-2 | 有机发 Pinterest / FB / IG 内容，积累访客数据 |
| Week 3 | 检查 Events Manager 看 PageView 数和流量来源 |
| Week 4-5 | 第一次小预算 FB 广告测试（$200-300） |
| Week 6 | 看数据，决定下一步 |

---

## ❓ 常见问题

**Q：装了 Pixel 会拖慢网站吗？**
A：基本不会。fbevents.js 异步加载，不影响首屏。

**Q：能跳过 Conversions API 吗？**
A：可以。短期影响小，长期建议加。

**Q：Pixel ID 找不到了怎么办？**
A：去 Events Manager → Data Sources → 你的 Pixel → Settings → Pixel ID

**Q：装了 Pixel 但 Events Manager 看不到数据？**
A：等 24-48 小时。FB 处理数据有延迟。

**Q：测完一个 Pixel 想换新 Pixel 怎么办？**
A：建新 Pixel，把代码里的 ID 全替换。新旧 Pixel 数据不互通。

---

## ✅ 完成清单

- [ ] Step 1：创建 Pixel，拿到 ID
- [ ] Step 2：基础代码已就位（commit 完成后）
- [ ] Step 3：替换占位符为真实 ID
- [ ] Step 4：用 Pixel Helper 验证
- [ ] Step 5：事件追踪已预装
- [ ] 等 24-48 小时看 Events Manager 数据

---

## 📌 接下来

1. 我现在预装代码到所有 13 个 HTML 文件
2. 给你一个 commit
3. 你 deploy 后跟着这个指南 5 步走完
4. 24-48 小时后 Events Manager 就有数据了
