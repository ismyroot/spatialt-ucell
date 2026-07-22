# spatialT-ucell — 空间转录组 UCell 基因集评分镜像
#
# 承载：spatialT_GeneSignature_Score_UCell
#
# 基础层：spatialt-base（须先构建并推送 spatialt-base:V1）
#
# 构建示例：
#   cd /home/ubuntu/zhaoyiran/TOOL-Dockerfile/SpatialT/spatialT-ucell
#   docker build -t quay.io/1733295510/spatialt-ucell:V1 .
#   docker push quay.io/1733295510/spatialt-ucell:V1
#
# 同步到火山云 Galaxy 集群：
#   docker tag quay.io/1733295510/spatialt-ucell:V1 \
#     genaibase-cn-beijing.cr.volces.com/genaibase/spatialt-ucell:v1
#   docker push genaibase-cn-beijing.cr.volces.com/genaibase/spatialt-ucell:v1

ARG BASE_IMAGE=quay.io/1733295510/spatialt-base:V1
FROM ${BASE_IMAGE}

LABEL maintainer="1733295510 <1733295510@qq.com>"
LABEL org.opencontainers.image.title="spatialt-ucell"
LABEL org.opencontainers.image.description="Spatial transcriptomics UCell scoring: spatialt-base + UCell."

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN R -e "BiocManager::install('UCell', ask = FALSE, update = FALSE, Ncpus = 2L)"

RUN R -e "\
  suppressPackageStartupMessages({\
    library(Seurat);\
    library(UCell);\
    library(ggplot2);\
    library(patchwork);\
    library(dplyr);\
    library(readr);\
    library(tibble);\
  });\
  cat('spatialt-ucell OK: Seurat', as.character(packageVersion('Seurat')),\
      ' UCell', as.character(packageVersion('UCell')), '\n');\
  cat(' UCell::AddModuleScore_UCell:', 'AddModuleScore_UCell' %in% getNamespaceExports('UCell'), '\n');\
  cat(' UCell::ScoreSignatures_UCell:', 'ScoreSignatures_UCell' %in% getNamespaceExports('UCell'), '\n');\
"

WORKDIR /work
