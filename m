From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] vga16fb: fix color component length for pseudocolor modes
Date: Thu, 2 Apr 2009 14:26:13 +0200
Message-ID: <20090402122613.GA16899@tria>
References: <20090330220523.GA6993@spock.one.pl> <20090401185856.44d89699.krzysztof.h1@poczta.fm>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758457AbZDBM0o@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090401185856.44d89699.krzysztof.h1@poczta.fm>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

vga16fb incorrectly sets the length of the color fields to 6 or 2 bits
for PSEUDOCOLOR modes, for which either 8 or 4 bits are used per pixel.
Fix this by setting the length to 8 or 4, respectively.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 5b29389..8f1eb7f 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -506,7 +506,7 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
 	var->red.offset = var->green.offset = var->blue.offset = 
 	var->transp.offset = 0;
 	var->red.length = var->green.length = var->blue.length =
-		(par->isVGA) ? 6 : 2;
+		(par->isVGA) ? 8 : 4;
 	var->transp.length = 0;
 	var->activate = FB_ACTIVATE_NOW;
 	var->height = -1;
@@ -1324,7 +1324,7 @@ static int __init vga16fb_probe(struct platform_device *dev)
 	par->palette_blanked = 0;
 	par->vesa_blanked = 0;
 
-	i = par->isVGA? 6 : 2;
+	i = par->isVGA? 8 : 4;
 	
 	vga16fb_defined.red.length   = i;
 	vga16fb_defined.green.length = i;
