From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 19/33] pm2fb: mtrr support and noaccel
	option
Date: Thu, 26 Jul 2007 20:24:36 +0800
Message-ID: <46A89284.6030005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2ul-00013c-Hr for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:57:59 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2ul-00084u-A1
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:57:59 -0700
Received: by wa-out-1112.google.com with SMTP id k22so614502waf
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

This patch adds usage of MTRR registers and two new options:
noaccel and nomtrr.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |   44 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 10c0cc6..5c6ff96 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -38,6 +38,9 @@ #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
 
 #include <video/permedia2.h>
 #include <video/cvisionppc.h>
@@ -71,8 +74,13 @@ static char *mode __devinitdata = NULL;
  * these flags allow the user to specify that requests for +ve sync
  * should be silently turned in -ve sync.
  */
-static int lowhsync;
-static int lowvsync;
+static int lowhsync __devinitdata;
+static int lowvsync __devinitdata;
+static int noaccel __devinitdata;
+/* mtrr option */
+#ifdef CONFIG_MTRR
+static int nomtrr __devinitdata;
+#endif
 
 /*
  * The hardware state of the graphics card that isn't part of the
@@ -88,6 +96,7 @@ struct pm2fb_par
 	u32		mem_control;	/* MemControl reg at probe */
 	u32		boot_address;	/* BootAddress reg at probe */
 	u32		palette[16];
+	int		mtrr_handle;
 };
 
 /*
@@ -1316,6 +1325,15 @@ #endif
 		goto err_exit_mmio;
 	}
 
+#ifdef CONFIG_MTRR
+	default_par->mtrr_handle = -1;
+	if (!nomtrr)
+		default_par->mtrr_handle =
+			mtrr_add(pm2fb_fix.smem_start,
+				 pm2fb_fix.smem_len,
+				 MTRR_TYPE_WRCOMB, 1);
+#endif
+
 	info->fbops		= &pm2fb_ops;
 	info->fix		= pm2fb_fix;
 	info->pseudo_palette	= default_par->palette;
@@ -1324,6 +1342,11 @@ #endif
 				  FBINFO_HWACCEL_COPYAREA |
 				  FBINFO_HWACCEL_FILLRECT;
 
+	if (noaccel) {
+	    	printk(KERN_DEBUG "disabling acceleration\n");
+  		info->flags |= FBINFO_HWACCEL_DISABLED;
+	}
+
 	if (!mode)
 		mode = "640x480@60";
 
@@ -1375,6 +1398,11 @@ static void __devexit pm2fb_remove(struc
 
 	unregister_framebuffer(info);
 
+#ifdef CONFIG_MTRR
+	if (par->mtrr_handle >= 0)
+		mtrr_del(par->mtrr_handle, info->fix.smem_start,
+			 info->fix.smem_len);
+#endif /* CONFIG_MTRR */
 	iounmap(info->screen_base);
 	release_mem_region(fix->smem_start, fix->smem_len);
 	iounmap(par->v_regs);
@@ -1430,6 +1458,12 @@ static int __init pm2fb_setup(char *opti
 			lowhsync = 1;
 		} else if(!strcmp(this_opt, "lowvsync")) {
 			lowvsync = 1;
+#ifdef CONFIG_MTRR
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+			nomtrr = 1;
+#endif
+		} else if (!strncmp(this_opt, "noaccel", 7)) {
+			noaccel = 1;
 		} else {
 			mode = this_opt;
 		}
@@ -1474,6 +1508,12 @@ module_param(lowhsync, bool, 0);
 MODULE_PARM_DESC(lowhsync, "Force horizontal sync low regardless of mode");
 module_param(lowvsync, bool, 0);
 MODULE_PARM_DESC(lowvsync, "Force vertical sync low regardless of mode");
+module_param(noaccel, bool, 0);
+MODULE_PARM_DESC(noaccel, "Disable acceleration");
+#ifdef CONFIG_MTRR
+module_param(nomtrr, bool, 0);
+MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");
+#endif
 
 MODULE_AUTHOR("Jim Hague <jim.hague@acm.org>");
 MODULE_DESCRIPTION("Permedia2 framebuffer device driver");


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
