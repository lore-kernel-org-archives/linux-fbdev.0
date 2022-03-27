Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DB1C433F5
	for <linux-fbdev@archiver.kernel.org>; Sun, 27 Mar 2022 22:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiC0Wne (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 27 Mar 2022 18:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiC0WnQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 27 Mar 2022 18:43:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA0C4F9C4
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso1880943wme.5
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMvfz+B/fO4XaHRDT9xBCSiSBmXbtSzCBQeXFCLeYNU=;
        b=Vw1X4Y5lVyD515NEiLFa95V22KLRWSgdoITSR0BCjkY5StkoBpSinhOQfwnxA0wleD
         aHkviACkx2lXQf8Nu4082lNMVO729F9b924rICzamKBrUbBWhqbOCJt50We8bvy+sCNa
         u45slmKu49mbiiFUcL4hjlXUwNTMddzcSbd1bgu8VDFdLnpy7Te2BWHjLvNfJdbFnzLi
         hh1GZRZDDID3Ho6e7tPNHpJFoWHGHnMVJ/m3tyWpSVadNxtS/SphHBr3o95nK2qnYniR
         8rm30oqWbcNBC9jeAmOMkIFgJl9RrVBVrdF1n8qsHkXeEQS3je6Nx1VGhXhPNecFQYVH
         YPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMvfz+B/fO4XaHRDT9xBCSiSBmXbtSzCBQeXFCLeYNU=;
        b=aLzOLUEmcLX4O8L9rGzTJevhxNvVBFiZJYh/1rKQjUD+KJFPb6U1o2PjZXwsGRcKAL
         APu+PVx1Gvx4vZuxVo/O62MIIJEEVCsRocEwTN/I5n4XqIMtzJtJRzNae5KvzMgES3re
         j7cNgwY4+Yneo7Gv/azXVLURe8K6gyAYa/G057QAoIvO5UVapKbh0veS1/jNQj1IiP6f
         Jy+q5O7D18Ni6tg692+q8DHDw8YSCfb1w+b5nof74czmQYivZvI6ogtmuE86t0cm1kVy
         PgrEpI6Xa3ZXDfIZ0B4+jGxI0rYZJmMtC6IonILRZGZkp2PtYcY9b17Zv8+Qfr40ULHD
         Kr9A==
X-Gm-Message-State: AOAM530U0T4bbaSWLqkdVLkwnnJGnlJKNqwrv82OtPXaqx8Idagk7imL
        XggMEg5toORImC3VW1FAbMq29w==
X-Google-Smtp-Source: ABdhPJyr9nCr1C5pKgpwF1xz6b96JegOEEG0alyMX5WbHq+R8Ld7G7nR3JeuDRCJBV3mixw3fJxVKA==
X-Received: by 2002:a05:600c:1ca3:b0:38c:ccd1:bb1c with SMTP id k35-20020a05600c1ca300b0038cccd1bb1cmr21546319wms.199.1648420881794;
        Sun, 27 Mar 2022 15:41:21 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:21 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Subject: [PATCH v9 14/22] drm/mediatek: dpi: move the csc_enable bit to SoC config
Date:   Mon, 28 Mar 2022 00:39:19 +0200
Message-Id: <20220327223927.20848-15-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add flexibility by moving the csc_enable bit to SoC specific config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 40254cd9d168..eb969c5c5c2e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -133,6 +133,7 @@ struct mtk_dpi_conf {
 	u32 hvsize_mask;
 	u32 channel_swap_shift;
 	u32 yuv422_en_bit;
+	u32 csc_enable_bit;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -363,7 +364,8 @@ static void mtk_dpi_config_yuv422_enable(struct mtk_dpi *dpi, bool enable)
 
 static void mtk_dpi_config_csc_enable(struct mtk_dpi *dpi, bool enable)
 {
-	mtk_dpi_mask(dpi, DPI_CON, enable ? CSC_ENABLE : 0, CSC_ENABLE);
+	mtk_dpi_mask(dpi, DPI_CON, enable ? dpi->conf->csc_enable_bit : 0,
+		     dpi->conf->csc_enable_bit);
 }
 
 static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
@@ -827,6 +829,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
 	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -843,6 +846,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
 	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -858,6 +862,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
 	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -873,6 +878,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
 	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
 	.limit = &mtk_dpi_limit,
 };
 
-- 
2.34.1

