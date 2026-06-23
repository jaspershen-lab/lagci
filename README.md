<!-- README.md is generated from README.Rmd. Please edit that file -->

<img src="man/figures/lagCI_logo.svg" align="right" alt="" width="120" />

# `lagCI`: Lagged-Correlation Based Causal Inference

[![](https://www.r-pkg.org/badges/version/lagci?color=green)](https://cran.r-project.org/package=lagci)
[![](https://img.shields.io/github/languages/code-size/jaspershen-lab/lagci.svg)](https://github.com/jaspershen-lab/lagci)
[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/jaspershen-lab/lagci)
---

`lagCI` is a part of [tidywearable](https://tidywearable.github.io/).

## **About**

---

`lagCI` is an R package for calculating the lagged correlation between time-series data, with a focus on wearable and omics data integration.

## **Installation**

---

You can install `lagCI` from
[GitHub](https://github.com/jaspershen-lab/lagci).

``` r
if(!require(devtools)){
install.packages("devtools")
}
devtools::install_github("jaspershen-lab/lagci")
```

Then load the package with:

``` r
library(lagci)
```

## **Usage**

---

`lagCI` provides tools for time-series lagged correlation analysis between wearable and omics data.

## **Need help?**

---

If you have any questions about `lagCI`, please don't hesitate to
email me (<shenxt@stanford.edu>) or reach out via the social media below.

<i class="fa fa-weixin"></i>  [shenxt1990](https://www.shenxt.info/files/wechat_QR.jpg)

<i class="fa fa-envelope"></i>  <shenxt1990@outlook.com>

<i class="fa fa-twitter"></i>  [Twitter](https://twitter.com/xiaotaoshen1990)

<i class="fa fa-map-marker-alt"></i>  [M339, Alway Buidling, Cooper Lane,
Palo Alto, CA
94304](https://www.google.com/maps/place/Alway+Building/@37.4322345,-122.1770883,17z/data=!3m1!4b1!4m5!3m4!1s0x808fa4d335c3be37:0x9057931f3b312c29!8m2!3d37.4322345!4d-122.1748996)

## **Citation**

---

If you use `lagCI` in your publications, please cite this preprint:

Yifei Ge, Shunpeng Bai, Zirui Qiang, Yijiang Liu, Yitong Wu, Xiaotao Shen,
LagCI Enables Inference of Temporal Causal Relationships from Dense
Multi-Omic Time Series, *bioRxiv* 2026.04.15.718654.  
[doi: https://doi.org/10.64898/2026.04.15.718654](https://doi.org/10.64898/2026.04.15.718654).

Thank you very much!
