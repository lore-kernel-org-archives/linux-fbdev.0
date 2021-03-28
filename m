Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D8FC433E1
	for <linux-fbdev@archiver.kernel.org>; Sun, 28 Mar 2021 15:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D7E61972
	for <linux-fbdev@archiver.kernel.org>; Sun, 28 Mar 2021 15:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhC1PYq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhC1PYe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 28 Mar 2021 11:24:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7FC061756;
        Sun, 28 Mar 2021 08:24:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m7so7812908pgj.8;
        Sun, 28 Mar 2021 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xNXtry2Hu3JdjVXeffx4v7Aev22e7UumqFVP1K8btoQ=;
        b=aAuR5+mdzcpvzR1mMmjxciZ/2g/D1qb9ZNVUMHd/tF+pLw2UJ1dYlX2vMCiO3KWQb7
         hCmEJglsNMpe58Ddwlvj9AOVqRLfBbodDiAeAyJVM+TilT9EVsjRGhLq2jcJ7EB+ULyZ
         oF8E8oVL0o4OSIr+ccQH98enIrDMJVGDBPeeQ7n/6E72TI4dw1rlQAW2eujfaBhKPk91
         rgOu+oUS9EjrAWKN1iSXnec8v2Que6meUrX+EmbRbhh5Xh/4nBiGZr1l4AxRd7cWUlPa
         z46EygnDfoH6f+SE/aWECPAKQZN4LUVWKpUnKfXYKcEQ6JaQysdCo//A6EyPVgnlk3Qd
         4mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xNXtry2Hu3JdjVXeffx4v7Aev22e7UumqFVP1K8btoQ=;
        b=JFmNBv1oO4O5MUoByVgFTp5wyw3PYGYbo7V0JwLD+qM+VK6//A4Ppzlm/Ko/3YsNmU
         EwViK5CGyPpuMvWPt4SLz0xd00GLE00jNtApaOwQGD2UpyM2U27E0on+j+il+qoQOMQr
         keN6hewjszaVi3lqhgCdzpQ1j3VUUInNaXY/pmbX4OivvMyEGAGxgZeM2cQRBwtNEuj2
         HSFBeui28qucOitZ5mhv/yGsf9wCxwK7QzrA2Hw7q4gvDYacw0ToAvqeP+Y/Z2Pe9Yr4
         hfW4Y+SH+Hwr8Q3eElANEsYM3kSR9g9kyCjLfERxXrEo8ys5MLJYEhojQsHBjzW7+Snz
         TwiA==
X-Gm-Message-State: AOAM533eMsGNkQIcl6VhBrA1BMbuQgG2KGd6SX5vg9o1uFXmgE/uBr6b
        cJ0IbB8lv+goYxLkPk+DIL4=
X-Google-Smtp-Source: ABdhPJwYbDf8tHmqG84H5IlUb9qidIM0U3hQCarKNIOKObdhjyWzAXcau4Gt0lCykLYmp7Zse0WVDw==
X-Received: by 2002:a65:640d:: with SMTP id a13mr20052658pgv.272.1616945073786;
        Sun, 28 Mar 2021 08:24:33 -0700 (PDT)
Received: from localhost.localdomain (1-171-1-114.dynamic-ip.hinet.net. [1.171.1.114])
        by smtp.gmail.com with ESMTPSA id j188sm14651174pfd.64.2021.03.28.08.24.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Mar 2021 08:24:33 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH v6 3/4] mfd: rt4831: Adds DT binding document for Richtek RT4831
Date:   Sun, 28 Mar 2021 23:24:18 +0800
Message-Id: <1616945059-8718-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
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

