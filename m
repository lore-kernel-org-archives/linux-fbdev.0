Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3397AC4332F
	for <linux-fbdev@archiver.kernel.org>; Sun, 27 Mar 2022 22:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiC0Wms (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 27 Mar 2022 18:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbiC0Wmp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 27 Mar 2022 18:42:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F53336F
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so7538069wmb.3
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqdfmywTZ6fQ/7jJTAQIW5tJoHGg7kZG5yl6dza7Kzg=;
        b=KCIWiS+0zeAyMkBL0wxf40noDXnqtZrHjzyoklsSwYQXIZoSJjMZD5B0tlff61mKEa
         uUbpknkL0mh0Pe72eUpIJ8pE/35wd3aNUjvtj0ZBGrGFedALY7vVPRoA3znHAAadwzNq
         vGXrPkZgHnCK6wmY0ZZuAvSFHFl/KN6RglaSUMvpuKqTUw8Wb7lmssosBrjyDGDEXuad
         CJnlZ7FUsflKFD4nFCHkPumFs4DvX7Qg7fkJSKwmwO0VM7EtBnWXTBvxl4/5NWUDwBvG
         O78uxOpvi6ZG35LDGemTz4JIgKt6vkwrw0ekCZdsubL4S8VzdsBRrqRi7Z8nM0l8cP4g
         cPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqdfmywTZ6fQ/7jJTAQIW5tJoHGg7kZG5yl6dza7Kzg=;
        b=c/9B50PcJ74Q3XF/QoM4IoX2Voxbu7FmLIQppwAyTk6xup2PLFL1052Yx6/MYb+Hu1
         BOU7jywzseUz5kTELqzSyhcv1XjNLtKUfYNYMmOrIeLxBW/kW5BinJCJXkSHnM4E7QxS
         6VwyR612wQ8V8Jo0NKMSC9QZ+/i9WC/WpCooqW2sJgcgwyMEodKAHA143IQage9fJ3KO
         q1TTKt6OpKy42WpJeWcYGfNVXC3DXwlUK5Ph4ftlKrNDUMy1zTsyVK8zXFthKRlFT7Op
         N3e3I2xVKzsox4mI878yRqnRYOHkg7OzED3joNBmbT3EojtuJS/MnRUFKNTLXYl6hLQo
         2K1Q==
X-Gm-Message-State: AOAM532JOXSZnja1UPBfHekRjMXe8yHNZsTbolb0EAWVKhQ+UOfq9Zm0
        BQ3P8mX8rv+lhTwtiBCYdqVFnA==
X-Google-Smtp-Source: ABdhPJy0020PNRnBryews9tUG9uCMRDQysFLPzguWnTnvfaXr6qBSJOtbKhCXT5aSzXNCHr2ZIhXZg==
X-Received: by 2002:a05:600c:12c9:b0:38c:b319:6da2 with SMTP id v9-20020a05600c12c900b0038cb3196da2mr31709200wmd.125.1648420864103;
        Sun, 27 Mar 2022 15:41:04 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:03 -0700 (PDT)
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
Subject: [PATCH v9 04/22] drm/edid: Convert cea_sad helper struct to kernelDoc
Date:   Mon, 28 Mar 2022 00:39:09 +0200
Message-Id: <20220327223927.20848-5-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
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

