Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83613C433F5
	for <linux-fbdev@archiver.kernel.org>; Sun, 27 Mar 2022 22:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiC0WnZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 27 Mar 2022 18:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiC0WnG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 27 Mar 2022 18:43:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AEF4F46E
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso1880924wme.5
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaQcjw0Oe/ViCTTuFvcZ5DbpUtBdonZ5NoR4+x/b/mM=;
        b=qW2XxDUJbAS3r/UdSiVC1SUqqbo19IbwRzbd6eYE8QLRWXclC4MyMu5PP6s4nmi7wa
         S+uXzqwfhpFkc5h6RFYkTaLmN7WemillFnw9clcGHDhG8VEy5p18LJ6rH4GwGvW9q1Bz
         HTjdCkbRh0qlj498LM1uFTDOQlCT8ri1OnlsfeT3qZCsuqQS1N2wb5P075qAR5IBVhYO
         bkC8NIF0YCcJaQji7B2w9xdKQSANBOQwTZ0jVZxV6MJQ1tfn4mNYKO8evyPdiXkfccVx
         EF8z9VhvenBeN7MDHGqYOKS7IikyAEKadQyB8XwccUz92pe0ZbM2eK2UhGqfVjLaw6v9
         n1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaQcjw0Oe/ViCTTuFvcZ5DbpUtBdonZ5NoR4+x/b/mM=;
        b=EU+mf7WsVRiCM5E0kULrbhWbHwWbB4U/2oayPZXozHPMuXQmF02YzR9tQ1BxaschLI
         vUqQ8uKTcLkb9NA17rQ7Sct9bZIewoBnyInjuCdeAPxwr8HHTC08RNzW0K7uI47+A5Y0
         4WW3vmZIO9zLH1o88VC2rUnwzlVjJ5xBzhE3sqiPj1uSnY4hZNnaHvIBAi1QdX7UFchC
         5uGHVUt+J3sQYCFrjX58x5FvOaq5jEeCcDHuliClnTman4MQPCPe1XvxsrMd21YaFZuE
         yJftrrChgdoUL9q/Qg2OX7Tyb9OeyItZwaj9yvB178aTSwuuA79jTf0HvhY+fNLvMzzR
         /c/w==
X-Gm-Message-State: AOAM532GV7u8ObkhZmHPvbmWva62qjG50dRhyzOhdwkGFxCz9kK4fCpf
        7/0DViCUWYSvymGeuCZGhVWACg==
X-Google-Smtp-Source: ABdhPJxDwf6F+ENtKInRSb+MZ2nQMyNtshUEC8chEgc4PJTjVRZoRbjSGN3S8VWd2id0WbkzsUQobw==
X-Received: by 2002:a7b:c77a:0:b0:38c:2c33:d8f1 with SMTP id x26-20020a7bc77a000000b0038c2c33d8f1mr30933624wmk.115.1648420880088;
        Sun, 27 Mar 2022 15:41:20 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:19 -0700 (PDT)
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
Subject: [PATCH v9 13/22] drm/mediatek: dpi: move the yuv422_en_bit to SoC config
Date:   Mon, 28 Mar 2022 00:39:18 +0200
Message-Id: <20220327223927.20848-14-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add flexibility by moving the yuv422 en bit to SoC specific config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 6d4d8c6ec47d..40254cd9d168 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -132,6 +132,7 @@ struct mtk_dpi_conf {
 	/* HSIZE and VSIZE mask (no shift) */
 	u32 hvsize_mask;
 	u32 channel_swap_shift;
+	u32 yuv422_en_bit;
 	const struct mtk_dpi_yc_limit *limit;
 };
 
@@ -356,7 +357,8 @@ static void mtk_dpi_config_channel_swap(struct mtk_dpi *dpi,
 
 static void mtk_dpi_config_yuv422_enable(struct mtk_dpi *dpi, bool enable)
 {
-	mtk_dpi_mask(dpi, DPI_CON, enable ? YUV422_EN : 0, YUV422_EN);
+	mtk_dpi_mask(dpi, DPI_CON, enable ? dpi->conf->yuv422_en_bit : 0,
+		     dpi->conf->yuv422_en_bit);
 }
 
 static void mtk_dpi_config_csc_enable(struct mtk_dpi *dpi, bool enable)
@@ -824,6 +826,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
+	.yuv422_en_bit = YUV422_EN,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -839,6 +842,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
+	.yuv422_en_bit = YUV422_EN,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -853,6 +857,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
+	.yuv422_en_bit = YUV422_EN,
 	.limit = &mtk_dpi_limit,
 };
 
@@ -867,6 +872,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.dimension_mask = HPW_MASK,
 	.hvsize_mask = HSIZE_MASK,
 	.channel_swap_shift = CH_SWAP,
+	.yuv422_en_bit = YUV422_EN,
 	.limit = &mtk_dpi_limit,
 };
 
-- 
2.34.1

