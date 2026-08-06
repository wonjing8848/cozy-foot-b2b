# Mailersend 冷邮件配置清单
**2026-07-22 晚**

## 目标
- 发件域：`mail.cozy-foot.com`（子域名，隔离主站）
- 发件人：`outreach@mail.cozy-foot.com`
- 客户回复地址（Reply-To）：`info@cozy-foot.com`（主 Zoho 收件箱）

## Step 1：注册 Mailersend（5 min）
- 网址：https://www.mailersend.com/
- 邮箱：`wonjing8848@gmail.com`（**不要用 Brevo 那个被冻的**）
- 公司：Cozy Foot
- 网站：https://cozy-foot.com
- Plan：**Free**（不要勾 Trial）

## Step 2：加子域名（3 min）
- 控制台 → **Email** → **Domains** → **Add domain**
- 填：`mail.cozy-foot.com`
- 选 **Manual**（Porkbun 不在自动支持列表）

## Step 3：加 DNS（10 min）
- → 把 Mailersend 给你那张 DNS 清单截图发给我
- → 我帮你逐条翻译成 Porkbun 填法
- 预期 4 条左右：DKIM CNAME / SPF TXT / Return-path CNAME / 跟踪 CNAME

## Step 4：验证（等 5-30 min）
- Porkbun 加完所有记录
- 回 Mailersend → 点 **Verify**
- 看到全绿 ✓ 完成

## Step 5：创发件人（3 min）
- Mailersend → **Senders** → **Add sender**
- 邮箱：`outreach@mail.cozy-foot.com`
- 姓名：`Ding from Cozy Foot`（英文，客户看到的）
- 验证邮件会去 **163.com**（Porkbun catch-all 还在兜底）
- 点验证链接

## Step 6：发测试邮件（1 min）
- Mailersend → **Email** → **Create email**
- To：`info@cozy-foot.com`
- Subject：`test from mailersend`
- Body：一句话就行
- **重要**：展开"Advanced settings" / "Settings"：
  - **From**：`outreach@mail.cozy-foot.com`
  - **Reply-To**：`info@cozy-foot.com`（这步让客户回复直接进 Zoho）
- 点 **Send**
- 去 163 收件箱看：
  - 发件人是 `outreach@mail.cozy-foot.com` ✓
  - 点回复，收件人自动变 `info@cozy-foot.com` ✓

## 跑通后
- 每天发 30-50 封（新手建议 30/天起步）
- 2 周后看 Mailersend 限制：通常会从 100/天解锁到 400/天
- 回复超过 3% → 考虑投 $30/月上 Instantly.ai 做自动化跟进

## 注意事项
- ❌ **不要**在 Porkbun 加 Brevo 那 5 条记录（你看到了但还没加，对吧？——确认没加就别加）
- ✅ Brevo 账号先留着别删（万一以后解冻）
- ⚠️ Mailersend 国内访问偶尔慢，DNS 验证可能要等够 30 分钟

## 第一批开发信模板（3 封不同场景）
跑通测试后告诉我，我给你：
1. **酒店 / 民宿 采购** 版本
2. **亚马逊 FBA 卖家** 版本
3. **独立品牌 / 礼品分销** 版本
