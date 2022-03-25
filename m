Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C80C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Mar 2022 17:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354727AbiCYRTJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356595AbiCYRSf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Mar 2022 13:18:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569CE9960
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:16:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso4778917wmz.4
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Mar 2022 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWuHqcRax2E7zzIXZh7ToC5GlWwIxifW/4CmtpMgB/Q=;
        b=e9fQyZ0WE4Z9h6IyESMybIA7h3EtJ5dTgMV5mf91m3HTYR3d6PR3x3ANzlsJDjJpFX
         xyZXVKaHjuCfMF0lwm2Qu9a7yuhgIE8FNiY3Ra2C5iqjAr38LTWfu0BJ1+fhXSTWmUih
         aM3pvBv9RdHz220XVpBcXT8iiq7aPvagI4hTcp8GseBYMM+pFmDDxSClw8erRNva9gEY
         2imqr9DiFYjUmXQtnWctQLqe2NXNA30qtmtWcNWqvaW0TdlhnfPmu+EdWfkrn8Zm2deG
         A+8Q+xLGHP3uj/hxELbU2uz03u/3WDCI7leUQAxmTATuBJuts6p2eUn35MBM400RFU+U
         mxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWuHqcRax2E7zzIXZh7ToC5GlWwIxifW/4CmtpMgB/Q=;
        b=SzuQR/KSPRSTb8+kUKnFvqnxDHIE74andeEsuKj0HwIs5mpdk5XjxmnplfN9QBLNiM
         WocGKFTJNINzmSCcAEn9uqQP2v/oHE6w4q66s7HJdSfxUp5cNGDLPOv7GCs4vRZ5zFxY
         Hquq1BzvcloNxUnulb4uGkKvX1L/83t9vn2O9NRfmKK/xsKZggGOJrZI8TDgLnrLy1Yd
         PS4YtRn+riOP1O5RtVYy4QxxB9EiTdp8rPtrjFFX77SRj0gb7yFe9GA1gk2/fPxDNBwg
         2CuP+ElThmo6ePUNGP/DBBW3RyyLjydEHxloc0CL7I9aCVjhv4uYVYtSctaE3vpC/qjA
         QSxg==
X-Gm-Message-State: AOAM531dE/UUey3bi35sBwWORg2Q6bmaBWbRXpmjH7mSxXMUU1dOf532
        dLQflGTrqt+ItEF2CLCmCMGO0Q==
X-Google-Smtp-Source: ABdhPJyseADl0QeZy7YFh7ZKp586b0q8d6AxSePwH+EeyXqFYla8oR9D8vfPuUxPBa3bYk7yPTd2ig==
X-Received: by 2002:a05:600c:4e91:b0:38c:c1ac:c018 with SMTP id f17-20020a05600c4e9100b0038cc1acc018mr15761137wmq.189.1648228609419;
        Fri, 25 Mar 2022 10:16:49 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6240-cc41-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6240:cc41:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7547464wru.99.2022.03.25.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:16:49 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        markyacoub@google.com
Subject: [PATCH 03/22] dt-bindings: mediatek,dp_phy: Add Display Port PHY binding
Date:   Fri, 25 Mar 2022 18:14:52 +0100
Message-Id: <20220325171511.23493-4-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325171511.23493-1-granquet@baylibre.com>
References: <20220325171511.23493-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This phy controller is embedded in the Display Port Controller on mt8195 SoCs.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../bindings/phy/mediatek,dp-phy.yaml         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
new file mode 100644
index 000000000000..4180d40f4fa7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2022 MediaTek
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Display Port PHY binding
+
+maintainers:
+  - CK Hu <ck.hu@mediatek.com>
+  - Jitao shi <jitao.shi@mediatek.com>
+
+description: |
+  Device tree bindings for the Mediatek (embedded) Display Port PHY
+  present on some Mediatek SoCs.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-dp-phy
+
+  regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the Display Port node.
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - regmap
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    dp_phy: dp_phy {
+      compatible = "mediatek,mt8195-dp-phy";
+      regmap = <&dp_tx>;
+      #phy-cells = <0>;
+    };
-- 
2.34.1

