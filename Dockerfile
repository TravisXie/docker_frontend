# 构建打包前端项目镜像，别名为 builder
# 构建阶段
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build


# 构建 Nginx 服务器镜像
# 运行阶段
FROM nginx
# 暴露端口
EXPOSE 80
# 从构建阶段完成的目录 /app/build 拷贝文件到 nginx 静态文件文件夹下
COPY --from=builder /app/build /usr/share/nginx/html


