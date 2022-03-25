Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7BFC433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Mar 2022 19:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiCYT2J (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiCYT1s (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Mar 2022 15:27:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2029B262D58
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 12:01:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso4942887wmr.1
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwaCkEqFprXU1DDLFh3M1rthbSN4qp5btRr4op3u7Dg=;
        b=7+559TLX/pioNdz1OStNbK5yndhEtZqY7oRe7DN3eda0eZGYiKl7cuYaeNKN9wfO5+
         2EVK0jBa2hpoOb2M+o3xC/kOAzMg/p+jLHr312Zr2oqH6JbHqm+hS0jQcfW0c+YDN8rM
         dNwh2bYxcWpeEsblHgYn2R1bpZ19mfs3/U4hWWoo7Wo7+84TzrDVVqpDeGEnrLDFEpjk
         2MIuXtJk4s9pmQxwXc8scdaoDXiunsLCYjovDLxlFSyYMOCef2wAm3klalE9kmryA4fr
         VbeoPziB2NXy+FW+t5+ArlEH8rbXlxr6pn15lJkU+4OhelKVwl/1pvER4s+xO1KjM2TV
         YgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwaCkEqFprXU1DDLFh3M1rthbSN4qp5btRr4op3u7Dg=;
        b=HMJAPScW8qc6uk/O92f4zYV8XTFUpI/2z/8Eln3i0oiTHRdEJpiTQ+ff9od909cPPY
         ers5nkuNvGFFsZxgfPT84ATK2zXhFg57Ws4moG4PAwiStkesgzT9iBjwOGckGokkARqY
         2Bb1E4Z/Ht4Zy6t7jYU5zM8VJ8GuXWmv0V9cYXoJ4Mdst1gAXKsehUVZL+QnSwYxdACi
         924qmuWKm1NXRp2gRKGS7A31jUDGADGTVdIWVK7f0tX/Jp1v2w3dMeK2azoLL/1FZhHw
         rHCEMmFMklYn8/2ZRhnCci/D6cjebdK48ikrosUJfe6Fu2uzMVV9whlY/ikQV8wEB1pr
         Mx4A==
X-Gm-Message-State: AOAM531pKdu5EdeYA2ss/i/UlbQaoSSdwRAk0M6Q881OgFMAZVuBR7Sl
        Amr7/L80Ap+BaFfElm+fm+d1JENQ7gdoVQ==
X-Google-Smtp-Source: ABdhPJxEd+5sCQHRN5kY92E454qYqOoufquWOJKPEAnY7ClBAak5cOcqSUJO3F8SRwH3b790AmcVyA==
X-Received: by 2002:a05:600c:3b1e:b0:38c:da9f:9309 with SMTP id m30-20020a05600c3b1e00b0038cda9f9309mr7351158wms.9.1648228637535;
        Fri, 25 Mar 2022 10:17:17 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:17:17 -0700 (PDT)
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
Subject: [PATCH 16/22] drm/meditek: dpi: Add matrix_sel helper
Date:   Fri, 25 Mar 2022 18:15:05 +0100
Message-Id: <20220325171511.23493-17-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325171511.23493-1-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com>
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

