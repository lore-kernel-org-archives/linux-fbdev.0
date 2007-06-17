From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: mtrr support and noaccel option
Date: Sun, 17 Jun 2007 22:21:17 +0200
Message-ID: <467597BD.4080109@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030100090708000108010600"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I01Dr-0008KZ-KB for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Jun 2007 13:19:43 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I01Dq-0006Jp-Pc
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Jun 2007 13:19:43 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	17 Jun 2007 22:19:39 +0200
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030100090708000108010600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds usage of MTRR registers and two new options: noaccel and nomtrr.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.21.old/drivers/video/pm2fb.c	2007-06-06 18:44:49.000000000 +0200
+++ linux-2.6.21/drivers/video/pm2fb.c	2007-06-17 21:54:16.009433094 +0200
@@ -38,6 +38,9 @@
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
 	u32             palette[16];
+	int		mtrr_handle;
 };
 
 /*
@@ -1316,6 +1325,14 @@ static int __devinit pm2fb_probe(struct 
 		goto err_exit_mmio;
 	}
 
+#ifdef CONFIG_MTRR
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
@@ -1324,6 +1341,11 @@ static int __devinit pm2fb_probe(struct 
 	                          FBINFO_HWACCEL_COPYAREA |
 	                          FBINFO_HWACCEL_FILLRECT;
 
+	if (noaccel) {
+	    	printk(KERN_DEBUG "disabling acceleration\n");
+  		info->flags |= FBINFO_HWACCEL_DISABLED;
+	}
+
 	if (!mode)
 		mode = "640x480@60";
 	 
@@ -1375,6 +1397,11 @@ static void __devexit pm2fb_remove(struc
 
 	unregister_framebuffer(info);
     
+#ifdef CONFIG_MTRR
+	if (par->mtrr_handle >= 0)
+		mtrr_del(par->mtrr_handle, info->fix.smem_start,
+			 info->fix.smem_len);
+#endif /* CONFIG_MTRR */
 	iounmap(info->screen_base);
 	release_mem_region(fix->smem_start, fix->smem_len);
 	iounmap(par->v_regs);
@@ -1430,6 +1457,12 @@ static int __init pm2fb_setup(char *opti
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
@@ -1474,6 +1507,12 @@ module_param(lowhsync, bool, 0);
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

--------------030100090708000108010600
Content-Type: text/plain;
 name="pm2fb-mtrr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm2fb-mtrr.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds usage of MTRR registers and two new options: noaccel and nomtrr.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.21.old/drivers/video/pm2fb.c	2007-06-06 18:44:49.000000000 +0200
+++ linux-2.6.21/drivers/video/pm2fb.c	2007-06-17 21:54:16.009433094 +0200
@@ -38,6 +38,9 @@
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
 	u32             palette[16];
+	int		mtrr_handle;
 };
 
 /*
@@ -1316,6 +1325,14 @@ static int __devinit pm2fb_probe(struct 
 		goto err_exit_mmio;
 	}
 
+#ifdef CONFIG_MTRR
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
@@ -1324,6 +1341,11 @@ static int __devinit pm2fb_probe(struct 
 	                          FBINFO_HWACCEL_COPYAREA |
 	                          FBINFO_HWACCEL_FILLRECT;
 
+	if (noaccel) {
+	    	printk(KERN_DEBUG "disabling acceleration\n");
+  		info->flags |= FBINFO_HWACCEL_DISABLED;
+	}
+
 	if (!mode)
 		mode = "640x480@60";
 	 
@@ -1375,6 +1397,11 @@ static void __devexit pm2fb_remove(struc
 
 	unregister_framebuffer(info);
     
+#ifdef CONFIG_MTRR
+	if (par->mtrr_handle >= 0)
+		mtrr_del(par->mtrr_handle, info->fix.smem_start,
+			 info->fix.smem_len);
+#endif /* CONFIG_MTRR */
 	iounmap(info->screen_base);
 	release_mem_region(fix->smem_start, fix->smem_len);
 	iounmap(par->v_regs);
@@ -1430,6 +1457,12 @@ static int __init pm2fb_setup(char *opti
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
@@ -1474,6 +1507,12 @@ module_param(lowhsync, bool, 0);
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

--------------030100090708000108010600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------030100090708000108010600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------030100090708000108010600--
