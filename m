Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EC9C43217
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Feb 2022 11:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiBOLVt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:21:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiBOLVr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Feb 2022 06:21:47 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD42AB460
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Feb 2022 03:21:36 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8c73:faf1:1d11:4a47])
        by michel.telenet-ops.be with bizsmtp
        id vPMZ260013BmCM306PMZ0v; Tue, 15 Feb 2022 12:21:33 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nJvtk-000rqe-KZ; Tue, 15 Feb 2022 12:21:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nJvtk-00B34u-5o; Tue, 15 Feb 2022 12:21:32 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] video: fbdev: atari: Convert to standard round_up() helper
Date:   Tue, 15 Feb 2022 12:21:25 +0100
Message-Id: <20220215112126.2633383-3-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215112126.2633383-1-geert@linux-m68k.org>
References: <20220215112126.2633383-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove the custom macro up(), and convert the code to use the standard
round_up() helper instead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index a9f25cab4a1e6737..b9d6aaaeae43f2f1 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -76,8 +76,6 @@
 #define SWITCH_SND7 0x80
 #define SWITCH_NONE 0x00
 
-#define up(x, r) (((x) + (r) - 1) & ~((r)-1))
-
 
 static int default_par;		/* default resolution (0=none) */
 
@@ -1649,12 +1647,12 @@ static int falcon_pan_display(struct fb_var_screeninfo *var,
 	int bpp = info->var.bits_per_pixel;
 
 	if (bpp == 1)
-		var->xoffset = up(var->xoffset, 32);
+		var->xoffset = round_up(var->xoffset, 32);
 	if (bpp != 16)
 		par->hw.falcon.xoffset = var->xoffset & 15;
 	else {
 		par->hw.falcon.xoffset = 0;
-		var->xoffset = up(var->xoffset, 2);
+		var->xoffset = round_up(var->xoffset, 2);
 	}
 	par->hw.falcon.line_offset = bpp *
 		(info->var.xres_virtual - info->var.xres) / 16;
@@ -2268,7 +2266,7 @@ static int pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 	if (!fbhw->set_screen_base ||
 	    (!ATARIHW_PRESENT(EXTD_SHIFTER) && var->xoffset))
 		return -EINVAL;
-	var->xoffset = up(var->xoffset, 16);
+	var->xoffset = round_up(var->xoffset, 16);
 	par->screen_base = screen_base +
 	        (var->yoffset * info->var.xres_virtual + var->xoffset)
 	        * info->var.bits_per_pixel / 8;
-- 
2.25.1

