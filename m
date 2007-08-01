From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 09/11] tdfxfb: mtrr support
Date: Wed, 01 Aug 2007 15:50:01 +0800
Message-ID: <46B03B29.6000708@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IG9OB-0003Il-PP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:17:03 -0700
Received: from rv-out-0910.google.com ([209.85.198.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IG9OA-00050C-Tj
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:17:03 -0700
Received: by rv-out-0910.google.com with SMTP id g11so308822rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 01 Aug 2007 01:17:02 -0700 (PDT)
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

This patch adds mtrr support to the tdfxfb driver.
It also kills one redundant include and initialization value.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/tdfxfb.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 include/video/tdfx.h   |    1 +
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index c5ba647..9bf4081 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -67,7 +67,6 @@ #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
-#include <linux/spinlock.h>
 
 #include <video/tdfx.h>
 
@@ -78,6 +77,24 @@ #else
 #define DPRINTK(a,b...)
 #endif
 
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#else
+/* duplicate asm/mtrr.h defines to work on archs without mtrr */
+#define MTRR_TYPE_WRCOMB     1
+
+static __inline__ int mtrr_add (unsigned long base, unsigned long size,
+				unsigned int type, char increment)
+{
+    return -ENODEV;
+}
+static __inline__ int mtrr_del (int reg, unsigned long base,
+				unsigned long size)
+{
+    return -ENODEV;
+}
+#endif
+
 #define BANSHEE_MAX_PIXCLOCK 270000
 #define VOODOO3_MAX_PIXCLOCK 300000
 #define VOODOO5_MAX_PIXCLOCK 350000
@@ -150,7 +167,9 @@ MODULE_DEVICE_TABLE(pci, tdfxfb_id_table
 static int nopan;
 static int nowrap = 1;      /* not implemented (yet) */
 static int hwcursor = 1;
-static char *mode_option __devinitdata = NULL;
+static char *mode_option __devinitdata;
+/* mtrr option */
+static int nomtrr __devinitdata;
 
 /* -------------------------------------------------------------------------
  *                      Hardware-specific funcions
@@ -1227,6 +1246,12 @@ static int __devinit tdfxfb_probe(struct
 
 	printk("fb: %s memory = %dK\n", tdfx_fix.id, tdfx_fix.smem_len >> 10);
 
+	default_par->mtrr_handle = -1;
+	if (!nomtrr)
+		default_par->mtrr_handle =
+			mtrr_add(tdfx_fix.smem_start, tdfx_fix.smem_len,
+				 MTRR_TYPE_WRCOMB, 1);
+
 	tdfx_fix.ypanstep	= nopan ? 0 : 1;
 	tdfx_fix.ywrapstep	= nowrap ? 0 : 1;
 
@@ -1276,6 +1301,9 @@ #endif
 	return 0;
 
 out_err_iobase:
+	if (default_par->mtrr_handle >= 0)
+		mtrr_del(default_par->mtrr_handle, info->fix.smem_start,
+			 info->fix.smem_len);
 	release_mem_region(pci_resource_start(pdev, 2),
 			   pci_resource_len(pdev, 2));
 out_err_screenbase:
@@ -1311,6 +1339,10 @@ static void tdfxfb_setup(char *options)
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
@@ -1333,6 +1365,9 @@ static void __devexit tdfxfb_remove(stru
 	struct tdfx_par *par = info->par;
 
 	unregister_framebuffer(info);
+	if (par->mtrr_handle >= 0)
+		mtrr_del(par->mtrr_handle, info->fix.smem_start,
+			 info->fix.smem_len);
 	iounmap(par->regbase_virt);
 	iounmap(info->screen_base);
 
@@ -1372,6 +1407,10 @@ MODULE_LICENSE("GPL");
 module_param(hwcursor, int, 0644);
 MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
 			"(1=enable, 0=disable, default=1)");
+#ifdef CONFIG_MTRR
+module_param(nomtrr, bool, 0);
+MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");
+#endif
 
 module_init(tdfxfb_init);
 module_exit(tdfxfb_exit);
diff --git a/include/video/tdfx.h b/include/video/tdfx.h
index 8a2bb91..05b63c2 100644
--- a/include/video/tdfx.h
+++ b/include/video/tdfx.h
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
