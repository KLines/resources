# 当前在 klines/sample-app 源码目录 -> 0205
export VERSION=$(git rev-parse HEAD | cut -c1-7)
# 未登录,push不可用,前置步骤省略,仅做流程演示
# make build
# make test

export NEW_IMAGE="klines/sample-app:${VERSION}"
# docker build -t ${NEW_IMAGE} .
# docker push ${NEW_IMAGE}

# 改进点: 放到上一级, 和 sample-app 目录平级, 已存在则删除或首先 git pull
# git clone http://github.com/klines/sample-app-deployment.git
# 切换至配置仓库
# cd sample-app-deployment

kubectl patch \
  --local \
  -o yaml \
  -f deployment.yaml \
  -p "spec:
        template:
          spec:
            containers:
            - name: sample-app
              image: ${NEW_IMAGE}" \
  > /tmp/newdeployment.yaml
mv /tmp/newdeployment.yaml deployment.yaml

# 提交更新配置仓库, 建立 源码commitID -> 项目imageID -> 配置仓库commit备注 的关联链条
git commit deployment.yaml -m "Update sample-app image to ${NEW_IMAGE}"
# http clone 没有认证, 无法提交
# git push

