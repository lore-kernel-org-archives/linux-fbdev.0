From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] tdfxfb: mtrr support
Date: Sun, 29 Jul 2007 23:06:53 +0200
Message-ID: <20070729230653.d5dd086b.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IFFvF-0007uI-K8 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Jul 2007 14:03:31 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IFFvD-0004Oj-Oz
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Jul 2007 14:03:29 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	29 Jul 2007 23:03:21 +0200
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds mtrr support to the tdfxfb driver.

It also kills one redundant include and initialization value.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires all previous tdfxfb patches sent to this list.

--- linux-2.6.22.old/drivers/video/tdfxfb.c	2007-07-28 23:37:00.000000000 +0200
+++ linux-2.6.22/drivers/video/tdfxfb.c	2007-07-28 23:35:49.000000000 +0200
@@ -67,7 +67,9 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
-#include <linux/spinlock.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
 
 #include <video/tdfx.h>
 
@@ -150,7 +152,11 @@ MODULE_DEVICE_TABLE(pci, tdfxfb_id_table
 static int nopan;
 static int nowrap = 1;      /* not implemented (yet) */
 static int hwcursor = 1;
-static char *mode_option __devinitdata = NULL;
+static char *mode_option __devinitdata;
+/* mtrr option */
+#ifdef CONFIG_MTRR
+static int nomtrr __devinitdata;
+#endif
 
 /* -------------------------------------------------------------------------
  *                      Hardware-specific funcions
@@ -1227,6 +1233,14 @@ static int __devinit tdfxfb_probe(struct
 
 	printk("fb: %s memory = %dK\n", tdfx_fix.id, tdfx_fix.smem_len >> 10);
 
+#ifdef CONFIG_MTRR
+	default_par->mtrr_handle = -1;
+	if (!nomtrr)
+		default_par->mtrr_handle =
+			mtrr_add(tdfx_fix.smem_start, tdfx_fix.smem_len,
+				 MTRR_TYPE_WRCOMB, 1);
+#endif
+
 	tdfx_fix.ypanstep	= nopan ? 0 : 1;
 	tdfx_fix.ywrapstep	= nowrap ? 0 : 1;
 
@@ -1276,6 +1290,11 @@ static int __devinit tdfxfb_probe(struct
 	return 0;
 
 out_err_iobase:
+#ifdef CONFIG_MTRR
+	if (default_par->mtrr_handle >= 0)
+		mtrr_del(default_par->mtrr_handle, info->fix.smem_start,
+			 info->fix.smem_len);
+#endif
 	release_mem_region(pci_resource_start(pdev, 2),
 			   pci_resource_len(pdev, 2));
 out_err_screenbase:
@@ -1311,6 +1330,10 @@ static void tdfxfb_setup(char *options)
 			nowrap = 1;
 		} else if (!strcmp(this_opt, "hwcursor")) {
 			hwcursor = simple_strtoul(opt + 9, NULL, 0);
+#ifdef CONFIG_MTRR
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+			nomtrr = 1;
+#endif
 		} else {
 			mode_option = this_opt;
 		}
@@ -1333,6 +1356,11 @@ static void __devexit tdfxfb_remove(stru
 	struct tdfx_par *par = info->par;
 
 	unregister_framebuffer(info);
+#ifdef CONFIG_MTRR
+	if (par->mtrr_handle >= 0)
+		mtrr_del(par->mtrr_handle, info->fix.smem_start,
+			 info->fix.smem_len);
+#endif
 	iounmap(par->regbase_virt);
 	iounmap(info->screen_base);
 
@@ -1372,6 +1400,10 @@ MODULE_LICENSE("GPL");
 module_param(hwcursor, int, 0644);
 MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
 			"(1=enable, 0=disable, default=1)");
+#ifdef CONFIG_MTRR
+module_param(nomtrr, bool, 0);
+MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");
+#endif
 
 module_init(tdfxfb_init);
 module_exit(tdfxfb_exit);
--- linux-2.6.22.old/include/video/tdfx.h	2007-07-28 23:37:00.000000000 +0200
+++ linux-2.6.22/include/video/tdfx.h	2007-07-28 23:13:19.000000000 +0200
@@ -175,6 +175,7 @@ struct tdfx_par {
 	u32 palette[16];
 	void __iomem *regbase_virt;
 	unsigned long iobase;
+	int mtrr_handle;
 };
 
 #endif	/* __KERNEL__ */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
