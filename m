From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] cirrusfb: fix color component length for pseudocolor modes
Date: Tue, 31 Mar 2009 00:07:10 +0200
Message-ID: <20090330220710.GB6993@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762056AbZC3WHf@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

cirrusfb incorrectly sets the length of the color fields to 6 bits
for PSEUDOCOLOR modes, even though 8 bits are always used per pixel.
Fix this by setting the length to 8.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index a2aa6dd..2dfe0e7 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -550,7 +550,7 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 
 	case 8:
 		var->red.offset = 0;
-		var->red.length = 6;
+		var->red.length = 8;
 		var->green = var->red;
 		var->blue = var->red;
 		break;
