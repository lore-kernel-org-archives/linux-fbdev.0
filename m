From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] cyblafb: fix color component length for pseudocolor modes
Date: Tue, 31 Mar 2009 00:08:48 +0200
Message-ID: <20090330220848.GC6993@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762214AbZC3WJ1@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Knut_Petersen@t-online.de

cyblafb incorrectly sets the length of the color fields to 6 bits
for PSEUDOCOLOR modes, even though 8 bits are always used per pixel.
Fix this by setting the length to 8.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Cc: Knut Petersen <Knut_Petersen@t-online.de>
---
diff --git a/drivers/video/cyblafb.c b/drivers/video/cyblafb.c
index 9704b73..8e3a264 100644
--- a/drivers/video/cyblafb.c
+++ b/drivers/video/cyblafb.c
@@ -615,9 +615,9 @@ static int cyblafb_check_var(struct fb_var_screeninfo *var,
 		var->red.offset = 0;
 		var->green.offset = 0;
 		var->blue.offset = 0;
-		var->red.length = 6;
-		var->green.length = 6;
-		var->blue.length = 6;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
 		break;
 	case 16:
 		var->red.offset = 11;
