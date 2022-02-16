Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229EEC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Feb 2022 09:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiBPJEq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:04:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiBPJEp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 16 Feb 2022 04:04:45 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F62AD675
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Feb 2022 01:04:31 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7534:e0be:5adf:2691])
        by albert.telenet-ops.be with bizsmtp
        id vl4V2600K18GbK106l4Veb; Wed, 16 Feb 2022 10:04:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nKGEf-000wtW-Dn; Wed, 16 Feb 2022 10:04:29 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nKFrS-00CDzg-BS; Wed, 16 Feb 2022 09:40:30 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] video: fbdev: au1100fb: Spelling s/palette/palette/
Date:   Wed, 16 Feb 2022 09:40:29 +0100
Message-Id: <20220216084029.2913685-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix a misspelling of "palette" in a structure member.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/au1100fb.c | 2 +-
 drivers/video/fbdev/au1100fb.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 37a6512feda0fb20..52f731a6148210eb 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -239,7 +239,7 @@ int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned
 	u32 value;
 
 	fbdev = to_au1100fb_device(fbi);
-	palette = fbdev->regs->lcd_pallettebase;
+	palette = fbdev->regs->lcd_palettebase;
 
 	if (regno > (AU1100_LCD_NBR_PALETTE_ENTRIES - 1))
 		return -EINVAL;
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
index e7239bceefd3ad34..79f4048726f1af0f 100644
--- a/drivers/video/fbdev/au1100fb.h
+++ b/drivers/video/fbdev/au1100fb.h
@@ -92,7 +92,7 @@ struct au1100fb_regs
 	u32  lcd_pwmdiv;
 	u32  lcd_pwmhi;
 	u32  reserved[(0x0400-0x002C)/4];
-	u32  lcd_pallettebase[256];
+	u32  lcd_palettebase[256];
 };
 
 struct au1100fb_device {
-- 
2.25.1

