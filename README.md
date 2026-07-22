# spatialt-ucell 镜像

空间转录组 **UCell 基因集评分** 专用镜像，基于 `spatialt-base` 叠加 Bioconductor `UCell` 包。

## 对应 Galaxy 工具

- `SpatialT_type/spatialT_GeneSignature_Score_UCell`

## 构建与推送

```bash
cd /home/ubuntu/zhaoyiran/TOOL-Dockerfile/SpatialT/spatialT-ucell

# 构建（需已存在 quay.io/1733295510/spatialt-base:V1）
docker build -t quay.io/1733295510/spatialt-ucell:V1 .

# 推送 Quay
docker push quay.io/1733295510/spatialt-ucell:V1

# 同步火山 CR（Galaxy 生产环境）
docker login --username=<控制台用户名> genaibase-cn-beijing.cr.volces.com
docker tag quay.io/1733295510/spatialt-ucell:V1 \
  genaibase-cn-beijing.cr.volces.com/genaibase/spatialt-ucell:v1
docker push genaibase-cn-beijing.cr.volces.com/genaibase/spatialt-ucell:v1
```

## 本地验证

```bash
docker run --rm quay.io/1733295510/spatialt-ucell:V1 R -e "library(UCell); library(Seurat); packageVersion('UCell')"
docker run --rm quay.io/1733295510/spatialt-ucell:V1 quarto --version
```

## 部署工具

```bash
cd /home/ubuntu/zhaoyiran/TOOL-k8s
./k8s/sync_spatialt_gene_signature_score_ucell_to_galaxy_pvc.sh
```
