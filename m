Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50816C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Mar 2022 19:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiCYTrd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiCYTrZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Mar 2022 15:47:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052943D8F0D
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 12:30:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id e16so14960362lfc.13
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQqH7RE8MK40fYi7hpHL4DQe6UoMb5CeZccvHzoocCY=;
        b=HACFnoQINTauO6TKeIefRi9vM/en2n66uEqYmJBdSo4ooC8iGMFaFYF18rGW5rhOLS
         bQBwiT+gV33kC1eSID8QefbZoxMx1SeimigboDvyhnvVH6AhiSLshOUyK11pVRjezrQI
         C1/E6jXK/MK9rxuRK8Dtwr9ZOr0gG1Rl40ZKbLsmg7FH5fXdFMYInNf0tqcfZ3P4nbTT
         bnZqeCMSG+v6DzrN8ISz0nB5vMkTFV/0h2KmbU4o3ptSXlNi2aRjuw/Z/fAxrJXLG6lh
         PeNp2DZYgQ2YtPg+O49kL36qOahs2e9oPI2DIEhxXknnZ+d5nb8osxGA4BWQgL/N4DIN
         4qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQqH7RE8MK40fYi7hpHL4DQe6UoMb5CeZccvHzoocCY=;
        b=TiT+lm9BqEBYl1+adNcn5h9pZuHBOE9pX6/n9AGDZZeNPqoSxNFqmn8Kxr/b57P6to
         S+jYIBCyq1kiGotjfFh6iPazHK6dDV99x6tkr28C7VRhXkGd53ozvMcmSV3QeOqHyuE6
         7ZakZvBef9juEvY08XxsqzPE5eglx1/DKeTt/4h38/F0uca8fU2bUPiJ2Mhd05mNaJ0S
         c8WiZjgUOEiYr3fs7G0/epXixs4F8Jum/W+fjdQ5iPPVDZpah1tKjgXqnCXd23HIhgKC
         /RDxupw8GvfJkJUlZXrqUZgVwEnvKtwvr4bGpJqU66oevbwlsx6rLhpVtGlZk1wvHg5e
         1pGw==
X-Gm-Message-State: AOAM532k8bCJwCUrQK/MDICvHnPNd8g/yd1x3RqcuUXKS77w9f3ztHBw
        Aj/0uABX/Nd/fiQCtLeKUBzEvPWrK67Amg==
X-Google-Smtp-Source: ABdhPJykkJ59FKYm8DQF+mpfHc6QKyYL4B/eRIG1b3yUyL1vz+MK/Wc9y/AlvWXIwnWFRgxsWLzrTA==
X-Received: by 2002:a5d:4ec7:0:b0:203:de83:6f44 with SMTP id s7-20020a5d4ec7000000b00203de836f44mr10022067wrv.56.1648228647982;
        Fri, 25 Mar 2022 10:17:27 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:17:27 -0700 (PDT)
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
        markyacoub@google.com, Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH 20/22] drm/mediatek: add hpd debounce
Date:   Fri, 25 Mar 2022 18:15:09 +0100
Message-Id: <20220325171511.23493-21-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325171511.23493-1-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Jitao Shi <jitao.shi@mediatek.com>

From the DP spec 1.4a chapter 3.3, upstream devices should implement
HPD signal de-bouncing on an external connection.
A period of 100ms should be used to detect an HPD connect event.
To cover these cases, HPD de-bounce should be implemented only after
HPD low has been detected for at least 100ms.

Therefore,
1. If HPD is low (which means plugging out) for longer than 100ms:
   we need to do de-bouncing (which means we need to wait for 100ms).
2. If HPD low is for less than 100ms:
   we don't need to care about the de-bouncing.

In this patch, we start a 100ms timer and use a need_debounce boolean
to implement the feature.

Two cases when HPD is high:
1. If the timer is expired (>100ms):
   - need_debounce is true.
   - When HPD high (plugging event comes), need_debounce will be true
     and then we need to do de-bouncing (wait for 100ms).
2. If the timer is not expired (<100ms):
   - need_debounce is false.
   - When HPD high (plugging event comes), need_debounce will be false
     and no need to do de-bouncing.

HPD_______             __________________
          |            |<-  100ms   ->
          |____________|
          <-  100ms   ->

Without HPD de-bouncing, USB-C to HDMI Adapaters will not be detected.

The change has been successfully tested with the following devices:
- Dell Adapter - USB-C to HDMI
- Acer 1in1 HDMI dongle
- Ugreen 1in1 HDMI dongle
- innowatt HDMI + USB3 hub
- Acer 2in1 HDMI dongle
- Apple 3in1 HDMI dongle (A2119)
- J5Create 3in1 HDMI dongle (JAC379)

Tested-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index d9606c743a9e..4981a3a3b9ca 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -174,6 +174,33 @@ struct mtk_dp {
 	struct device *codec_dev;
 	u8 connector_eld[MAX_ELD_BYTES];
 	struct drm_connector *conn;
+	bool need_debounce;
+	struct timer_list debounce_timer;
+};
+
+enum mtk_dp_sdp_type {
+	MTK_DP_SDP_NONE = 0x00,
+	MTK_DP_SDP_ACM = 0x01,
+	MTK_DP_SDP_ISRC = 0x02,
+	MTK_DP_SDP_AVI = 0x03,
+	MTK_DP_SDP_AUI = 0x04,
+	MTK_DP_SDP_SPD = 0x05,
+	MTK_DP_SDP_MPEG = 0x06,
+	MTK_DP_SDP_NTSC = 0x07,
+	MTK_DP_SDP_VSP = 0x08,
+	MTK_DP_SDP_VSC = 0x09,
+	MTK_DP_SDP_EXT = 0x0A,
+	MTK_DP_SDP_PPS0 = 0x0B,
+	MTK_DP_SDP_PPS1 = 0x0C,
+	MTK_DP_SDP_PPS2 = 0x0D,
+	MTK_DP_SDP_PPS3 = 0x0E,
+	MTK_DP_SDP_DRM = 0x10,
+	MTK_DP_SDP_MAX_NUM
+};
+
+struct mtk_dp_sdp_packet {
+	enum mtk_dp_sdp_type type;
+	struct dp_sdp sdp;
 };
 
 static bool mtk_dp_is_edp(struct mtk_dp *mtk_dp)
@@ -1814,6 +1841,9 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 	if (event < 0)
 		return IRQ_HANDLED;
 
+	if (mtk_dp->need_debounce && mtk_dp->train_info.cable_plugged_in)
+		msleep(100);
+
 	if (mtk_dp->drm_dev) {
 		dev_info(mtk_dp->dev, "drm_helper_hpd_irq_event\n");
 		drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
@@ -1892,6 +1922,11 @@ static irqreturn_t mtk_dp_hpd_isr_handler(struct mtk_dp *mtk_dp)
 	}
 	train_info->cable_state_change = true;
 
+	if (!train_info->cable_plugged_in) {
+		mod_timer(&mtk_dp->debounce_timer, jiffies + msecs_to_jiffies(100) - 1);
+		mtk_dp->need_debounce = false;
+	}
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -2339,6 +2374,13 @@ static const struct drm_bridge_funcs mtk_dp_bridge_funcs = {
 	.detect = mtk_dp_bdg_detect,
 };
 
+static void mtk_dp_debounce_timer(struct timer_list *t)
+{
+	struct mtk_dp *mtk_dp = from_timer(mtk_dp, t, debounce_timer);
+
+	mtk_dp->need_debounce = true;
+}
+
 static int mtk_dp_probe(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp;
@@ -2396,6 +2438,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	mtk_dp->bridge.of_node = dev->of_node;
 	mtk_dp->bridge.type = DRM_MODE_CONNECTOR_eDP;
 
+	mtk_dp->need_debounce = true;
+	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
+
 	mtk_dp->bridge.ops =
 		DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
 	drm_bridge_add(&mtk_dp->bridge);
@@ -2415,6 +2460,7 @@ static int mtk_dp_remove(struct platform_device *pdev)
 	struct mtk_dp *mtk_dp = platform_get_drvdata(pdev);
 
 	mtk_dp_video_mute(mtk_dp, true);
+	del_timer_sync(&mtk_dp->debounce_timer);
 
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.34.1

