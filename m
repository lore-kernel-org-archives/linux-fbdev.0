Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F3AC433FE
	for <linux-fbdev@archiver.kernel.org>; Sun, 27 Mar 2022 22:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiC0Wms (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 27 Mar 2022 18:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbiC0Wml (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 27 Mar 2022 18:42:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1963732EE2
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so11969989wms.2
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Mar 2022 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=graxiB3o84XyCC7lA2maMSkd/oPaEWkbPJi06+8HrGM=;
        b=r276EMn6zYOdOurbfLe4hTRsvPqjJ/2liozB0/GajoOCtk1J38A1eXxAi87dELVHFD
         jIQad/T6yVHNCs7qRdvU6KW2IEyi1AWz8KyQEywyebq4HY/9BJFwTCiNkdkLPIEsiPJD
         +w+czgAeDkc1zhxT4f2tnVyx4V6d+RaQUV5Lf8A7mu7kmxBeqo+WCqrODKJVAwAMnsuo
         hAAvAbqojV0T4mnVTyGB9ZrF0Oy9Yw/R/ee65LQi9TJ+qiYGxrn1GbVFs4HrKsBP0XZ+
         xCriJojzWxi28tJ/jyCCo1A4PxZCAO8GHCX9ikODFPaxGMkQMYaDYbamr+XP2FZvjPLG
         OrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=graxiB3o84XyCC7lA2maMSkd/oPaEWkbPJi06+8HrGM=;
        b=0MYsnCVnjtDGMRBlmLlfA2YOTBvRG1Zbeeqwbkyvn6vYXwviOERFRKi+fhkizzRs2t
         pfRpKRG7YZsPwX1QYD9PZpeTjlZaZeT48Ycozl6yj0nGw4rZU5IuZ85jNZ219uw+N5Qy
         j8UEO+8+aw8Ve/8JUgAXYu8LWdlQBm0+KHcs3gaRU+9AiSRNb0Im1tht4vNBa3nr1xD7
         tEri7EFbTvVVwJfsWq9nwSqt7RBmL7D4LdHFiotvqkM/V1YnJaKpYwq+MYBZdeTmsfR+
         okTDU9MYA4FZTlKG/UTMH24CaRMh2dLC6fc63DgNkRzIWxXASOA+52Xml6dnmXo07xW9
         8iCQ==
X-Gm-Message-State: AOAM531l7gC2oTyG2mjYO1AT59Jy9WIznFQRD858n7ObwfT9ky4TVB1h
        Yz+qn9lJJUor5SkA02PFGeJoBA==
X-Google-Smtp-Source: ABdhPJzmOb9kMHIpbXvEe4FnZF+xfzcnwPgNHy2cJoFNqGghwOq+6/DhG8aiOft/DjBGhLjfRHk3Sw==
X-Received: by 2002:a05:600c:2192:b0:38c:8b45:ecf5 with SMTP id e18-20020a05600c219200b0038c8b45ecf5mr22498565wme.85.1648420860620;
        Sun, 27 Mar 2022 15:41:00 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:00 -0700 (PDT)
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
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v9 02/22] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Mon, 28 Mar 2022 00:39:07 +0200
Message-Id: <20220327223927.20848-3-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

This controller is present on several mediatek hardware. Currently
mt8195 and mt8395 have this controller without a functional difference,
so only one compatible field is added.

The controller can have two forms, as a normal display port and as an
embedded display port.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../display/mediatek/mediatek,dp.yaml         | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
new file mode 100644
index 000000000000..802cc406c72b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Display Port Controller
+
+maintainers:
+  - CK Hu <ck.hu@mediatek.com>
+  - Jitao shi <jitao.shi@mediatek.com>
+
+description: |
+  Device tree bindings for the Mediatek (embedded) Display Port controller
+  present on some Mediatek SoCs.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt8195-dp-tx
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: faxi clock
+
+  clock-names:
+    items:
+      - const: faxi
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: dp
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Input endpoint of the controller, usually dp_intf
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output endpoint of the controller
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/mt8195-power.h>
+    edp_tx: edisplay-port-tx@1c500000 {
+        compatible = "mediatek,mt8195-dp-tx","syscon";
+        reg = <0 0x1c500000 0 0x8000>;
+        interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&edp_pin>;
+        phys = <&dp_phy>;
+        phy-names = "dp";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                edp_in: endpoint {
+                    remote-endpoint = <&dp_intf0_out>;
+                };
+            };
+            port@1 {
+                reg = <1>;
+                edp_out: endpoint {
+                    remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
-- 
2.34.1

