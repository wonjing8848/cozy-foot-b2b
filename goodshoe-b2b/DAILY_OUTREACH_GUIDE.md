# 每日开发信流程 (USA B2B)
**Cozy Foot / goodshoe MFG | 2026-07-23**

## 目标：每天 15-30 分钟 → 10 封个性化开发信

---

## 工作流（每天 9:00 之前）

### ① 找 10 个 USA 目标客户 (15-20 min)

**主要渠道 1：Apollo.io（最佳，50 信用/月免费）**
- 网址：https://app.apollo.io/
- 注册（用 wonjing8848@gmail.com）
- People → 加筛选器：
  - **Title**: "owner" OR "founder" OR "buyer" OR "sourcing manager"
  - **Location**: "United States"
  - **Industry**: "Retail" OR "Consumer Goods" OR "Luxury Goods" OR "Furniture"
  - **Company size**: 1-50
- 每个搜索点进去看 LinkedIn/简介
- **每天挑 10 个最像买家的**

**主要渠道 2：Hunter.io（找邮箱，免费 25 次/月）**
- 网址：https://hunter.io/
- Domain Search → 输入公司域名
- 返回该公司的员工 + 邮箱格式
- 找 "buyer" / "founder" / "owner" 的邮箱

**主要渠道 3：Google Maps（找店铺）**
- 搜索：`gift shop [city]` 或 `boutique [city]`
- 例如：`gift shop austin`、`boutique brooklyn`
- 找到 5-10 个 → 进店网站 → 找 contact 邮箱

**渠道 4：Instagram（找独立品牌）**
- 搜索：`#giftboutique` `#handmadebrand` `#artisanbrand` `#shopindependent`
- 找 1k-50k 粉丝的账号
- Bio 里通常有邮箱

**渠道 5：Etsy 大卖家**
- Etsy 搜 `chenille slippers` 或 `cozy slippers`
- 看 1k+ 销量、5星评的店
- 进店 → "About" 部分找邮箱或品牌网站

---

### ② 把客户填进 `send-today.csv` (5 min)

打开 `send-today.csv` 模板（在你 workspace 目录），按这 5 列填：

```csv
email,name,company,persona,personalization
jane@cozyboutique.com,Jane Smith,Cozy Boutique,brand,Brooklyn-based minimalist home brand on Instagram
mike@indiegifthaus.com,Mike Lee,Indie Gift Haus,brand,LA gift shop focused on local artisans
sarah@texasresort.com,Sarah Johnson,Texas Hill Country Resort,hotel,80-room resort outside Austin
```

**persona 只能是 3 个值之一**：
- `hotel` → 酒店/民宿
- `amazon` → 亚马逊 FBA / 电商
- `brand` → 独立品牌 / 礼品店 / 设计师

**personalization** 写**1 句**你刚从他家网站/Instagram/LinkedIn 看到的具体细节（**这是回复率的关键**）。

---

### ③ 跑脚本发件 (3-5 min)

**方法 A：手动双击**
- 双击 `run-daily.bat`
- 看完每封预览按回车
- 等脚本跑完

**方法 B：自动每天 9:00 跑**（推荐）
- 配 Windows 任务计划程序（下面有步骤）
- 你 8:55 把 CSV 填好保存
- 9:00 自动跑，不需要电脑前

---

## 每天时间分配

| 时段 | 动作 | 时长 |
|------|------|------|
| 8:30-8:55 | 找 10 个客户 + 填 CSV | 25 min |
| 9:00 (自动) | 跑脚本发件 | 5 min（不用守着） |
| 12:00 (中午) | 看 info@ 收件箱，有回复立刻回 | 10 min |
| 晚上 | 跟进昨日发件（Day 3/7/14/30 跟进） | 15 min |

**总耗时：每天 30-50 分钟**

---

## 跟进节奏（关键！）

**80% 成交在第 5 次触达后**。每发一封就要排好跟进。

跟进模板见 `COLD_EMAIL_TEMPLATES.md`，节奏：

| 天数 | 动作 |
|------|------|
| Day 0 | 第 1 封（hotel/amazon/brand） |
| Day 3 | 跟进 #1（加图片） |
| Day 7 | 跟进 #2（案例） |
| Day 14 | **分手信**（最高回复率 8-12%） |
| Day 30 | 终极触达 |

**手动记录跟进表**（用 Excel）：

| email | 第 1 封日期 | Day 3 跟 | Day 7 跟 | Day 14 跟 | Day 30 跟 |
|-------|----------|---------|---------|----------|---------|
| jane@cozyboutique.com | 7/23 | 7/26 | 7/30 | 8/6 | 8/22 |
| mike@indiegifthaus.com | 7/23 | 7/26 | 7/30 | 8/6 | 8/22 |

**Excel 模板我也给你**（`FOLLOW_UP_TRACKER.xlsx` 或者用 Google Sheets）。

---

## 找客户的关键词库

### Apollo.io 行业关键词
- "Retail"
- "Consumer Goods"
- "Luxury Goods & Jewelry"
- "Furniture"
- "Textiles"
- "Wholesale"
- "Gift, Novelty, and Souvenir Stores"
- "Home Furnishings"

### Apollo.io 职位关键词
- "owner", "founder", "ceo", "president"
- "buyer", "purchasing manager", "sourcing manager"
- "merchandising manager", "category manager"
- "head of product", "brand director"

### Google Maps 搜索
- `gift shop [city]`
- `boutique [city]`
- `home goods store [city]`
- `souvenir shop [state]`
- `designer [city] home`

### Instagram 标签
`#giftboutique` `#handmadebrand` `#artisanbrand` `#shopindependent`
`#smallbusiness` `#cozystyle` `#homedecor` `#cozyhome`
`#etsyshop` `#etsyfinds` `#cozygift`

---

## 评分客户质量（避免浪费发送）

每个潜在客户打分 **A/B/C**：

| 分数 | 特征 | 例子 |
|------|------|------|
| **A** | 1k+ Instagram 粉丝 OR 1000+ Etsy 销量 OR 实体店在 5+ 城市 | Urban Outfitters 礼品线 |
| **B** | 500-1k 粉丝 OR 100-1000 Etsy 销量 OR 1-2 实体店 | 地区精品店 |
| **C** | < 500 粉丝 OR 0 销量 OR 个人卖家 | Etsy 个人卖家 |

**先发 A 名单（10 个 A），回复率会高 3 倍**。

---

## 30 天里程碑

| 时间 | 累计 | 预期回复 |
|------|------|----------|
| Day 7 | 70 封 | 2-3 个回复（3-5%） |
| Day 14 | 140 封 | 5-8 个回复 |
| Day 30 | 300 封 | 15-25 个回复 |
| **回复里 1-3 个变成客户** | | 🎉 |

**300 封 = 1-3 个客户 = $50k-300k 订单**（按平均 OEM 单价）

---

## 工具订阅总成本

| 工具 | 免费额度 | 付费 |
|------|---------|------|
| **Mailersend** | 12,000/月（Trial 后） | $20/月 Starter |
| **Apollo.io** | 50 信用/月 | $49/月 Starter（1000 信用） |
| **Hunter.io** | 25 域名搜索/月 | $49/月 Starter（500 搜索） |
| **总成本** | $0-20 | $20-118/月 |

**最低成本路径**（$0-20/月）：
- 用 Mailersend Free + Google Maps 手动找
- 每天少发 5 封（5/天）也够

**升级时机**：30 天后询盘稳定了再投工具升级。
