Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E153CC3526B
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Dec 2020 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5293235F9
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Dec 2020 15:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgLQPCK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Dec 2020 10:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgLQPCJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Dec 2020 10:02:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E9AC0611CC;
        Thu, 17 Dec 2020 07:01:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f14so3788474pju.4;
        Thu, 17 Dec 2020 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mvtZ/A2o5dxmBEUAMb5gj2Nsf7pPvcRBvo5uPvFwDHA=;
        b=P5S84wnBWrc+jI977mdnBx8BHjwaLXu+wGQZucy9i+KHvwtgAq3f6PmSQf45pmX9u4
         6tw1v33TxjIdmApm69r1aNbvKfTb3FXd0XI87QmRmpV02qsbFwWZf0ouK1bjIQYGhAND
         q90Uj8kZ8zePACluJZTkaMHlyLrX6YApLih33jpLc9/31+a2kje1lG2LHVFmxLuRcKc2
         pfMrwLhFSGBPCNRf03x+9e3yJjKV5hzH+o/8A/NMQy6gVw3KXPMUVPY0dYzEx99xQoUs
         cpQT6saVYrbtqZHtxcY29gUBJnF8OuFjqEy6dC9rXGuUNEp38tKHx5JBzK2n5ZGGwI5d
         ycCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mvtZ/A2o5dxmBEUAMb5gj2Nsf7pPvcRBvo5uPvFwDHA=;
        b=Q3Clnre9Vmmz6GfZ8PH0LLwSMRn15HQ7WvGxISbKVVOvzVTbMd83SETvgbmhQsO6iq
         s5/ch+fFWTu9Gp5nLWVZ4aAP8QoE8bhMoPZr/MFN28ifs4PgfJs5omWzjN9SHUwuJHUv
         5vwPbrbzngdpD5VUANG6dxl9HXRw8hx3fqC5Q1sX7w9twBWyjMufjYqPCAk88wq46hEF
         j5lTcOWdk6RmPrhNFclm/uYH2e27pJ8qGUEDDgAbopIGmT1K24+7bbFLuivcldbtN1jY
         bN83hl/D63Y3DoRSM06bu0esFkE9TCiFvsd3dczsczBfwwI7A9t/0i6aX8akNCTKrnDm
         tp1w==
X-Gm-Message-State: AOAM533tHP17YhXxDI39/FD4lgJS5+RFsu5TePU9AVuo/E3rz4i7gYWh
        jmRRf9hSHwG4ajSyoYRo9Q4=
X-Google-Smtp-Source: ABdhPJxEqwPbhdTjXuC65gja94BfYxBMGCw0JrdDxIOxyieZUWD2PMka+Egar82GTDNdonGuOay/Wg==
X-Received: by 2002:a17:902:d716:b029:dc:24a1:77a2 with SMTP id w22-20020a170902d716b02900dc24a177a2mr3917114ply.64.1608217269785;
        Thu, 17 Dec 2020 07:01:09 -0800 (PST)
Received: from localhost.localdomain (1-171-2-187.dynamic-ip.hinet.net. [1.171.2.187])
        by smtp.gmail.com with ESMTPSA id o140sm6189074pfd.26.2020.12.17.07.01.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:01:09 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH v5 4/6] mfd: rt4831: Adds DT binding document for Richtek RT4831 core
Date:   Thu, 17 Dec 2020 23:00:42 +0800
Message-Id: <1608217244-314-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608217244-314-1-git-send-email-u0084500@gmail.com>
References: <1608217244-314-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 core.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
This patch depends on
 "backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight"
 "regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator"

since v5
- Revert mfd dt-binding to v3 patch.

since v4
- remove v3 regulator binding patch, directly merge it into mfd binding.

since v3
- Move include/dt-bindings/leds/rt4831-backlight.h to patch 0002.
- Add dual license tag in mfd binding document.

since v2
- Add regulator-allow-bypass flag in DSVLCM.
---
 .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
new file mode 100644
index 00000000..4762eb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/richtek,rt4831.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4831 DSV and Backlight Integrated IC
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT4831 is a multifunctional device that can provide power to the LCD display
+  and LCD backlight.
+
+  For Display Bias Voltage DSVP and DSVN, the output range is about 4V to 6.5V.
+  It's sufficient to meet the current LCD power requirement.
+
+  For the LCD backlight, it can provide four channel WLED driving capability.
+  Each channel driving current is up to 30mA
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
+
+properties:
+  compatible:
+    const: richtek,rt4831
+
+  reg:
+    description: I2C device address.
+    maxItems: 1
+
+  enable-gpios:
+    description: |
+      GPIO to enable/disable the chip. It is optional.
+      Some usage directly tied this pin to follow VIO 1.8V power on sequence.
+    maxItems: 1
+
+  regulators:
+    $ref: ../regulator/richtek,rt4831-regulator.yaml
+
+  backlight:
+    $ref: ../leds/backlight/richtek,rt4831-backlight.yaml
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/rt4831-backlight.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt4831@11 {
+        compatible = "richtek,rt4831";
+        reg = <0x11>;
+
+        regulators {
+          DSVLCM {
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <7150000>;
+            regulator-allow-bypass;
+          };
+          DSVP {
+            regulator-name = "rt4831-dsvp";
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <6500000>;
+            regulator-boot-on;
+          };
+          DSVN {
+            regulator-name = "rt4831-dsvn";
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <6500000>;
+            regulator-boot-on;
+          };
+        };
+
+        backlight {
+          compatible = "richtek,rt4831-backlight";
+          default-brightness = <1024>;
+          max-brightness = <2048>;
+          richtek,bled-ovp-sel = /bits/ 8 <RT4831_BLOVPLVL_21V>;
+          richtek,channel-use = /bits/ 8 <RT4831_BLED_ALLCHEN>;
+        };
+      };
+    };
-- 
2.7.4

