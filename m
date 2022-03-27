Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ABEC433FE
	for <linux-fbdev@archiver.kernel.org>; Sun, 27 Mar 2022 22:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiC0Wm7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 27 Mar 2022 18:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiC0Wmy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 27 Mar 2022 18:42:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF4E36B4B
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i204-20020a1c3bd5000000b0038ce25c870dso179054wma.1
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0UyPlWzo4y5KtqMIJtLeHp3pqp/XkkAPry5DhA+scQ=;
        b=KgkgNYwWNWYqMssq1TxVj6hHdHwIijT+06s/VUmK5PvHiiHhDPIwS4ruW+rc0C9rNj
         8nb7tNefHtXIB6cfSd9oZPKbXI+IRzTudGx/WYxtsWom+dBqWi39S8AX2JTc32CiT4re
         MwUTYZ2AOnsDG9Xlaun0ZDLWrv5SQfgqRn/BEA4zTa4GLQG2o3iXXcmwO6qE1bmts/VL
         02VX+oR8i4R0llcLLZRkM4qLE1+ZacJzwCicW3L21LO4SPQdOUootaue+SeD6uOOhmsp
         13ZRyT+jQjhxig6G7ZfC0uabcu0OzgexMWk1Z23gDAwYn1fFFUCCEBKFDv/eyN7wpe2o
         AKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0UyPlWzo4y5KtqMIJtLeHp3pqp/XkkAPry5DhA+scQ=;
        b=lhDRejzjeWdmpx0x1M13rkvlauxW1GANfN+6TvPZNlE7jtkd9GhGACxuEUo0481d87
         DqSrT5arRJwB04MGMk3ZKju74FciQ/IsQiHBfbIFCBboI70T/niSWPaXQHb0N8CtBG3r
         LqAZzh2ctcrhksjKjGOJyVG40R/HuVfJ93hZeHx6yITYMLJyDDtnx/4v9CRIQvTRsNh0
         lM6A1mw8pKxEYcUW5nY5Wksemrmlr//j2k9qWUcFlkX69qAG9cQb40vc9D/Gtoh4j+OC
         SQvyHZgn/Mi4R818/e90NzpmCUIECsMjjwZF2nNTOQrXdP4u/IVCfHDqLZqhX3FDd70l
         OOCg==
X-Gm-Message-State: AOAM533QrzYOWdEn6Pkhe5Ee6VznvmXa+fC7BOM3ErLOiY5CpJr4Y+AT
        IpCGiXgDDczOp9vrGlzdujYbOQ==
X-Google-Smtp-Source: ABdhPJwb1jYMbNoXQ+5XpX8dYg7AJHIw9s/jIzUwv5bmDSFVsCtOqUxBeJFvHmVp0i1tQgEDQdGcHA==
X-Received: by 2002:a7b:c30a:0:b0:389:9e1e:a15f with SMTP id k10-20020a7bc30a000000b003899e1ea15fmr21814588wmj.28.1648420871313;
        Sun, 27 Mar 2022 15:41:11 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:10 -0700 (PDT)
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
Subject: [PATCH v9 08/22] drm/mediatek: dpi: implement a CK/DE pol toggle in SoC config
Date:   Mon, 28 Mar 2022 00:39:13 +0200
Message-Id: <20220327223927.20848-9-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Adds a bit of flexibility to support SoCs without CK/DE pol support

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 4746eb342567..545a1337cc89 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -125,6 +125,7 @@ struct mtk_dpi_conf {
 	bool edge_sel_en;
 	const u32 *output_fmts;
 	u32 num_output_fmts;
+	bool is_ck_de_pol;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -211,13 +212,20 @@ static void mtk_dpi_config_pol(struct mtk_dpi *dpi,
 			       struct mtk_dpi_polarities *dpi_pol)
 {
 	unsigned int pol;
+	unsigned int mask;
 
-	pol = (dpi_pol->ck_pol == MTK_DPI_POLARITY_RISING ? 0 : CK_POL) |
-	      (dpi_pol->de_pol == MTK_DPI_POLARITY_RISING ? 0 : DE_POL) |
-	      (dpi_pol->hsync_pol == MTK_DPI_POLARITY_RISING ? 0 : HSYNC_POL) |
+	mask = HSYNC_POL | VSYNC_POL;
+	pol = (dpi_pol->hsync_pol == MTK_DPI_POLARITY_RISING ? 0 : HSYNC_POL) |
 	      (dpi_pol->vsync_pol == MTK_DPI_POLARITY_RISING ? 0 : VSYNC_POL);
-	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol,
-		     CK_POL | DE_POL | HSYNC_POL | VSYNC_POL);
+	if (dpi->conf->is_ck_de_pol) {
+		mask |= CK_POL | DE_POL;
+		pol |= (dpi_pol->ck_pol == MTK_DPI_POLARITY_RISING ?
+			0 : CK_POL) |
+		       (dpi_pol->de_pol == MTK_DPI_POLARITY_RISING ?
+			0 : DE_POL);
+	}
+
+	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol, mask);
 }
 
 static void mtk_dpi_config_3d(struct mtk_dpi *dpi, bool en_3d)
@@ -799,6 +807,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.max_clock_khz = 300000,
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
+	.is_ck_de_pol = true,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -809,6 +818,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.max_clock_khz = 150000,
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
+	.is_ck_de_pol = true,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -818,6 +828,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.max_clock_khz = 100000,
 	.output_fmts = mt8183_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
+	.is_ck_de_pol = true,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -827,6 +838,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.max_clock_khz = 150000,
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
+	.is_ck_de_pol = true,
 	.limit = &mtk_dpi_limit,
 };
 
-- 
2.34.1

