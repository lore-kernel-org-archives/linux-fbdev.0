Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CEC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Feb 2022 14:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiBRO5r (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Feb 2022 09:57:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiBRO50 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Feb 2022 09:57:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB011A3E
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Feb 2022 06:56:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c192so5421403wma.4
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Feb 2022 06:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ShbwZ80LmFKnV7XTCTWddvBgAcwyS+Rlr/cQnWDh+r8=;
        b=TlvVaSawjag5QcCFrxOeydzjezBCwYA71bAh5NjNpv3SHN6mqttytcIZ1ZgpBwKBhm
         rfezW9xKGlKKy1maOF0q0bZ8eb7bdAdt3KImIxdsP4RGbc6xusqEay/AvTrvAJqQFXG2
         dFIYcwHJUnJKRK5mHz9wwLo7pz8tFPX24yMCFluQA8LhYto3jG+pxfhSE4BHc4ydSuYQ
         FWjcKhv99vqLAw5J5Ij9ED2zWsNF0alEUiHfeRsqnM9UnQlIlw1hoP080u7AuNamg0Nc
         /cGm5OlLFhP3l+rDTAT9YHDNeOe/jnE801jLgnj8e3a6tQD+NefNHPIkBSjT29J3iuSe
         Lsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ShbwZ80LmFKnV7XTCTWddvBgAcwyS+Rlr/cQnWDh+r8=;
        b=0C/FbXM1MVjP2+avawtQKZZQxPB1NiBk5yB4MJamclo8loN5hJlcjtX0PuOQgawhvs
         /7JtNWLxbs+jmyBb8Gf7L3jx2gtfKG82VmZI1VYMifGy9QuuwSdiSaAse67rrcu+szYt
         yk1K2v7cJL5iVBFC8vZiOpZmf74hPL7kD2yN/MbWnGAvfHkxdTUcmwtOLQaPoCpldPgH
         adec8DdCzOamMzJuhj9T5VAiJbG5PsVE+VQjV3+9LAn9YZyIBgvSwKKbmGqy8DIXUKZK
         tdoW/LKp5qCNfIjc//1jYZUhylUiKrjBW77SCHtKfrqZWPW2FV0dM9iEyMWRKtqI5QRU
         jcig==
X-Gm-Message-State: AOAM532TC5c4pX2uqG9aIVB+7ecFdsbDcH+iR2a8Nya7kxKXcjN6WGf/
        6+aqxp4kqwykpfPjJ0oO262Iog==
X-Google-Smtp-Source: ABdhPJxQb+ScIrjd3rfZdwkrYFFMK8Y51NEi9X9M09wLIOSbidtouCx2ztOxoRTCWFl9dttaBKNF5w==
X-Received: by 2002:a1c:4408:0:b0:37b:c7f0:a36e with SMTP id r8-20020a1c4408000000b0037bc7f0a36emr7420230wma.186.1645196196839;
        Fri, 18 Feb 2022 06:56:36 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6241-3b28-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6241:3b28:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id b10sm47431454wrd.8.2022.02.18.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:56:36 -0800 (PST)
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
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v8 18/19] drm/mediatek: change the aux retries times when receiving AUX_DEFER
Date:   Fri, 18 Feb 2022 15:54:36 +0100
Message-Id: <20220218145437.18563-19-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218145437.18563-1-granquet@baylibre.com>
References: <20220218145437.18563-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Jitao Shi <jitao.shi@mediatek.com>

DP 1.4a Section 2.8.7.1.5.6.1:
A DP Source device shall retry at least seven times upon receiving
AUX_DEFER before giving up the AUX transaction.

Aux should retry to send msg whether how many bytes.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index fe91ab8b2fd89..4e880d8a8a186 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1879,7 +1879,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 	bool is_read;
 	u8 request;
 	size_t accessed_bytes = 0;
-	int retry = 3, ret = 0;
+	int retry, ret = 0;
 
 	mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
 
@@ -1913,15 +1913,21 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 	}
 
 	if (msg->size == 0) {
-		ret = mtk_dp_aux_do_transfer(mtk_dp, is_read, request,
-					     msg->address + accessed_bytes,
-					     msg->buffer + accessed_bytes, 0);
+		retry = 7;
+		while (retry--) {
+			ret = mtk_dp_aux_do_transfer(mtk_dp, is_read, request,
+						     msg->address + accessed_bytes,
+						     msg->buffer + accessed_bytes, 0);
+			if (ret == 0)
+				break;
+			msleep(50);
 		}
 	} else {
 		while (accessed_bytes < msg->size) {
 			size_t to_access =
 				min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES,
 				      msg->size - accessed_bytes);
+			retry = 7;
 			while (retry--) {
 				ret = mtk_dp_aux_do_transfer(mtk_dp,
 							     is_read, request,
-- 
2.34.1

