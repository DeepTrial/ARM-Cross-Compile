# ARM 交叉编译环境仓库

本仓库用于管理各种 ARM 架构的交叉编译环境 Docker 镜像。

## 支持的架构

| 架构 | 目录 | 说明 |
|------|------|------|
| aarch64 | `dockerfiles/aarch64/` | ARM64 / ARMv8-A |
| armhf | `dockerfiles/armhf/` | ARM hard-float (ARMv7+) |
| armel | `dockerfiles/armel/` | ARM soft-float |
| armv7 | `dockerfiles/armv7/` | ARMv7 专用 |

## 目录结构

```
.
├── dockerfiles/       # 各架构的 Dockerfile
│   ├── aarch64/
│   ├── armhf/
│   ├── armel/
│   └── armv7/
├── scripts/           # 构建和辅助脚本
├── configs/           # 配置文件
├── examples/          # 示例项目
└── docs/              # 文档
```

## 快速开始

### 构建镜像

```bash
# 构建 aarch64 交叉编译环境
cd dockerfiles/aarch64
docker build -t arm-cross:aarch64 .

# 或使用脚本
./scripts/build.sh aarch64
```

### 使用镜像

```bash
# 运行容器
docker run -it --rm -v $(pwd):/workspace arm-cross:aarch64
```

## 贡献指南

1. 每个新架构请在 `dockerfiles/` 下创建独立目录
2. Dockerfile 应包含清晰的注释说明
3. 添加相应的构建脚本到 `scripts/` 目录
