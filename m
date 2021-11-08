Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED5EC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 Nov 2021 18:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C20761055
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 Nov 2021 18:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhKHSgV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:36:21 -0500
Received: from ixit.cz ([94.230.151.217]:53196 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhKHSgU (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 8 Nov 2021 13:36:20 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 69D5120064;
        Mon,  8 Nov 2021 19:33:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1636396413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SYqiyfi+3LLQOhgIjPN+BSk4wD1o6OGfvuU5++WE4bY=;
        b=VkDvwfZGh/xG+Amnk/ymrl1ZPYnxvkpz8BlSEx7ZDzLG56ck4luz9o6IPw5qWYHj1IIugJ
        lpzWKJmGpSbeATPvaH68zgxFOQRFGtgs3N6Rwy/FUyTQIXNRmyJ/cZpxPnX/DG1QBxwyre
        n8K/P7qbCfXIIYbPwLjdNChcFMvfmw8=
From:   David Heidelberg <david@ixit.cz>
To:     Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: sync formats with simplefb.h
Date:   Mon,  8 Nov 2021 19:33:22 +0100
Message-Id: <20211108183322.68192-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Sync all formats from simplefb.h into documentation.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/display/simple-framebuffer.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index c2499a7906f5..44a29d813f14 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -83,13 +83,25 @@ properties:
   format:
     description: >
       Format of the framebuffer:
+        * `a1r5g5b5` - 16-bit pixels, d[15]=a, d[14:10]=r, d[9:5]=g, d[4:0]=b
+        * `a2r10g10b10` - 32-bit pixels, d[31:30]=a, d[29:20]=r, d[19:10]=g, d[9:0]=b
         * `a8b8g8r8` - 32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r
+        * `a8r8g8b8` - 32-bit pixels, d[31:24]=a, d[23:16]=r, d[15:8]=g, d[7:0]=b
         * `r5g6b5` - 16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b
+        * `r5g5b5a1` - 16-bit pixels, d[15:11]=r, d[10:6]=g, d[5:1]=b d[1:0]=a
+        * `r8g8b8` - 24-bit pixels, d[23:16]=r, d[15:8]=g, d[7:0]=b
+        * `x1r5g5b5` - 16-bit pixels, d[14:10]=r, d[9:5]=g, d[4:0]=b
         * `x2r10g10b10` - 32-bit pixels, d[29:20]=r, d[19:10]=g, d[9:0]=b
         * `x8r8g8b8` - 32-bit pixels, d[23:16]=r, d[15:8]=g, d[7:0]=b
     enum:
+      - a1r5g5b5
+      - a2r10g10b10
       - a8b8g8r8
+      - a8r8g8b8
       - r5g6b5
+      - r5g5b5a1
+      - r8g8b8
+      - x1r5g5b5
       - x2r10g10b10
       - x8r8g8b8
 
-- 
2.33.0

