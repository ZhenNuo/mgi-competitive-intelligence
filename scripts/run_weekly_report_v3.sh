#!/bin/bash
# MGI 竞争情报周报生成脚本 v3.0
# 用法：./run_weekly_report.sh [报告日期]

set -e

REPORT_DATE=${1:-$(date +%Y-%m-%d)}
WORKSPACE=~/Desktop/MGI-Competitive-Intelligence
TEMPLATE=$WORKSPACE/templates/周报模板_v3.0.md
OUTPUT_DIR=$WORKSPACE/summary-reports
OUTPUT_MD=$OUTPUT_DIR/周报_${REPORT_DATE}.md
OUTPUT_HTML=$OUTPUT_DIR/周报_${REPORT_DATE}.html

echo "🚀 开始生成 MGI 竞争情报周报"
echo "📅 报告日期：$REPORT_DATE"
echo "📁 输出目录：$OUTPUT_DIR"

# 检查模板是否存在
if [ ! -f "$TEMPLATE" ]; then
    echo "❌ 错误：模板文件不存在 $TEMPLATE"
    exit 1
fi

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 复制模板
echo "📋 复制模板..."
cp "$TEMPLATE" "$OUTPUT_MD"

# 计算调研周期（过去 7 天）
END_DATE=$REPORT_DATE
START_DATE=$(date -v-7d -j -f "%Y-%m-%d" "$END_DATE" +%Y-%m-%d 2>/dev/null || date -d "7 days ago" +%Y-%m-%d)

echo "📊 调研周期：$START_DATE ~ $END_DATE"

# 更新报告元数据
echo "✏️  更新报告元数据..."
sed -i.bak "s/{{start_date}}/$START_DATE/g" "$OUTPUT_MD"
sed -i.bak "s/{{end_date}}/$END_DATE/g" "$OUTPUT_MD"
sed -i.bak "s/{{delivery_date}}/$REPORT_DATE/g" "$OUTPUT_MD"

# 清理备份文件
rm -f "${OUTPUT_MD}.bak"

echo "✅ Markdown 报告生成完成：$OUTPUT_MD"

# 生成 HTML（如果有 pandoc）
if command -v pandoc &> /dev/null; then
    echo "📄 生成 HTML 版本..."
    pandoc "$OUTPUT_MD" -o "$OUTPUT_HTML" --metadata title="MGI 竞争情报周报 $REPORT_DATE"
    echo "✅ HTML 报告生成完成：$OUTPUT_HTML"
else
    echo "⚠️  pandoc 未安装，跳过 HTML 生成"
fi

# Git 提交
echo "💾 提交到 Git..."
cd "$WORKSPACE"
git add "$OUTPUT_MD" "$OUTPUT_HTML" 2>/dev/null || true
git commit -m "feat: 生成周报 $REPORT_DATE" || true

echo "🎉 报告生成完成！"
echo ""
echo "📄 Markdown: $OUTPUT_MD"
echo "🌐 HTML: $OUTPUT_HTML"
