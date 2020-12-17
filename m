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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA99C2BBCA
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Dec 2020 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4D82396F
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Dec 2020 15:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgLQPBp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Dec 2020 10:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgLQPBn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Dec 2020 10:01:43 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DCDC061282;
        Thu, 17 Dec 2020 07:01:03 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j1so15290866pld.3;
        Thu, 17 Dec 2020 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uLokb1zRx1pVQtgPWP34wo6n/+dXy4QhhwmVGwjuvfc=;
        b=ub6jL/E+F3B6rndOOnb07mdMaDUhiJvCATbBW0ySIpaiDYgDNmn0vEZpCK59yNodtO
         M1abDcM0naQBhhNh7mp0FtTTDoc6oD2a7s3fzoyeOaqeogrTex91gRJ8Aa+zG9aJA0g6
         mJEIB0RYNQPZMSAtOj9dh6E/SxFRBhpxVk23IqoS2k+MxIsew4o+SZqRdRTZnthI1XFF
         12v7tpZYYxClhN6h4eaafwPoDQgoiEdtRSSVsjhbpVEsTg9tCSZ8moyD68rzelTc2dNP
         vLE2BKWzxwEThKyT3OsFf+PJPeGgP1FVKQHxHVsRebp1w2k8t7KCQkrSf3ytJ4gToJDX
         aCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uLokb1zRx1pVQtgPWP34wo6n/+dXy4QhhwmVGwjuvfc=;
        b=Hw3IHVZilROWeL0Z+mTd4WDtsvWAuqz/l0tosD2w7STZB4uDsQ1bvRACaOAVlg42HZ
         +aB16uo13TafFrR5XX8KxtKOUPVhDyhfeZfE2k+7a0DAK9wyZEEnwj1ZS/RZmU4jaEHO
         npv0nYe5/RcOQFNNvt7LoF1YEWcIXrjNH25aIQddb356zgxG7gbV1flZ+p8WtvBJ7QsL
         szufG8Jl911Zf6AFDutboyu/zmCZ+sDTZwPwjraTx4/PXOeCksFPNgmHEla1H2097L9h
         zvGI8WkjT1fW8N/C1TioTEGafzmYjnFz2ka45C6Wt825BeZ1EI3Kafj5HtePmOqhrE/A
         aWHg==
X-Gm-Message-State: AOAM532DjejIucce+JtAv8+K+UMcOrTxx/XsZlGBcYV48IBC/wjLsZ3R
        BcWH0fkzOH2fi/pZ2ocod3JpaUzPsACCHg==
X-Google-Smtp-Source: ABdhPJwmZX7FmTkkEOY4Zsnrlt9rHB7T7g1cBvG+lCLqSPtLnUp2X8/P6HQuqalmt/fZ/tBY4ZBb2Q==
X-Received: by 2002:a17:90a:2a42:: with SMTP id d2mr8261488pjg.42.1608217263011;
        Thu, 17 Dec 2020 07:01:03 -0800 (PST)
Received: from localhost.localdomain (1-171-2-187.dynamic-ip.hinet.net. [1.171.2.187])
        by smtp.gmail.com with ESMTPSA id o140sm6189074pfd.26.2020.12.17.07.01.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:01:02 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH v5 2/6] backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight
Date:   Thu, 17 Dec 2020 23:00:40 +0800
Message-Id: <1608217244-314-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608217244-314-1-git-send-email-u0084500@gmail.com>
References: <1608217244-314-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 backlight.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v5
- Drop the example in dt-binding. Aready full example in mfd dt-binding.

since v3
- Move inlcude/dt-bindings/leds/rt4831-backlight.h from patch 0004 to here.
- Add dual license tag in header and backlight binding document.
- Left backlight dt-binding example only.
---
 .../leds/backlight/richtek,rt4831-backlight.yaml   | 65 ++++++++++++++++++++++
 include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
 create mode 100644 include/dt-bindings/leds/rt4831-backlight.h

diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
new file mode 100644
index 00000000..4da6a66
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/richtek,rt4831-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4831 Backlight
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT4831 is a mutifunctional device that can provide power to the LCD display
+  and LCD backlight.
+
+  For the LCD backlight, it can provide four channel WLED driving capability.
+  Each channel driving current is up to 30mA
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
+
+properties:
+  compatible:
+    const: richtek,rt4831-backlight
+
+  default-brightness:
+    description: |
+      The default brightness that applied to the system on start-up.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 2048
+
+  max-brightness:
+    description: |
+      The max brightness for the H/W limit
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 2048
+
+  richtek,pwm-enable:
+    description: |
+      Specify the backlight dimming following by PWM duty or by SW control.
+    type: boolean
+
+  richtek,bled-ovp-sel:
+    description: |
+      Backlight OVP level selection, currently support 17V/21V/25V/29V.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    default: 1
+    minimum: 0
+    maximum: 3
+
+  richtek,channel-use:
+    description: |
+      Backlight LED channel to be used.
+      BIT 0/1/2/3 is used to indicate led channel 1/2/3/4 enable or disable.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 15
+
+required:
+  - compatible
+  - richtek,channel-use
+
+additionalProperties: false
diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-bindings/leds/rt4831-backlight.h
new file mode 100644
index 00000000..125c635
--- /dev/null
+++ b/include/dt-bindings/leds/rt4831-backlight.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for rt4831 backlight bindings.
+ *
+ * Copyright (C) 2020, Richtek Technology Corp.
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#ifndef _DT_BINDINGS_RT4831_BACKLIGHT_H
+#define _DT_BINDINGS_RT4831_BACKLIGHT_H
+
+#define RT4831_BLOVPLVL_17V	0
+#define RT4831_BLOVPLVL_21V	1
+#define RT4831_BLOVPLVL_25V	2
+#define RT4831_BLOVPLVL_29V	3
+
+#define RT4831_BLED_CH1EN	(1 << 0)
+#define RT4831_BLED_CH2EN	(1 << 1)
+#define RT4831_BLED_CH3EN	(1 << 2)
+#define RT4831_BLED_CH4EN	(1 << 3)
+#define RT4831_BLED_ALLCHEN	((1 << 4) - 1)
+
+#endif /* _DT_BINDINGS_RT4831_BACKLIGHT_H */
-- 
2.7.4

