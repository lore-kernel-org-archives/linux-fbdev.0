From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 18/33] pm3fb: mtrr support and noaccel
	option
Date: Thu, 26 Jul 2007 20:23:55 +0800
Message-ID: <46A8925B.8090801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2un-00013x-EP for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:58:01 -0700
Received: from nz-out-0506.google.com ([64.233.162.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2um-0008TI-21
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:58:01 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1352216nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:57:59 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds usage of MTRR registers and two new options: noaccel and
nomtrr.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm3fb.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 88af072..3f004e8 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -32,6 +32,9 @@ #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
 
 #include <video/pm3fb.h>
 
@@ -52,6 +55,12 @@ #define PM3_PIXMAP_SIZE	(2048 * 4)
  * Driver data
  */
 static char *mode_option __devinitdata;
+static int noaccel   __devinitdata = 0;
+
+/* mtrr option */
+#ifdef CONFIG_MTRR
+static int nomtrr __devinitdata = 0;
+#endif
 
 /*
  * This structure defines the hardware state of the graphics card. Normally
@@ -65,6 +74,7 @@ struct pm3_par {
 	u32		video;		/* video flags before blanking */
 	u32		base;		/* screen base (xoffset+yoffset) in 128 bits unit */
 	u32		palette[16];
+	int		mtrr_handle;
 };
 
 /*
@@ -788,6 +798,8 @@ #endif /* ! __BIG_ENDIAN */
 /*
  * hardware independent functions
  */
+int pm3fb_init(void);
+
 static int pm3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	u32 lpitch;
@@ -1244,6 +1256,13 @@ #endif
 	}
 	info->screen_size = pm3fb_fix.smem_len;
 
+#ifdef CONFIG_MTRR
+	if (!nomtrr) {
+		par->mtrr_handle = mtrr_add(pm3fb_fix.smem_start,
+						pm3fb_fix.smem_len,
+						MTRR_TYPE_WRCOMB, 1);
+	}
+#endif
 	info->fbops = &pm3fb_ops;
 
 	par->video = PM3_READ_REG(par, PM3VideoControl);
@@ -1257,6 +1276,10 @@ #endif
 			FBINFO_HWACCEL_IMAGEBLIT |
 			FBINFO_HWACCEL_FILLRECT;
 
+	if (noaccel) {
+	    	printk(KERN_DEBUG "disabling acceleration\n");
+  		info->flags |= FBINFO_HWACCEL_DISABLED;
+	}
 	info->pixmap.addr = kmalloc(PM3_PIXMAP_SIZE, GFP_KERNEL);
 	if (!info->pixmap.addr) {
 		retval = -ENOMEM;
@@ -1330,6 +1353,11 @@ static void __devexit pm3fb_remove(struc
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
 
+#ifdef CONFIG_MTRR
+	if (par->mtrr_handle >= 0)
+		mtrr_del(par->mtrr_handle, info->fix.smem_start,
+			 info->fix.smem_len);
+#endif /* CONFIG_MTRR */
 		iounmap(info->screen_base);
 		release_mem_region(fix->smem_start, fix->smem_len);
 		iounmap(par->v_regs);
@@ -1357,22 +1385,72 @@ static struct pci_driver pm3fb_driver = 
 
 MODULE_DEVICE_TABLE(pci, pm3fb_id_table);
 
-static int __init pm3fb_init(void)
+#ifndef MODULE
+	/*
+	 *  Setup
+	 */
+
+/*
+ * Only necessary if your driver takes special options,
+ * otherwise we fall back on the generic fb_setup().
+ */
+static int __init pm3fb_setup(char *options)
+{
+	char *this_opt;
+
+	/* Parse user speficied options (`video=pm3fb:') */
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
+		else if (!strncmp(this_opt, "noaccel", 7)) {
+			noaccel = 1;
+#ifdef CONFIG_MTRR
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+			nomtrr = 1;
+#endif
+		} else {
+			mode_option = this_opt;
+		}
+	}
+	return 0;
+}
+#endif /* MODULE */
+
+int __init pm3fb_init(void)
 {
+	/*
+	 *  For kernel boot options (in 'video=pm3fb:<options>' format)
+	 */
 #ifndef MODULE
-	if (fb_get_options("pm3fb", NULL))
+	char *option = NULL;
+
+	if (fb_get_options("pm3fb", &option))
 		return -ENODEV;
+	pm3fb_setup(option);
 #endif
+
 	return pci_register_driver(&pm3fb_driver);
 }
 
+#ifdef MODULE
 static void __exit pm3fb_exit(void)
 {
 	pci_unregister_driver(&pm3fb_driver);
 }
 
-module_init(pm3fb_init);
 module_exit(pm3fb_exit);
+#endif
+module_init(pm3fb_init);
+
+module_param(noaccel, bool, 0);
+MODULE_PARM_DESC(noaccel, "Disable acceleration");
+#ifdef CONFIG_MTRR
+module_param(nomtrr, bool, 0);
+MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");
+#endif
 
 MODULE_DESCRIPTION("Permedia3 framebuffer device driver");
 MODULE_LICENSE("GPL");


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
