From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] aty128fb accel capabilities
Date: Wed, 2 Jun 2004 22:42:31 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040603024231.GD20951@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BViBl-0002cR-4S
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Jun 2004 19:42:41 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BViBk-0007n8-Tg
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Jun 2004 19:42:40 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brad Douglas <brad@neruo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


Dear Brad,

The following patch updates aty128fb for the new fb accel capabilities
patch I'm sending upstream.  Please test the core patch + this patch,
and let me know it works for you.

-dte

aty128fb: (Rage 128) update to new fbinfo.flags accel capabilities
  
Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	Wed Jun  2 22:45:51 2004
+++ b/drivers/video/aty/aty128fb.c	Wed Jun  2 22:45:51 2004
@@ -342,6 +342,7 @@
 };
 
 static char *mode_option __initdata = NULL;
+static int noaccel = 0;
 
 #ifdef CONFIG_PPC_PMAC
 static int default_vmode __initdata = VMODE_1024_768_60;
@@ -395,7 +396,6 @@
 	struct aty128_crtc crtc;
 	struct aty128_pll pll;
 	struct aty128_ddafifo fifo_reg;
-	u32 accel_flags;
 	struct aty128_constants constants;  /* PLL and others      */
 	void *regbase;                      /* remapped mmio       */
 	u32 vram_size;                      /* onboard video ram   */
@@ -1487,6 +1487,13 @@
 	if ((err = aty128_decode_var(&info->var, par)) != 0)
 		return err;
 
+#ifdef STUPID_ACCELF_TEXT_SHIT
+	if (info->var.accel_flags == FB_ACCELF_TEXT)
+		info->flags &= ~FBINFO_HWACCEL_DISABLED;
+	else
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+#endif
+
 	if (par->blitter_may_be_busy)
 		wait_for_idle(par);
 
@@ -1532,7 +1539,7 @@
 		aty128_set_lcd_enable(par, par->lcd_on);
 	}
 #endif
-	if (par->accel_flags & FB_ACCELF_TEXT)
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED))
 		aty128_init_engine(par);
 
 #ifdef CONFIG_BOOTX_TEXT
@@ -1569,7 +1576,6 @@
 	par->crtc = crtc;
 	par->pll = pll;
 	par->fifo_reg = fifo_reg;
-	par->accel_flags = var->accel_flags;
 
 	return 0;
 }
@@ -1591,7 +1597,6 @@
 
 	var->height = -1;
 	var->width = -1;
-	var->accel_flags = par->accel_flags;
 
 	return 0;
 }           
@@ -1686,8 +1691,11 @@
 		return 0;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!strncmp(this_opt, "noaccel", 7)) {
+			noaccel = 1;
+		}
 #ifdef CONFIG_PMAC_PBOOK
-		if (!strncmp(this_opt, "lcd:", 4)) {
+		else if (!strncmp(this_opt, "lcd:", 4)) {
 			default_lcd_on = simple_strtoul(this_opt+4, NULL, 0);
 			continue;
 		} else if (!strncmp(this_opt, "crt:", 4)) {
@@ -1771,7 +1779,9 @@
 
 	/* fill in info */
 	info->fbops = &aty128fb_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT
+		    | FBINFO_HWACCEL_XPAN
+		    | FBINFO_HWACCEL_YPAN;
 
 #ifdef CONFIG_PMAC_PBOOK
 	par->lcd_on = default_lcd_on;
@@ -1830,8 +1840,9 @@
 				var = default_var;
 	}
 
-	var.accel_flags &= ~FB_ACCELF_TEXT;
-//	var.accel_flags |= FB_ACCELF_TEXT;/* FIXME Will add accel later */
+#ifdef STUPID_ACCELF_TEXT_SHIT
+	var.accel_flags = noaccel ? 0 : FB_ACCELF_TEXT;
+#endif
 
 	if (aty128fb_check_var(&var, info)) {
 		printk(KERN_ERR "aty128fb: Cannot set default mode.\n");
@@ -2454,6 +2465,8 @@
 MODULE_AUTHOR("(c)1999-2003 Brad Douglas <brad@neruo.com>");
 MODULE_DESCRIPTION("FBDev driver for ATI Rage128 / Pro cards");
 MODULE_LICENSE("GPL");
+module_param(noaccel, bool, 0);
+MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 #ifdef CONFIG_MTRR


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
