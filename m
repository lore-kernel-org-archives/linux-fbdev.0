Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A3C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Mar 2022 17:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiCYRTG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377332AbiCYRSh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Mar 2022 13:18:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382BFE9C8B
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:16:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so9385400wms.2
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqdfmywTZ6fQ/7jJTAQIW5tJoHGg7kZG5yl6dza7Kzg=;
        b=6bXchobGzN8pKvh+gXq4jQSUpRYYt6KibxSAsqSutu1/Yix1bAtFWio+4+5L2OT8gO
         KRwuxVreNneXSQGczLUHqu/9HMPhxIRfgbJW/r3UPWCbrTyCufwjX5onl9UM5gV/JWhK
         zUAlnmhVP2Md/IVwZvzxDWkkSGER0G02QgvLhUL/X7jArek2m0p9TQei65y4Fqg0z9RB
         F6/adAuTQCOPL7XbJ907Vf3vNG3Pv+ViBiGQYC4xuV49DFVqBZv5yCQRWsvtbUueYzoS
         Hl22196SiZd0bGZTvV+MLU+u/PO6RWkOpZhSUmnIt+Vic3k1GEXhwXmSAMdccnZ7lakM
         fwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqdfmywTZ6fQ/7jJTAQIW5tJoHGg7kZG5yl6dza7Kzg=;
        b=wdXU+W7mmm/bkeohhdXRD8azAjQopUW8biSmQ+co6h0FY68+RE2xHk1he1sKMNwVt+
         xeNQz3xlxoLfyc5HBrLCx49IysR0VhDkTUbm3u/zRabyiAz41c8JnQ9+orqTPAx2bnvx
         rMTr24Qz4Ky35jS5Ka8IkskQNY8C7T+ZEz4fOvvwvi1kXACf7aOY0H4/3mVCBnpOsQIo
         7iKCWL5tBKCkcdFxVBuIlGVHAato3N6DNkFvIGxgKNVX5xI25Ba1VashawS3mECecmTX
         Qs8N4q53kKk+7Y6UigLvGoCedckP1f+fRqX/wxaD3Ssq9WjzXAXEk7Kj2PVM+OQ6kLx8
         m3lw==
X-Gm-Message-State: AOAM533Y2McOuGhzHwBoJD+xWHp6P6/9GNihfvvUwHWni/3eisV30jr3
        ryI9E0M7MEGkBxkL986hla2Oow==
X-Google-Smtp-Source: ABdhPJztbg41uIEn6kYbSEgV3LT+xnRXVt+kN+pXwZTNOue5R4lV3fouoQj4ndoTzsNVOsRmWuPg8Q==
X-Received: by 2002:a7b:c30c:0:b0:38c:8ff1:625b with SMTP id k12-20020a7bc30c000000b0038c8ff1625bmr20345780wmj.30.1648228611391;
        Fri, 25 Mar 2022 10:16:51 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:16:51 -0700 (PDT)
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
Subject: [PATCH 04/22] drm/edid: Convert cea_sad helper struct to kernelDoc
Date:   Fri, 25 Mar 2022 18:14:53 +0100
Message-Id: <20220325171511.23493-5-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325171511.23493-1-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 include/drm/drm_edid.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 144c495b99c4..5d4d840b9904 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -359,12 +359,17 @@ struct edid {
 
 #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1] << 8))
 
-/* Short Audio Descriptor */
+/* struct cea_sad - Short Audio Descriptor.
+	@format: See HDMI_AUDIO_CODING_TYPE_*.
+	@channels: max number of channels - 1.
+	@freq: See CEA_SAD_FREQ_*.
+	@byte2: meaning depends on format.
+*/
 struct cea_sad {
 	u8 format;
-	u8 channels; /* max number of channels - 1 */
+	u8 channels;
 	u8 freq;
-	u8 byte2; /* meaning depends on format */
+	u8 byte2;
 };
 
 struct drm_encoder;
-- 
2.34.1

