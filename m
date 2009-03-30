From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] sisfb: fix color component length for pseudocolor modes
Date: Tue, 31 Mar 2009 00:13:40 +0200
Message-ID: <20090330221340.GF6993@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762586AbZC3WOX@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: thomas@winischhofer.net, linux-fbdev-devel@lists.sourceforge.net

sisfb incorrectly sets the length of the color fields to 6 bits
for PSEUDOCOLOR modes, even though 8 bits are always used per pixel.
Fix this by setting the length to 8.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 346d645..7e17ee9 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -1129,7 +1129,7 @@ sisfb_bpp_to_var(struct sis_video_info *ivideo, struct fb_var_screeninfo *var)
 	switch(var->bits_per_pixel) {
 	case 8:
 		var->red.offset = var->green.offset = var->blue.offset = 0;
-		var->red.length = var->green.length = var->blue.length = 6;
+		var->red.length = var->green.length = var->blue.length = 8;
 		break;
 	case 16:
 		var->red.offset = 11;
