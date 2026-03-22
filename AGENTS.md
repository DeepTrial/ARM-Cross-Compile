# ARM 交叉编译环境仓库

## 项目概述

本仓库用于管理各种 ARM 架构的交叉编译环境 Docker 镜像，便于统一管理和快速部署不同架构的编译环境。

## 项目结构

```
.
├── dockerfiles/           # 各架构的 Dockerfile
│   ├── aarch64/          # ARM64 / ARMv8-A
│   │   └── Dockerfile
│   ├── armhf/            # ARM hard-float (ARMv7+)
│   │   └── Dockerfile
│   ├── armel/            # ARM soft-float (待添加)
│   └── armv7/            # ARMv7 专用 (待添加)
├── scripts/               # 构建和辅助脚本
│   ├── build.sh          # 构建指定架构镜像
│   └── run.sh            # 运行指定架构容器
├── configs/               # 配置文件
├── examples/              # 示例项目
├── docs/                  # 文档
├── .gitignore            # Git 忽略文件
└── README.md             # 项目说明

```

## 使用方式

### 构建镜像

```bash
./scripts/build.sh <架构> [标签]
```

### 运行容器

```bash
./scripts/run.sh <架构> [工作目录]
```

## 维护说明

1. 添加新架构时，在 `dockerfiles/` 下创建对应目录
2. 更新脚本时保持兼容性
3. 测试通过后及时提交
