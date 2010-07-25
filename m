From: Ondrej Zary <linux@rainbow-software.org>
Date: Sun, 25 Jul 2010 19:32:58 +0000
Subject: [PATCH] cyber2000fb: add mode_option parameter
Message-Id: <201007252133.00183.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Add mode_option parameter to specify the default video mode.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.35-rc3-/drivers/video/cyber2000fb.c	2010-07-25 21:28:33.000000000 +0200
+++ linux-2.6.35-rc3/drivers/video/cyber2000fb.c	2010-07-25 20:36:49.000000000 +0200
@@ -94,6 +94,10 @@ static char *default_font = "Acorn8x8";
 module_param(default_font, charp, 0);
 MODULE_PARM_DESC(default_font, "Default font name");
 
+static char *mode_option __devinitdata = "640x480-8@60";
+module_param(mode_option, charp, 0444);
+MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
+
 /*
  * Our access methods.
  */
@@ -1368,7 +1372,7 @@ static int __devinit cyberpro_common_pro
 	cfb->fb.screen_base    = cfb->region;
 
 	err = -EINVAL;
-	if (!fb_find_mode(&cfb->fb.var, &cfb->fb, NULL, NULL, 0,
+	if (!fb_find_mode(&cfb->fb.var, &cfb->fb, mode_option, NULL, 0,
 			  &cyber2000fb_default_mode, 8)) {
 		printk(KERN_ERR "%s: no valid mode found\n", cfb->fb.fix.id);
 		goto failed;

-- 
Ondrej Zary
