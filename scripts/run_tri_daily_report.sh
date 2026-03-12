#!/bin/bash
# MGI 竞争情报 - 三日报生成脚本
# 频率：每 3 天执行一次

set -e

WORKSPACE=~/Desktop/MGI-Competitive-Intelligence
REPORT_DATE=$(date +%Y-%m-%d)
REPORT_FILE="$WORKSPACE/daily-reports/三日报_${REPORT_DATE}.md"

echo "🔍 开始生成 MGI 竞争情报三日报..."
echo "📅 报告日期：$REPORT_DATE"
echo "📁 输出文件：$REPORT_FILE"

# 确保目录存在
mkdir -p "$WORKSPACE/daily-reports"

# 调用 OpenClaw 子代理执行调研
openclaw spawn --runtime subagent \
  --label "MGI 三日报-${REPORT_DATE}" \
  --task "生成 MGI 竞争情报三日报（${REPORT_DATE}）

调研要求：
1. 时间范围：过去 3 天
2. 核心竞品：贝克曼、Hamilton、领坤、奔耀、Opentrons、Tecan、玄刃
3. 调研维度：
   - 产品与技术（新品发布、技术路线、研发方向）
   - 市场与销售（招投标、价格动态、市占率）
   - 渠道与合作（合作伙伴、战略合作）
   - 监管与审批（NMPA/FDA/CE/IVDR）
   - 专利与诉讼（专利申请、纠纷）
   - 财务与业绩（财报、融资）
   - 政策与行业（行业政策、集采动态）

4. 数据源置信度：
   - A 级：官方一手数据（财报/公告/监管公示）
   - B 级：头部券商/权威咨询机构
   - C 级：合规权威媒体
   - D 级：自媒体/待核验（需标注）

5. 输出要求：
   - 生成 Markdown 报告到：~/Desktop/MGI-Competitive-Intelligence/daily-reports/三日报_${REPORT_DATE}.md
   - 避免与之前日报内容完全重复
   - 重要事件需动态追踪，标注进展状态
   - 每条信息标注置信度等级 [A/B/C/D]
   - 核心数据需≥2 个独立权威源交叉验证

6. 完成后：
   - 更新 data-timeline/ 时间序列数据库
   - 通过飞书发送给用户确认" \
  --model bailian/qwen3.5-plus \
  --timeout 1800

echo "✅ 三日报生成完成"
