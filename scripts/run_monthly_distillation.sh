#!/bin/bash
# MGI 竞争情报 - 月度记忆蒸馏脚本
# 频率：每 30 天执行一次

set -e

WORKSPACE=~/Desktop/MGI-Competitive-Intelligence
DISTILL_DATE=$(date +%Y-%m-%d)

echo "🧠 开始执行 MGI 竞争情报月度记忆蒸馏..."
echo "📅 蒸馏日期：$DISTILL_DATE"

# 调用 OpenClaw 子代理执行记忆蒸馏
openclaw spawn --runtime subagent \
  --label "MGI 月度记忆蒸馏-${DISTILL_DATE}" \
  --task "执行 MGI 竞争情报月度记忆蒸馏（${DISTILL_DATE}）

任务要求：
1. 读取过去 4 周的周报内容（~/Desktop/MGI-Competitive-Intelligence/summary-reports/）

2. 提炼关键洞察：
   - 竞品重大动向（产品发布、战略调整、人事变动）
   - 市场趋势变化（市占率、价格趋势、区域动态）
   - 政策/监管重要更新（NMPA/FDA/CE 审批、集采政策）
   - 技术路线演进（新技术、专利布局、研发方向）
   - 渠道/合作关键事件（战略合作、代理商网络）

3. 输出到 MEMORY.md 的「MGI 竞争情报」章节
   - 更新位置：/Users/aaron/.openclaw/workspace/MEMORY.md
   - 格式：结构化条目，包含日期、重要性评级、来源

4. 更新 competitor-profiles/ 竞品档案
   - 补充最新产品信息
   - 更新市场动态
   - 记录关键事件时间线

5. 生成月度摘要报告
   - 输出到：~/Desktop/MGI-Competitive-Intelligence/summary-reports/月度摘要_YYYY-MM.md
   - 包含核心洞察、趋势分析、下月关注重点

6. 通过飞书发送给用户确认" \
  --model bailian/qwen3.5-plus \
  --timeout 1800

echo "✅ 月度记忆蒸馏完成"
