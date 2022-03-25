Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA20C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Mar 2022 17:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377413AbiCYRSq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377321AbiCYRSo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Mar 2022 13:18:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A596E995F
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:17:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so4780205wmp.5
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0UyPlWzo4y5KtqMIJtLeHp3pqp/XkkAPry5DhA+scQ=;
        b=nK1lACwsSe7yZ3o29QQ6+6LAQXlxmu33SzVyzVt0/58cIz6yqIZK4LVHTdn/y/nXa5
         /phwBmD8Xwg45AKK2t28fX0I+lQWTfsIC5T370z21ccs1KQN4iKIA7ud0yQAqta2HWyL
         TeQ37+O1zjxS5J6PF+PZvfkRpKYaOcngE9UCN0pClS16YPQVAm1tSnJS3conrPYsL2+j
         GTY9h2ht0vbLF5K5xr/k8DalzyZmBr6jf2ZGRdlooXYNI5DG2l6pTXxyes3xxGPw9ypn
         nnZaeIjkaBPqjPI7gWan+GxMlcwfC1cDuPjjR5rUNKGsMPiB+i0cMnOfRZCT37p1TbwL
         jb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0UyPlWzo4y5KtqMIJtLeHp3pqp/XkkAPry5DhA+scQ=;
        b=aHvP10Xe6nRzQO+xdJpifVh6HXghA6rJsOxlSRDcfD5pKukIO3UfC7S9ziQR98Bnlq
         Vl3EZtiI68axZ8Ikx0ZqyL8nlWj+1I0+fpJ9SYAX8qM2d7nPwjyV37LyTBh7BSteydb/
         32dRMJ/Bo14ExOmK3Peh20JLdw8PWjKPJYcQSDamYkvdHb0U3qXsKhF6i8flU3T70BLg
         ajj1DMDzlYceGHw/CgTcEDWFJsn0hsQeXJgGuwwhzw1e7NSTHbDXN2Ftzh0YQ+MnK1a8
         W6Rt3LM4uZoLfFTRCFMlmK/8V3CiOL5t7Dn2Xeu3cX9SS11M+0q32NBoTM9NhIxNJFsX
         SvUA==
X-Gm-Message-State: AOAM530/3H0tEBDb7c+TJUHpMDCskDx6y2g08GxO13GrQG5t5JPwwJqR
        U7Q8cTDdsJ32XJFdgd7gXhVMsw==
X-Google-Smtp-Source: ABdhPJyXo6ik6r6RQSTysIePMHUG22CLd2y8/JaDeZs3aASy/dXgh8ev1U594xWC7kSgpqvduNejAg==
X-Received: by 2002:a05:600c:4e4b:b0:38c:eebc:2ec4 with SMTP id e11-20020a05600c4e4b00b0038ceebc2ec4mr2058412wmq.47.1648228619892;
        Fri, 25 Mar 2022 10:16:59 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:16:59 -0700 (PDT)
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
Subject: [PATCH 08/22] drm/mediatek: dpi: implement a CK/DE pol toggle in SoC config
Date:   Fri, 25 Mar 2022 18:14:57 +0100
Message-Id: <20220325171511.23493-9-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325171511.23493-1-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com>
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

