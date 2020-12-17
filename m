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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C800FC3526C
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Dec 2020 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F2C23975
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Dec 2020 15:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgLQPCJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Dec 2020 10:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgLQPCI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Dec 2020 10:02:08 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE8DC0611CA;
        Thu, 17 Dec 2020 07:01:06 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f17so20486451pge.6;
        Thu, 17 Dec 2020 07:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uq92YfzmtWSjZTbKFkuyonM+askUzHgnNcGZZh6OIBk=;
        b=BZ/pEkAG2NSByMExePG8ilUyRCSSNLjLpFGVBDJgunvDWIBCGRvq9Eg3RdCFLiV4AX
         b9OsRc+j4Oh+dgQlS6IKu7e+hkC9FNpm0NekwiTIqgg8oQKXSi1LGNtn9eAknivM0fwQ
         H+LcSKm3w63za0QJB3miz243UCoNHnJKgd7I5ITL+eT7Xa0aoMJJAc0SqRNYG7xib5jw
         tjQP16Gr93TIuiLfpOkTJS4K5Ui/U76P5LQhpjRnLiUhic6Xpf5ixRBcMF0yzmc1D1XH
         yz3zrKARqerJNAFIVLmabyAijU/WHSftexQ9DCzpkaayL/slFQDlYRtH1oBsNDuLCBys
         nfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uq92YfzmtWSjZTbKFkuyonM+askUzHgnNcGZZh6OIBk=;
        b=my3KPu/HM/H1BOKOXpzML45sOYsni36OSHIZmABxmurlx/Kq+xgliQvhiXKwIxeHjk
         VHyF+1Pt6W1cBfQFsRUpuVViAe+0crMzuBMqhgEVH55Xqep8Yahg9emXUpszpd6M8ZrD
         c7F02vy/K13m3RD86PDjXtkVZ3O1COAiLGnxGLCurtUbz62IQXvMsOdqrXLp3dCU4tKA
         bPyQQqQkg9bw5JD+RsxzBwOtqLmsp4cgoFB2u72QqZedx1/2X4/xIRasyKRZMS35FMGu
         Cv6qaXw3UBmYYMRCxS54wG29FPOVItzRcbrI4eyAs8SLztU+pYRggfD1zp/uFEDXoyud
         VKYg==
X-Gm-Message-State: AOAM531O5Yp8VeVJ7yx6llWfCQt88sqxB7leHZnNNGzb46ax3zXXPJwX
        5MOdF8ZPXRO7RQktoLF9bH8=
X-Google-Smtp-Source: ABdhPJyMsnxzPBCQ1rN+mgfhydGddI2u2yYvHW7qgN9qbI6bCHKjO9xDQd7uK9+yjYyoCKSxJUWz3g==
X-Received: by 2002:a63:924f:: with SMTP id s15mr7726183pgn.360.1608217266388;
        Thu, 17 Dec 2020 07:01:06 -0800 (PST)
Received: from localhost.localdomain (1-171-2-187.dynamic-ip.hinet.net. [1.171.2.187])
        by smtp.gmail.com with ESMTPSA id o140sm6189074pfd.26.2020.12.17.07.01.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:01:05 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH v5 3/6] regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator
Date:   Thu, 17 Dec 2020 23:00:41 +0800
Message-Id: <1608217244-314-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608217244-314-1-git-send-email-u0084500@gmail.com>
References: <1608217244-314-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 DSV regulator.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v5
- Revert it back from v3 patch.
- Drop the example in dt-binding, Already full example in mfd dt-binding.
---
 .../regulator/richtek,rt4831-regulator.yaml        | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
new file mode 100644
index 00000000..d9c2333
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt4831-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4831 Display Bias Voltage Regulator
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT4831 is a multifunctional device that can provide power to the LCD display
+  and LCD backlight.
+
+  For Display Bias Voltage DSVP and DSVN, the output range is about 4V to 6.5V.
+  It is sufficient to meet the current LCD power requirement.
+
+  DSVLCM is a boost regulator in IC internal as DSVP and DSVN input power.
+  Its voltage should be configured above 0.15V to 0.2V gap larger than the
+  voltage needed for DSVP and DSVN. Too much voltage gap could improve the
+  voltage drop from the heavy loading scenario. But it also make the power
+  efficiency worse. It's a trade-off.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
+
+patternProperties:
+  "^DSV(LCM|P|N)$":
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single Display Bias Voltage regulator.
+
+additionalProperties: false
-- 
2.7.4

