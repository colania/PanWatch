#!/bin/bash
set -e

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}📦 开始制作宝塔部署包...${NC}"

# 1. 构建镜像 (确保是 amd64 架构)
echo -e "${YELLOW}1. 构建 Docker 镜像 (linux/amd64)...${NC}"
./build.sh latest

# 2. 导出镜像
echo -e "${YELLOW}2. 导出镜像文件 (这可能需要几分钟)...${NC}"
mkdir -p deploy_to_server
docker save -o deploy_to_server/panwatch_image.tar sunxiao0721/panwatch:latest

# 3. 复制说明文件
# (README.md 和 docker-compose.yml 已经在 deploy_to_server 目录中)
echo -e "${YELLOW}3. 复制配置文件 (.env)...${NC}"
cp .env deploy_to_server/ || echo -e "${YELLOW}Warning: .env file not found${NC}"

# 4. 打包 zip
echo -e "${YELLOW}4. 生成压缩包...${NC}"
rm -f panwatch_deploy.zip
zip -r panwatch_deploy.zip deploy_to_server/

echo ""
echo -e "${GREEN}✅ 部署包制作完成！${NC}"
echo -e "文件位置: ${YELLOW}panwatch_deploy.zip${NC}"
echo ""
echo "接下来："
echo "1. 将 panwatch_deploy.zip 上传到宝塔服务器。"
echo "2. 解压并按照 deploy_to_server/README.md 中的步骤操作。"
