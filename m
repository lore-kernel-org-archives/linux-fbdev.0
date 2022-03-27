Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C787C433FE
	for <linux-fbdev@archiver.kernel.org>; Sun, 27 Mar 2022 22:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiC0Wnc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 27 Mar 2022 18:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiC0WnR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 27 Mar 2022 18:43:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E16F33367
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w21so13335583wra.2
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwaCkEqFprXU1DDLFh3M1rthbSN4qp5btRr4op3u7Dg=;
        b=iR4hb0eiA/yMyu09+mRgbnoSC/7qohqOzylOoDiFDgH3Rm+c3s7WIszZVaVy+GImNV
         DTSRSqdmfABnk/xat2efXMy1mhyJpzBS+TT2Bo75iQNq56Zir2I/bXyyr9fjFLWjxvNb
         lySLAFpXdhfTvJIIbzQ4kJ+UJxpDQCD7FFe/Pz7gB2zTJV+6XDH2G/EwGHt9X30cYP/I
         wNdBN3harmrRCeBtvLDP+RuIcQF0yiQBlUnWQ8NXwfC3QZTUuQ10/9inAvac5ha5qrEr
         tK1Z9hHyDh5Ic98lIXlYbSKETLhv3W20iVpVJW86d8TFe487NdmrnA2h4iaWXAqPuNPv
         SZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwaCkEqFprXU1DDLFh3M1rthbSN4qp5btRr4op3u7Dg=;
        b=fkfKT84pPhzkio7yn6E8GoOt50yOO5Y6MRqhwGlhQ9g1Y3NjvEiCcijhvDt7FyeC5r
         98zfUYddQXBimbg030XjBgBJ52onrS5jTQR7562C1dSmL5F1GIXjjq6GA72oxQElUwc/
         s1SdytHwEC83G8HClqTmjkuITfK4d7FP37Vv1p0MzXYYyKg/5FFvvPoY3tJ1aJP6KN7j
         W71CUuvOI93HP4YhUAHTdYVtF0HSJD4U3uxqRWa7v/g0z+VEGIobYFCpibFbTGskuti0
         /01I6SEyY8tNro4qZVPFQKo23PPA6W6lsPdJb/BYwQv4cUX2tHo85BvVPjEw5+G5p+M2
         ZF2Q==
X-Gm-Message-State: AOAM531CZ1mBEkKUNJVzKH1xBr+aa7iLk2n2w8+64R37t0TnYjmVe7xk
        681oSUi2JKVlZB0manDt9lhqHw==
X-Google-Smtp-Source: ABdhPJwopKrzbeQi71t9oGesuR9nTk+ttZWzOngQzcK6unOKCfR+nbvvbDNuuP8jxHUdXyvs6NC+NA==
X-Received: by 2002:adf:de81:0:b0:203:fcba:84c3 with SMTP id w1-20020adfde81000000b00203fcba84c3mr19091884wrl.398.1648420885440;
        Sun, 27 Mar 2022 15:41:25 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:24 -0700 (PDT)
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
Subject: [PATCH v9 16/22] drm/meditek: dpi: Add matrix_sel helper
Date:   Mon, 28 Mar 2022 00:39:21 +0200
Message-Id: <20220327223927.20848-17-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add a mtk_dpi_matrix_sel() helper to update the DPI_MATRIX_SET
register depending on the color format.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 8198d3cf23ac..82f97c687652 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -385,6 +385,25 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
 		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
 }
 
+static void mtk_dpi_matrix_sel(struct mtk_dpi *dpi, enum mtk_dpi_out_color_format format)
+{
+	u32 matrix_sel = 0;
+
+	switch (format) {
+	case MTK_DPI_COLOR_FORMAT_YCBCR_422:
+	case MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL:
+	case MTK_DPI_COLOR_FORMAT_YCBCR_444:
+	case MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL:
+	case MTK_DPI_COLOR_FORMAT_XV_YCC:
+		if (dpi->mode.hdisplay <= 720)
+			matrix_sel = 0x2;
+		break;
+	default:
+		break;
+	}
+	mtk_dpi_mask(dpi, DPI_MATRIX_SET, matrix_sel, INT_MATRIX_SEL_MASK);
+}
+
 static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 					enum mtk_dpi_out_color_format format)
 {
@@ -392,6 +411,7 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 	    (format == MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
 		mtk_dpi_config_yuv422_enable(dpi, false);
 		mtk_dpi_config_csc_enable(dpi, true);
+		mtk_dpi_matrix_sel(dpi, format);
 		if (dpi->conf->swap_input_support)
 			mtk_dpi_config_swap_input(dpi, false);
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_BGR);
@@ -399,6 +419,7 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 		   (format == MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
 		mtk_dpi_config_yuv422_enable(dpi, true);
 		mtk_dpi_config_csc_enable(dpi, true);
+		mtk_dpi_matrix_sel(dpi, format);
 		if (dpi->conf->swap_input_support)
 			mtk_dpi_config_swap_input(dpi, true);
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_RGB);
-- 
2.34.1

