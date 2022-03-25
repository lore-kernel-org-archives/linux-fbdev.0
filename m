Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E57C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Mar 2022 17:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377417AbiCYRSu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiCYRSr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Mar 2022 13:18:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F7E995C
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:17:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so11764447wru.4
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eEHSj6Z+4nINe2TDPCkNf9jm6eypipKQx8L5na/Yyk=;
        b=7UtYysHnvqeWIeZMuZiEC8IPVZDMSKlAbRO5E8BytTts4xLZ4UVAs9U89uPHLnkXDR
         CZ/+ax1ln/JmF6JZgHsnGO4JO0H5YV8MQ883D1jkSlu4H+heh0+z23oteIQioUnwTH45
         nnzH6k8Yc++ina40Z3HUalg2xzJYHImxhlKh4jPdHc50J4VSluchb0fpfZD1mTnXuQ0f
         JZH+0RErOPJbq0lI9y0KPqW0djaXnkwxt+TI/fn+Ry6HRtN1yp+BMIejkA8pOf4D+it5
         0cbds2cn1eOD6gIf9Kirm+ZODdIRx9/zoEJDsMlRX+NPASqJ9Coi4ClpVlt63Y1K4NUF
         Myfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eEHSj6Z+4nINe2TDPCkNf9jm6eypipKQx8L5na/Yyk=;
        b=W/LMphoZ0DQMDPz0K3kv2ejX0OmUfdqHIdcfyGKau3gmyvpB5f4H9Iv5erc95IcMGi
         iqlq00+zliN0hqgigyuCnFV0SllWvLxrT5bXeuPpM/uOw96HUc5gTrgzWSnp8r0rHG4b
         bQM855ihzR3Tx9woxluhlJT+8sKekmBm5TKU39AeM1dS0rjTL4S6li3y363t7fLiBqGK
         /3isckv/ijTN8mvyIQ+qFV0a2JZPJhR1Ef3LWcv+DCCckwjpbEKFrlHVKLjA2UISVnbV
         0GUx5s7DeGcWUTxtfdVHnSlHqYrSuj/PWh4gZDSFlJ/IV5EyNNozMUYEpqlsevvPrIer
         bqyQ==
X-Gm-Message-State: AOAM530Urv68AMFnuyR3GM8f9Z/8u3O0So2IAjVehELAZgDpW1ba3OIZ
        n9oJiU0YsOuytUacAD6coPJDqg==
X-Google-Smtp-Source: ABdhPJyzuPxAQnBUd0DqX9rA/COSrSXDlL45D+hPdYrqXIjWtxya//AY+dPfwxGIaXGeO3bCs3LXiw==
X-Received: by 2002:a5d:6c67:0:b0:204:ff0:87a8 with SMTP id r7-20020a5d6c67000000b002040ff087a8mr10162708wrz.627.1648228622001;
        Fri, 25 Mar 2022 10:17:02 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:17:01 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        markyacoub@google.com
Subject: [PATCH 09/22] drm/mediatek: dpi: implement a swap_input toggle in SoC config
Date:   Fri, 25 Mar 2022 18:14:58 +0100
Message-Id: <20220325171511.23493-10-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325171511.23493-1-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Adds a bit of flexibility to support SoCs without swap_input support

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 545a1337cc89..454f8563efae 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -126,6 +126,7 @@ struct mtk_dpi_conf {
 	const u32 *output_fmts;
 	u32 num_output_fmts;
 	bool is_ck_de_pol;
+	bool swap_input_support;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -378,18 +379,21 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 	    (format == MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
 		mtk_dpi_config_yuv422_enable(dpi, false);
 		mtk_dpi_config_csc_enable(dpi, true);
-		mtk_dpi_config_swap_input(dpi, false);
+		if (dpi->conf->swap_input_support)
+			mtk_dpi_config_swap_input(dpi, false);
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_BGR);
 	} else if ((format == MTK_DPI_COLOR_FORMAT_YCBCR_422) ||
 		   (format == MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
 		mtk_dpi_config_yuv422_enable(dpi, true);
 		mtk_dpi_config_csc_enable(dpi, true);
-		mtk_dpi_config_swap_input(dpi, true);
+		if (dpi->conf->swap_input_support)
+			mtk_dpi_config_swap_input(dpi, true);
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_RGB);
 	} else {
 		mtk_dpi_config_yuv422_enable(dpi, false);
 		mtk_dpi_config_csc_enable(dpi, false);
-		mtk_dpi_config_swap_input(dpi, false);
+		if (dpi->conf->swap_input_support)
+			mtk_dpi_config_swap_input(dpi, false);
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_RGB);
 	}
 }
@@ -808,6 +812,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 	.is_ck_de_pol = true,
+	.swap_input_support = true,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -819,6 +824,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 	.is_ck_de_pol = true,
+	.swap_input_support = true,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -829,6 +835,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.output_fmts = mt8183_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
 	.is_ck_de_pol = true,
+	.swap_input_support = true,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -839,6 +846,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 	.is_ck_de_pol = true,
+	.swap_input_support = true,
 	.limit = &mtk_dpi_limit,
 };
 
-- 
2.34.1

