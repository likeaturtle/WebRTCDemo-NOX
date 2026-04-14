# WebRTCDemo 多平台构建 Makefile
# 支持 Linux (armv7, arm64, riscv, x86)、macOS (arm64, x86)、Windows (x86)

# 应用名称
APP_NAME := webrtc-demo
VERSION := 1.0.0

# 源文件目录
SRC_DIR := ./webserver

# 构建输出目录
BUILD_DIR := ./build

# Go 模块名称
MODULE_NAME := WebRTCDemo

# 默认目标
.PHONY: all
all: linux macos windows

# ========== Linux 平台 ==========

# Linux ARMv7
.PHONY: linux-armv7
linux-armv7:
	@mkdir -p $(BUILD_DIR)/linux-armv7
	GOOS=linux GOARCH=arm GOARM=7 go build -ldflags="-s -w" -o $(BUILD_DIR)/linux-armv7/$(APP_NAME) $(SRC_DIR)/main.go
	@echo "✓ Built: $(BUILD_DIR)/linux-armv7/$(APP_NAME)"

# Linux ARM64
.PHONY: linux-arm64
linux-arm64:
	@mkdir -p $(BUILD_DIR)/linux-arm64
	GOOS=linux GOARCH=arm64 go build -ldflags="-s -w" -o $(BUILD_DIR)/linux-arm64/$(APP_NAME) $(SRC_DIR)/main.go
	@echo "✓ Built: $(BUILD_DIR)/linux-arm64/$(APP_NAME)"

# Linux RISC-V
.PHONY: linux-riscv
linux-riscv:
	@mkdir -p $(BUILD_DIR)/linux-riscv64
	GOOS=linux GOARCH=riscv64 go build -ldflags="-s -w" -o $(BUILD_DIR)/linux-riscv64/$(APP_NAME) $(SRC_DIR)/main.go
	@echo "✓ Built: $(BUILD_DIR)/linux-riscv64/$(APP_NAME)"

# Linux x86 (32位)
.PHONY: linux-x86
linux-x86:
	@mkdir -p $(BUILD_DIR)/linux-x86
	GOOS=linux GOARCH=386 go build -ldflags="-s -w" -o $(BUILD_DIR)/linux-x86/$(APP_NAME) $(SRC_DIR)/main.go
	@echo "✓ Built: $(BUILD_DIR)/linux-x86/$(APP_NAME)"

# Linux x64 (64位)
.PHONY: linux-x64
linux-x64:
	@mkdir -p $(BUILD_DIR)/linux-x64
	GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o $(BUILD_DIR)/linux-x64/$(APP_NAME) $(SRC_DIR)/main.go
	@echo "✓ Built: $(BUILD_DIR)/linux-x64/$(APP_NAME)"

# 构建所有 Linux 平台
.PHONY: linux
linux: linux-armv7 linux-arm64 linux-riscv linux-x86 linux-x64

# ========== macOS 平台 ==========

# macOS ARM64 (Apple Silicon)
.PHONY: macos-arm64
macos-arm64:
	@mkdir -p $(BUILD_DIR)/macos-arm64
	GOOS=darwin GOARCH=arm64 go build -ldflags="-s -w" -o $(BUILD_DIR)/macos-arm64/$(APP_NAME) $(SRC_DIR)/main.go
	@echo "✓ Built: $(BUILD_DIR)/macos-arm64/$(APP_NAME)"

# macOS x86 (Intel)
.PHONY: macos-x86
macos-x86:
	@mkdir -p $(BUILD_DIR)/macos-x86
	GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w" -o $(BUILD_DIR)/macos-x86/$(APP_NAME) $(SRC_DIR)/main.go
	@echo "✓ Built: $(BUILD_DIR)/macos-x86/$(APP_NAME)"

# 构建所有 macOS 平台
.PHONY: macos
macos: macos-arm64 macos-x86

# ========== Windows 平台 ==========

# Windows x86 (32位)
.PHONY: windows-x86
windows-x86:
	@mkdir -p $(BUILD_DIR)/windows-x86
	GOOS=windows GOARCH=386 go build -ldflags="-s -w" -o $(BUILD_DIR)/windows-x86/$(APP_NAME).exe $(SRC_DIR)/main.go
	@echo "✓ Built: $(BUILD_DIR)/windows-x86/$(APP_NAME).exe"

# Windows x64 (64位)
.PHONY: windows-x64
windows-x64:
	@mkdir -p $(BUILD_DIR)/windows-x64
	GOOS=windows GOARCH=amd64 go build -ldflags="-s -w" -o $(BUILD_DIR)/windows-x64/$(APP_NAME).exe $(SRC_DIR)/main.go
	@echo "✓ Built: $(BUILD_DIR)/windows-x64/$(APP_NAME).exe"

# 构建所有 Windows 平台
.PHONY: windows
windows: windows-x86 windows-x64

# ========== 其他常用命令 ==========

# 清理构建目录
.PHONY: clean
clean:
	@rm -rf $(BUILD_DIR)
	@echo "✓ Cleaned build directory"

# 显示帮助信息
.PHONY: help
help:
	@echo "WebRTCDemo 多平台构建 Makefile"
	@echo ""
	@echo "可用目标:"
	@echo "  make all              - 构建所有平台"
	@echo "  make linux            - 构建所有 Linux 平台 (armv7, arm64, riscv, x86, x64)"
	@echo "  make macos            - 构建所有 macOS 平台 (arm64, x86)"
	@echo "  make windows          - 构建所有 Windows 平台 (x86, x64)"
	@echo ""
	@echo "单独平台目标:"
	@echo "  make linux-armv7      - Linux ARMv7"
	@echo "  make linux-arm64      - Linux ARM64"
	@echo "  make linux-riscv      - Linux RISC-V 64"
	@echo "  make linux-x86        - Linux x86 (32位)"
	@echo "  make linux-x64        - Linux x64 (64位)"
	@echo "  make macos-arm64      - macOS ARM64 (Apple Silicon)"
	@echo "  make macos-x86        - macOS x86 (Intel)"
	@echo "  make windows-x86      - Windows x86 (32位)"
	@echo "  make windows-x64      - Windows x64 (64位)"
	@echo ""
	@echo "其他命令:"
	@echo "  make clean            - 清理构建目录"
	@echo "  make help             - 显示此帮助信息"
