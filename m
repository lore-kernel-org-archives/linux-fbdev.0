Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B22C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Mar 2022 17:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiCYRTq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbiCYRTe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Mar 2022 13:19:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F8EAC8C
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:17:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q20so4832527wmq.1
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cdghCtZILOuy6wyiUAMSm10nHZvUCEwy3CxnJnpQ3E=;
        b=Ekml532Q4VM1H61d92wIWfxKoSe5qC68hUPuRiJ3utWbOHHL5xxnrBy7NlgYLLrxXF
         NTu3kCRSo859RS36c8hHfLfzjM0xwpTLhkPCnp58ejKXGViwoaxLpTlORp9RmiUAifXW
         OwZRIkinfqA7QR0sTfS5bnOASfOR8QYtWpOkcbfZ1+9sJKESfv4H5HAe3tiQjVmoDouF
         y4KTvE10pO1b1l1AhbRfA29ayxjlNJgR1gWpgJR2b5g0lUazF4lpIfMOVUOew1v2xhAD
         SzmwIQUFGVVbFSDYENnz6Thfe+BR9R/UmkE3pNJDxt90WUP63GrBqY8PbscluUB9Gn86
         wAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cdghCtZILOuy6wyiUAMSm10nHZvUCEwy3CxnJnpQ3E=;
        b=Zo+1jMfAld/sDP15NviUx2BNG/YGgdzHEpHzKzg8skVPaON9/6Ypt52flpoa23Tt99
         tky6zRxJnRZ4v7TvqAg2vmb91gdF6eA8RwRlUE4IpZv4GqaY6darM66PQ8bsXfHocsb/
         wgaWXWLBZ2WyWy4vQiRbO0r4ncQxbU9uOJJBc/Wf1LIP8Mw8ILf3Sl+GMwi/jXgCNX5e
         B1Qf5IUTMxHubBtMR+QK6k+1FBUA+LzpkJ5BYZIfGrSOH8nXGl3jg/Zrya2epQfGW/GX
         Ns6tdZQjS1aUc7n9DpzwBuwoAD1gNmJSW+ZPm5Nhy4Ff81nj0WADkg4A9lru49ki+4uo
         g4gg==
X-Gm-Message-State: AOAM531HfKWiN3eChIjQsK+rsVZIZ0Akmuh6hpKm0GmTOdXYsuOuGWuh
        HSG6ZYaEQK6IuYlKXiv4HTNzJahzvyQ+pQ==
X-Google-Smtp-Source: ABdhPJygjHdeyF3kmbF552zf4Ig1oFkDJy8o4evJu6in/pkAYt6kS4J5LF/XYpeLn+lvNZV9cbY90Q==
X-Received: by 2002:a1c:cc11:0:b0:389:e8aa:ad4b with SMTP id h17-20020a1ccc11000000b00389e8aaad4bmr10622380wmb.79.1648228628310;
        Fri, 25 Mar 2022 10:17:08 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:17:07 -0700 (PDT)
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
Subject: [PATCH 12/22] drm/mediatek: dpi: move swap_shift to SoC config
Date:   Fri, 25 Mar 2022 18:15:01 +0100
Message-Id: <20220325171511.23493-13-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325171511.23493-1-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add flexibility by moving the swap shift value to SoC specific config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 6eeda222a973..6d4d8c6ec47d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -131,6 +131,7 @@ struct mtk_dpi_conf {
 	u32 dimension_mask;
 	/* HSIZE and VSIZE mask (no shift) */
 	u32 hvsize_mask;
+	u32 channel_swap_shift;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -349,7 +350,8 @@ static void mtk_dpi_config_channel_swap(struct mtk_dpi *dpi,
 		break;
 	}
 
-	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << CH_SWAP, CH_SWAP_MASK);
+	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, val << dpi->conf->channel_swap_shift,
+		     CH_SWAP_MASK);
 }
 
 static void mtk_dpi_config_yuv422_enable(struct mtk_dpi *dpi, bool enable)
@@ -821,6 +823,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -835,6 +838,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -848,6 +852,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -861,6 +866,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.swap_input_support = true,
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
 	.limit = &mtk_dpi_limit,
 };
 
-- 
2.34.1

