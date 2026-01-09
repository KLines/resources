---
chapter-02

# kubectl port-forward --address 0.0.0.0 svc/svcname-nginx 8080:8080

# vim ~/.bashrc
alias cd02='cd /klns/songps/gitops/resources/chapter-02/'

build & push [ klines/gitops ]
# podman login docker.io
# make docker-build TAG=v1.0
# make docker-push TAG=v1.0

# docker pull klines/gitops:v1.0
或
# podman pull docker.io/klines/gitops:v1.0
//下面这种方式拉不到
# podman pull klines/gitops:v1.0

# kubectl get deployment sample-app -o yaml -n gitops| yq eval 'del(.status, .metadata.creationTimestamp, .metadata.uid, .metadata.resourceVersion, .metadata.generation)' -
# kubectl get cronjobs  gitops-cron -o yaml -n gitops| yq eval 'del(.status, .metadata.creationTimestamp, .metadata.uid, .metadata.resourceVersion, .metadata.generation)' -
CronJob控制器会保留最近成功和最近失败的一些任务记录（对应Job和Pod）。具体保留的数量由两个参数控制：
.spec.successfulJobsHistoryLimit：保留成功完成的Job数量，默认为3。
.spec.failedJobsHistoryLimit：保留失败的Job数量，默认为1。
注意：这些记录是Job对象，每个Job对应一个Pod（除非Job中有指定多个Pod副本）。当CronJob按照调度时间运行时，它会创建一个Job对象，然后Job控制器会创建对应的Pod。
因此，对于你创建的CronJob，如果没有指定这两个参数，那么默认情况下：
会保留最近3个成功完成的Job（和对应的Pod记录，Pod状态为Completed）
保留最近1个失败的Job（和对应的Pod记录，Pod状态可能为Error）
但是要注意，这些Pod记录是随着Job的保留而保留的。当Job被删除时，对应的Pod也会被清理。

# kcgjns gitops
NAME                   COMPLETIONS   DURATION   AGE
gitops-cron-29464875   0/1           18h        18h
gitops-cron-29465960   1/1           4s         11m
gitops-cron-29465965   1/1           4s         6m25s
gitops-cron-29465970   1/1           4s         85s
# kcgpns gitops
NAME                         READY   STATUS      RESTARTS   AGE
gitops-cron-29465960-zcncc   0/1     Completed   0          11m
gitops-cron-29465965-bgc27   0/1     Completed   0          6m44s
gitops-cron-29465970-qz6xb   0/1     Completed   0          104s
sample-app-f9f55776-wcpfd    1/1     Running     0          31m

spec:
  # 设置为 0 时暂停服务/停止服务, 但不删除配置
  replicas: 1
  revisionHistoryLimit: 2

build & push [ klines/sample-app ]
//To sign in with credentials on the command line, use 'docker login -u <username>'
# docker login docker.io
USING WEB-BASED LOGIN

GitOps
# make docker-build TAG=v0.1
# make docker-push TAG=v0.1
SongPS
# make all TAG=v0.2

05. 执行 gitops-ci.sh 之前要先 podman login
文件 0205/deployment.yaml 仅作为 kubectl patch 基准文件 baseFile,
用于模拟 配置仓库文件 klines/sample-app-deployment/deployment.yaml 修改生成 patchFile 后提交!

[master 9b08b2b] Update sample-app image to klines/sample-app:f71bcb6
 Committer: root <root@kecs022.cluster.local>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly. Run the
following command and follow the instructions in your editor to edit
your configuration file:

    git config --global --edit

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+), 1 deletion(-)

---
chapter-03
