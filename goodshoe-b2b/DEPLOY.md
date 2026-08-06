# goodshoe MFG · ToB 独立站部署指南

> 一份"怎么把网站挂上 + 表单收到询盘"的最简实战手册。

---

## 1. 文件结构

```
cloudpals-b2b/
├── index.html         ← 工厂首页（产能、案例、CTA 询价）
├── wholesale.html     ← 5 种合作模式详情 + 对比表 + FAQ
├── quote.html         ← 询价表单（核心转化页）
├── assets/
│   ├── css/style.css
│   ├── js/main.js
│   └── images/        ← 你的产品图
└── DEPLOY.md          ← 你在这里
```

---

## 2. 免费部署（10 分钟，永久免费）

### 方案 A：Netlify Drop（最简单，推荐）

1. 打开 https://app.netlify.com/drop
2. 把整个 `cloudpals-b2b/` 文件夹**拖到网页里**
3. 等 3 秒，得到一个 `xxx.netlify.app` 网址
4. 完事。全球 CDN + HTTPS + 永久免费

**自定义域名（如 cloudpals-mfg.com）**：
- 在 Netlify 后台 → Domain settings → Add custom domain
- 按提示去你的域名注册商改 DNS 记录（一般是加一条 CNAME）

### 方案 B：Cloudflare Pages（速度更快）

1. 注册 Cloudflare 账号 https://dash.cloudflare.com/sign-up
2. Pages → Create a project → Upload assets
3. 同样拖文件夹，3 秒上线
4. 域名直接绑定到你的 Cloudflare DNS

### 方案 C：GitHub Pages（如果你懂 Git）

1. 把代码推到 GitHub 仓库
2. 仓库 Settings → Pages → 选 main 分支 → 保存
3. 几分钟后 `xxx.github.io/cloudpals-b2b` 上线

---

## 3. 让询盘表单真的能收到邮件

**现在表单提交只是控制台打印数据**，需要接一个免费 form backend 把询盘发到你邮箱。

### 推荐方案：Web3Forms（250 提交/月免费，免注册）

1. 打开 https://web3forms.com
2. 填你的邮箱，拿到一个 access_key
3. 打开 `quote.html`，在 `<form>` 标签里加：

```html
<input type="hidden" name="access_key" value="YOUR_ACCESS_KEY_HERE">
<input type="hidden" name="subject" value="New B2B Inquiry from goodshoe MFG">
<input type="hidden" name="from_name" value="goodshoe Quote Form">
<input type="hidden" name="redirect" value="https://your-site.netlify.app/thank-you.html">
```

4. 把 `submitForm` 函数里模拟成功那段替换成：

```js
function submitForm(e) {
  e.preventDefault();
  const form = e.target;
  const data = new FormData(form);
  const json = JSON.stringify(Object.fromEntries(data));
  
  fetch('https://api.web3forms.com/submit', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' },
    body: json
  })
  .then(res => res.json())
  .then(data => {
    if (data.success) {
      form.style.display = 'none';
      document.getElementById('successCard').classList.add('show');
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  })
  .catch(err => {
    alert('Submission failed, please email us directly: info@cozy-foot.com');
  });
  return false;
}
```

5. 提交测试，10 秒内你应该收到一封邮件

### 其他备选方案

| 工具 | 免费额度 | 难度 | 推荐场景 |
|---|---|---|---|
| **Formspree** | 50/月 | ⭐ 最简单 | 询盘量小（< 50/月） |
| **Web3Forms** | 250/月 | ⭐ 简单 | **推荐** |
| **Basin** | 100/月 | ⭐⭐ 中等 | 需要 Zapier 集成 |
| **Google Forms** | 无限 | ⭐⭐ | 不在意外观 |
| **Tally** | 无限 | ⭐ | 想用 Notion 风格的表单 |

### 收件之后怎么跟进

1. 在 `info@cozy-foot.com` 邮箱设置**自动回复**："We received your inquiry, will reply within 24h"
2. 用 **Notion / Google Sheets / Airtable** 建一个询盘跟踪表
3. 跟单 SOP：4h 内回复报价 → 7 天内寄样 → 14 天内确认订单

---

## 4. 上线前必填的真实信息

下面的数据**已经填进去了**，但**有些是建议值，你必须用真实数据覆盖**：

| 字段 | 当前值 | 状态 |
|---|---|---|
| 邮箱 | **info@cozy-foot.com** | ✓ 你的真实邮箱 |
| 电话 | **+86 13559512899** | ✓ 你的真实手机 |
| 地址 | **Ningbo, Zhejiang, China** | ✓ 你的真实地址 |
| 工厂经验 | "10+ years" | ⚠️ 改成你工厂实际成立的年份 |
| 客户数 | "100+ brand clients" | ⚠️ 改成你真实服务的品牌数 |
| 年产能 | "300K+ pairs / year" | ⚠️ 改成你的真实年产能 |
| 绣花线数 | "12 embroidery lines" | ✓ 跟你发的车间全景图匹配 |
| 出口国家 | "20+ countries" | ⚠️ 改成你真实出口的国家数 |
| 认证 | OEKO-TEX / BSCI / Sedex | ⚠️ **只标你实际有的**！ |
| 客户案例 | "Sarah Chen, US DTC brand" | ⚠️ 改成真实客户（已征得同意） |

**重要**：如果某个认证你没拿到，**不要瞎标**。美国客户会查证，标了没有 = 失信。可以先写"Available upon request"或"In progress"。

如果你的工厂实际不叫 goodshoe，**强烈建议改品牌名**。CloudPals → goodshoe 已经换好。

---

## 5. 流量从哪来（让询盘真的来）

| 渠道 | 怎么用 | 投入 |
|---|---|---|
| **Alibaba.com** | 上传产品 + RFQ 报价 | 基础会员 $1,999/年 |
| **Made-in-China** | 同上 | 基础会员 ~$3,000/年 |
| **Global Sources** | 高级 B2B 平台 | ~$5,000/年 |
| **LinkedIn** | 工厂老板个人号 + 行业内容 | 0 |
| **Google Ads** | "custom slipper manufacturer" 等关键词 | $500-2,000/月 |
| **Trade Shows** | Canton Fair (April/October) | $3,000-10,000/次 |
| **行业社群** | 跨境电商 Slack / Facebook 群 | 0 |
| **老客户转介** | 给 5-10% 佣金 | 灵活 |

**最低成本启动**：注册 Alibaba + 每周发 5 个 LinkedIn 行业贴 + 给现有客户群发"我们上线了"邮件。

---

## 6. 下一步建议

✅ **现在就做（30 分钟内）**：
- [ ] 注册 Web3Forms + 填 access_key
- [ ] 替换所有"占位信息"为真实数据
- [ ] 拖到 Netlify 上线
- [ ] 用真实邮箱测试一次询盘表单

✅ **本周做**：
- [ ] 拍 5 张工厂实拍图（车间、产线、QC 过程、仓库、团队）
- [ ] 拍 1 段 30 秒工厂介绍视频
- [ ] 准备 Material Catalog PDF（材质 + 颜色 + 工艺）
- [ ] 注册 Alibaba.com 卖家账号

✅ **本月做**：
- [ ] 上传 10-20 个产品到 Alibaba
- [ ] 申请 Canton Fair 春季/秋季摊位
- [ ] 用 Google Ads 投 "OEM slipper manufacturer" 等 10 个核心关键词
- [ ] 联系 5-10 个老客户告知新网站

---

**作者**：Mavis · MiniMax · 2026-07-11
