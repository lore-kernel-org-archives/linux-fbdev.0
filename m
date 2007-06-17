From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm3fb: mtrr support and noaccel option
Date: Sun, 17 Jun 2007 22:20:27 +0200
Message-ID: <4675978B.8080100@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010302080504070608020506"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I01D4-0008EQ-33 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Jun 2007 13:18:54 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I01D3-0002LW-5y
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Jun 2007 13:18:53 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	17 Jun 2007 22:18:49 +0200
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
--------------010302080504070608020506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds usage of MTRR registers and two new options: noaccel and nomtrr.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

I could not resist making porting mtrr support for pm3fb.

This patch reverts Adrian Bunk removal of pm3fb_setup function.


--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-17 21:50:33.496752796 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-17 21:38:19.618515886 +0200
@@ -32,6 +32,9 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
 
 #include <video/pm3fb.h>
 
@@ -52,6 +55,12 @@
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
@@ -788,6 +798,8 @@ static void pm3fb_write_mode(struct fb_i
 /*
  * hardware independent functions
  */
+int pm3fb_init(void);
+
 static int pm3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	u32 lpitch;
@@ -1243,6 +1255,13 @@ static int __devinit pm3fb_probe(struct 
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
@@ -1256,6 +1275,10 @@ static int __devinit pm3fb_probe(struct 
 			FBINFO_HWACCEL_IMAGEBLIT |
 			FBINFO_HWACCEL_FILLRECT;
 
+	if (noaccel) {
+	    	printk(KERN_DEBUG "disabling acceleration\n");
+  		info->flags |= FBINFO_HWACCEL_DISABLED;
+	}
 	info->pixmap.addr = kmalloc(PM3_PIXMAP_SIZE, GFP_KERNEL);
 	if (!info->pixmap.addr) {
 		retval = -ENOMEM;
@@ -1329,6 +1352,11 @@ static void __devexit pm3fb_remove(struc
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
@@ -1356,22 +1384,72 @@ static struct pci_driver pm3fb_driver = 
 
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

--------------010302080504070608020506
Content-Type: text/plain;
 name="pm3fb-mtrr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm3fb-mtrr.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds usage of MTRR registers and two new options: noaccel and nomtrr.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-17 21:50:33.496752796 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-17 21:38:19.618515886 +0200
@@ -32,6 +32,9 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
 
 #include <video/pm3fb.h>
 
@@ -52,6 +55,12 @@
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
@@ -788,6 +798,8 @@ static void pm3fb_write_mode(struct fb_i
 /*
  * hardware independent functions
  */
+int pm3fb_init(void);
+
 static int pm3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	u32 lpitch;
@@ -1243,6 +1255,13 @@ static int __devinit pm3fb_probe(struct 
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
@@ -1256,6 +1275,10 @@ static int __devinit pm3fb_probe(struct 
 			FBINFO_HWACCEL_IMAGEBLIT |
 			FBINFO_HWACCEL_FILLRECT;
 
+	if (noaccel) {
+	    	printk(KERN_DEBUG "disabling acceleration\n");
+  		info->flags |= FBINFO_HWACCEL_DISABLED;
+	}
 	info->pixmap.addr = kmalloc(PM3_PIXMAP_SIZE, GFP_KERNEL);
 	if (!info->pixmap.addr) {
 		retval = -ENOMEM;
@@ -1329,6 +1352,11 @@ static void __devexit pm3fb_remove(struc
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
@@ -1356,22 +1384,72 @@ static struct pci_driver pm3fb_driver = 
 
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

--------------010302080504070608020506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------010302080504070608020506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------010302080504070608020506--
