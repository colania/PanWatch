# 部署到宝塔面板 (BT Panel) 指南

## 1. 准备工作
在您的本地电脑（Mac）上，打开终端，运行项目根目录下的打包脚本：

```bash
sh package_for_bt.sh
```

这将会：
1. 构建适用于 Linux 服务器的 Docker 镜像。
2. 将镜像导出为 `panwatch_image.tar`。
3. 生成一个 `panwatch_deploy.zip` 压缩包。

## 2. 上传到服务器
1. 登录宝塔面板。
2. 进入【文件】管理。
3. 在 `/www/wwwroot` 下创建一个新文件夹，例如 `panwatch`。
4. 将本地生成的 `panwatch_deploy.zip` 上传到该文件夹。
5. **解压** 该压缩包。

## 3. 导入镜像
1. 在宝塔面板左侧菜单点击【Docker】。
2. 点击【镜像】标签页 -> 【导入镜像】。
3. 选择文件：`/www/wwwroot/panwatch/deploy_to_server/panwatch_image.tar`。
4. 点击导入。

## 4. 创建容器服务
1. 在宝塔面板【Docker】页面，点击【项目】(Compose) 标签页。
2. 点击【添加项目】。
3. 填写信息：
   - **项目名称**: panwatch
   - **路径**: 选择 `/www/wwwroot/panwatch/deploy_to_server` 目录。
     > 确保该目录下有 `docker-compose.yml` 和 `.env` 文件。
4. 点击【添加】。
5. 等待启动完成。

## 5. 访问
服务启动后，访问 `http://服务器IP:8000` 即可。

## 注意事项
- **环境变量**: 您的配置（如飞书 Token、AI Key）已保存在 `.env` 文件中。如果需要修改，直接在宝塔文件管理中编辑该文件，然后重启容器即可。
- **防火墙**: 确保服务器防火墙（宝塔【安全】页面）已放行 **8000** 端口。
- **数据**: 数据文件存储在 `/www/wwwroot/panwatch/deploy_to_server/data` 目录下。
