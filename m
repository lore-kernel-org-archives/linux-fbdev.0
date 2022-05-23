Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9449EC4332F
	for <linux-fbdev@archiver.kernel.org>; Mon, 23 May 2022 10:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiEWKwG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 23 May 2022 06:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiEWKvZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 23 May 2022 06:51:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979AB28714
        for <linux-fbdev@vger.kernel.org>; Mon, 23 May 2022 03:51:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e28so20142536wra.10
        for <linux-fbdev@vger.kernel.org>; Mon, 23 May 2022 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWgqk9KhFkOffkb3OEMTrNnAfqhM77Ox4JDvfW/o1S8=;
        b=JdEhccv00JjYKHfLCeZR4SBq3r1mpyIzHgvk2jWMBa66ocy5zkNG+dqpG02U2B2q2h
         Tjkw4VDmRWqGKrSi9mU5AagmMOybaI/eIkEkeE09PZHVg979ODz5Jjp/v5dI4f/3hJWU
         WRMWTbgCLTkeVezqAa360Eus1As226/OURVlVyn+52XT6QfeGjrUuZUi9MDK33Pq6nqB
         ZVBc96O81UYVu/wJS9JCyqra8bVi6dWW651erb9THLCb/zMJycaLyCMJcvj3W3MBdExS
         zi8hR5nIJAmtFB9zOxjMsTc3HlNcX6vTR6r79xtjeziCBr6IltidQMFpXz0YxO3cNNuv
         SPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWgqk9KhFkOffkb3OEMTrNnAfqhM77Ox4JDvfW/o1S8=;
        b=f74hzrEjnU9CY3DfuoOG+ow20g/vlzs5Ug3iOwxP9Nw1ELREP/qG1F8eD1FyRyAUdw
         5fNOqmc97LXU3tl9Di1GoKPWX1vYYZurwwM5gP6+xiZoBcOThnbngnhNOyE5qvprlTrB
         4tCJVNgQ+gI5ouQUUQbn4Uesju3v1S089Z9LZLN18GArMKFopWz/fBle5wUcLpKOI9pg
         /QOCUu9AJChc6p3UaPrRT/PmWE3+ZkHzjgmNuqzdEud3P8OZpgpL6H3UtzZKVz6k9AJC
         01mGVXnqLGBwCEg2EZDsdz59NFZoJ9qJa0fj37jhQheBpCgoQUWV53R6fTxvmMz6SlS3
         XQWg==
X-Gm-Message-State: AOAM533alJ+/UepBUlhD6O/OwaSodxivbNpTOy9U0vfQk8iEJqvkuF93
        PsML955WkGS8VAcV772tfQ7rLA==
X-Google-Smtp-Source: ABdhPJw2E7On4Oju2hfmLb0SDCcJA1GzQfEtMNUlIfdbD/oZpt27PE8H5IfsS//agrMc544Csh+BrA==
X-Received: by 2002:a5d:4207:0:b0:20e:63c3:e398 with SMTP id n7-20020a5d4207000000b0020e63c3e398mr18892329wrq.642.1653303083160;
        Mon, 23 May 2022 03:51:23 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-9d1b-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6141:9d1b:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bc5cb000000b003942a244f38sm8453607wmk.17.2022.05.23.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:51:22 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Helge Deller <deller@gmx.de>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v10 12/21] drm/mediatek: dpi: move the yuv422_en_bit to SoC config
Date:   Mon, 23 May 2022 12:47:45 +0200
Message-Id: <20220523104758.29531-13-granquet@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523104758.29531-1-granquet@baylibre.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add flexibility by moving the yuv422 en bit to SoC specific config

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
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
2.35.1

