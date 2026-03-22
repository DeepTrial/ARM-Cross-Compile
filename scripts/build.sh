#!/bin/bash
# 构建指定架构的交叉编译 Docker 镜像

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# 显示帮助信息
show_help() {
    echo "用法: $0 <架构> [标签]"
    echo ""
    echo "支持的架构:"
    echo "  aarch64  - ARM64 / ARMv8-A"
    echo "  armhf    - ARM hard-float (ARMv7+)"
    echo "  armel    - ARM soft-float"
    echo "  armv7    - ARMv7 专用"
    echo ""
    echo "示例:"
    echo "  $0 aarch64         # 构建 aarch64 镜像，标签为 latest"
    echo "  $0 armhf v1.0      # 构建 armhf 镜像，标签为 v1.0"
}

# 检查参数
if [ $# -lt 1 ]; then
    show_help
    exit 1
fi

ARCH=$1
TAG=${2:-latest}
DOCKERFILE_DIR="$PROJECT_ROOT/dockerfiles/$ARCH"

# 检查架构目录是否存在
if [ ! -d "$DOCKERFILE_DIR" ]; then
    echo "错误: 不支持的架构 '$ARCH'"
    echo "可用架构:"
    for d in "$PROJECT_ROOT"/dockerfiles/*/; do
        echo "  - $(basename "$d")"
    done
    exit 1
fi

# 检查 Dockerfile 是否存在
if [ ! -f "$DOCKERFILE_DIR/Dockerfile" ]; then
    echo "错误: $DOCKERFILE_DIR/Dockerfile 不存在"
    exit 1
fi

echo "========================================="
echo "构建 ARM 交叉编译镜像"
echo "架构: $ARCH"
echo "标签: $TAG"
echo "========================================="

# 构建镜像
docker build \
    -t "arm-cross:${ARCH}-${TAG}" \
    -t "arm-cross:${ARCH}" \
    -f "$DOCKERFILE_DIR/Dockerfile" \
    "$DOCKERFILE_DIR"

echo ""
echo "✓ 构建完成: arm-cross:${ARCH}-${TAG}"
echo ""
echo "运行容器:"
echo "  docker run -it --rm -v \$(pwd):/workspace arm-cross:${ARCH}"
