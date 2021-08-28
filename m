Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCA0C432BE
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Aug 2021 11:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA18601FD
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Aug 2021 11:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhH1LL2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Aug 2021 07:11:28 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:60824 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233960AbhH1LL1 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Aug 2021 07:11:27 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Aug 2021 07:11:27 EDT
Received: from localhost.localdomain (ip-213-127-63-121.ip.prioritytelecom.net [213.127.63.121])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 97FD2C938F;
        Sat, 28 Aug 2021 11:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1630148538; bh=593ciw0QW1roD1h3TFS7025Qd9Um6NsB+kmDNsGtp2E=;
        h=From:To:Cc:Subject:Date;
        b=YP2K5BgAcdkPXUhhs/TGPxseXSfdP9tL7CEpGui+ebRwolbC6RJgoLExFn/Gi+gQI
         pb+EnTaSgi2YfGHzc52ilbSZA0liS9jVntxAKYO2gszKX4KUp8dMxuYojfTIcff2an
         F3rqQjRAwyerZbdyuSn/4ZCIchyIRxsflmqhBf+Q=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-fbdev@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: add missing simple-framebuffer formats
Date:   Sat, 28 Aug 2021 13:02:05 +0200
Message-Id: <20210828110206.142899-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Document all formats currently present in include/linux/platform_data/
simplefb.h

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../bindings/display/simple-framebuffer.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index c2499a7906f5..c1acd2859ae8 100644
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
+        * `r5g5b5a1` - 16-bit pixels, d[15:11]=r, d[10:6]=g, d[5:1]=b, d[0]=a
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

