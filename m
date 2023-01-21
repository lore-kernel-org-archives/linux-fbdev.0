Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2322C38A23
	for <linux-fbdev@archiver.kernel.org>; Sat, 21 Jan 2023 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjAUPg1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAUPg0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 21 Jan 2023 10:36:26 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF528D1C;
        Sat, 21 Jan 2023 07:36:25 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674315384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8lIE+6WE9tMl1ZMBNy5CDlevzKnMkbivuT3ciwYp14=;
        b=M7hXj4cJw6RZF9uP8KLgmLQDXunN7Qm53brTFHZS4XI4bqRtYqKkPUa5kS1tgs81nIhYyX
        Xvo74sWyjF5tOPeeLlkNwEQEoBz2/4MGbWD0ONVuXAZ5ASJu3lZISESewHbSNzMCzaCxUB
        P/FyRiTLpqgS1pja107xW1VfFp3U+lo=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Rayyan Ansari <rayyan@ansari.sh>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer: Document physical width and height properties
Date:   Sat, 21 Jan 2023 15:35:44 +0000
Message-Id: <20230121153544.467126-3-rayyan@ansari.sh>
In-Reply-To: <20230121153544.467126-1-rayyan@ansari.sh>
References: <20230121153544.467126-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 .../devicetree/bindings/display/simple-framebuffer.yaml   | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index dd64f70b5014..eb33bfd805db 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -106,6 +106,14 @@ properties:
       - x2r10g10b10
       - x8r8g8b8
 
+  width-mm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Physical width of the display in millimetres
+
+  height-mm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Physical height of the display in millimetres
+
   display:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Primary display hardware node
-- 
2.39.0

