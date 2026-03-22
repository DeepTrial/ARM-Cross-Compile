#!/bin/bash
# 运行指定架构的交叉编译容器

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

show_help() {
    echo "用法: $0 <架构> [工作目录]"
    echo ""
    echo "参数:"
    echo "  架构       - aarch64, armhf, armel, armv7"
    echo "  工作目录   - 挂载到容器的目录 (默认: 当前目录)"
    echo ""
    echo "示例:"
    echo "  $0 aarch64           # 运行 aarch64 容器，挂载当前目录"
    echo "  $0 armhf /my/project # 运行 armhf 容器，挂载 /my/project"
}

if [ $# -lt 1 ]; then
    show_help
    exit 1
fi

ARCH=$1
WORKSPACE=${2:-$(pwd)}
WORKSPACE=$(cd "$WORKSPACE" && pwd)

IMAGE_TAG="arm-cross:${ARCH}"

# 检查镜像是否存在
if ! docker image inspect "$IMAGE_TAG" &> /dev/null; then
    echo "错误: 镜像 $IMAGE_TAG 不存在"
    echo "请先运行: ./scripts/build.sh $ARCH"
    exit 1
fi

echo "启动容器: $IMAGE_TAG"
echo "工作目录: $WORKSPACE"
echo ""

# 运行容器
docker run -it --rm \
    -v "$WORKSPACE:/workspace" \
    -w /workspace \
    --name "arm-cross-${ARCH}-$(date +%s)" \
    "$IMAGE_TAG"
