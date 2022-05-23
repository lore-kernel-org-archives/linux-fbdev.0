Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB35DC433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 23 May 2022 10:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiEWKwJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 23 May 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiEWKvp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 23 May 2022 06:51:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825082CCB6
        for <linux-fbdev@vger.kernel.org>; Mon, 23 May 2022 03:51:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y24so744728wmq.5
        for <linux-fbdev@vger.kernel.org>; Mon, 23 May 2022 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L59GiR9dWwoU3bIhqqTo2XYxtqfhGwikIlZ2jdUecpc=;
        b=2GpBC1024UFGepfN4EeJgCuO1UN/4rP8fzM4ZTL1Oy3Eb3PQ2YbsieGfwd/wr19Az/
         vWLap0skRbcSkUKW+aQZeMenpJ688qxeEMD6FtIdTctSUfNDjNU3ehuSa8LsbZCQyUSK
         Zy+t65L6dGDUIql6D2yeRE+ALRoFTHsQeKMF2wqO2ShIe7QcffeUStrl7exDqGkmebos
         xLpftSD8FbLe/y/SJYDwky1vcICDBek0D4TMe/W6PIp1v0fzs2QFFKULXHPK5y2KoT2H
         8pWePMqWJBCozqwdHN94XLhrb7SeHk7Zo861HG5+ZCYdcczXlH57WTcJRxLCU2WW9NiG
         XpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L59GiR9dWwoU3bIhqqTo2XYxtqfhGwikIlZ2jdUecpc=;
        b=ZryCbrz6825Qwr/uuyj5UCoFThv10ZuCYpxXehhrCgnscNStgsbh8xeaBuNDyOf741
         12XwTkyS2OzL5EodPweOw+oNRJUAEV7j22AUhdcCkXDO/ksYNclPI3eLYQ1ttx+w5tfL
         b5NqjH1BIGVzcDpe3xxijM7awGiJ1n3Jj4m6RMxVd2RRCQYDyQNM/RVwzYRICkzxxnZq
         7GeIcNpB2TdgfNI9F8uJKmlV8sBE2OYrOtVW1bpiU0IuBHtNMf2mohB+sTWlQy/RkfiU
         xFJawJyFNKyC4VoJQ0Io00KtvLEY/9KuDEQg7Yk+7z+aIwFm3+M49S/cz1d2IJ4cbQ19
         qjTQ==
X-Gm-Message-State: AOAM533V10GK3kNrgoj0Ff2iXfYaxDhCB6S5VIIuZDq0dALKLJ8zBkLI
        FNq6duQAw1SueCnoeDWynhQqQw==
X-Google-Smtp-Source: ABdhPJwNegNr44So8xq4D2p9JaCnMXp0VvpDOo2fky113Q7b9TeovIyeLXQjxBiFJh/CiujqFzERLQ==
X-Received: by 2002:a05:600c:3048:b0:394:436b:76b6 with SMTP id n8-20020a05600c304800b00394436b76b6mr19844563wmh.63.1653303103041;
        Mon, 23 May 2022 03:51:43 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6141-9d1b-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6141:9d1b:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bc5cb000000b003942a244f38sm8453607wmk.17.2022.05.23.03.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:51:42 -0700 (PDT)
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
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v10 15/21] drm/mediatek: dpi: Only enable dpi after the bridge is enabled
Date:   Mon, 23 May 2022 12:47:48 +0200
Message-Id: <20220523104758.29531-16-granquet@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523104758.29531-1-granquet@baylibre.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Enabling the dpi too early causes glitches on screen.

Move the call to mtk_dpi_enable() at the end of the bridge_enable
callback to ensure everything is setup properly before enabling dpi.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 763bfb700135..a6b6d62a17e7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -478,7 +478,6 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 	if (dpi->pinctrl && dpi->pins_dpi)
 		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
 
-	mtk_dpi_enable(dpi);
 	return 0;
 
 err_pixel:
@@ -711,6 +710,7 @@ static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
 
 	mtk_dpi_power_on(dpi);
 	mtk_dpi_set_display_mode(dpi, &dpi->mode);
+	mtk_dpi_enable(dpi);
 }
 
 static enum drm_mode_status
-- 
2.35.1

