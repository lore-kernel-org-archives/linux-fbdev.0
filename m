From: Giuseppe Coviello <cjg@cruxppc.org>
Subject: [PATCH] GXT400P and GXT6500P support
Date: Wed, 27 May 2009 20:57:55 +0200
Message-ID: <a265241c0905271157s45e23528haefbd2fa31ba6763@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gicoviello@gmail.com>) id 1M9OL8-0005cn-LT
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 18:59:02 +0000
Received: from mail-bw0-f222.google.com ([209.85.218.222])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M9OK5-00010B-Ae for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 18:58:57 +0000
Received: by bwz22 with SMTP id 22so4801378bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 May 2009 11:57:55 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

This patch adds support for GXT4000P and GXT6500P cards found on some
IBM pSeries machines.
GXT4000P/6000P and GXT4500P/6500P  couples are  identical from
software's point of view and are based on the same  Raster Engine
(RC1000), except for a different reference clock for the PLL.
GXT6x00P models are equipped with an additional Geometry Engine
(GT1000) but this driver doesn't use it.

Regards, Giuseppe


Signed-off-by: Nico Macrionitis <acrux@cruxppc.org>
Signed-off-by: Giuseppe Coviello <cjg@cruxppc.org>

--- /usr/src/linux-2.6.30-rc3/drivers/video/Kconfig	2009-04-22
05:07:00.000000000 +0200
+++ Kconfig	2009-05-05 10:55:17.000000000 +0200
@@ -1985,8 +1985,10 @@
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	---help---
-	  Say Y here to enable support for the IBM GXT4500P display
-	  adaptor, found on some IBM System P (pSeries) machines.
+	  Say Y here to enable support for the IBM GXT4000P/6000P and	
+	  GXT4500P/6500P display adaptor based on Raster Engine RC1000,
+	  found on some IBM System P (pSeries) machines. This driver
+	  doesn't use Geometry Engine GT1000.

 config FB_PS3
 	tristate "PS3 GPU framebuffer driver"
--- /usr/src/linux-2.6.30-rc3/drivers/video/gxt4500.c	2009-04-22
05:07:00.000000000 +0200
+++ gxt4500c	2009-05-05 10:47:41.000000000 +0200
@@ -1,6 +1,7 @@
 /*
- * Frame buffer device for IBM GXT4500P and GXT6000P display adaptors
- *
+ * Frame buffer device for IBM GXT4500P/6500P and GXT4000P/6000P
+ * display adaptors
+ *
  * Copyright (C) 2006 Paul Mackerras, IBM Corp. <paulus@samba.org>
  */

@@ -14,6 +15,8 @@
 #include <linux/string.h>

 #define PCI_DEVICE_ID_IBM_GXT4500P	0x21c
+#define PCI_DEVICE_ID_IBM_GXT6500P      0x21b
+#define PCI_DEVICE_ID_IBM_GXT4000P      0x16e
 #define PCI_DEVICE_ID_IBM_GXT6000P	0x170

 /* GXT4500P registers */
@@ -173,6 +176,8 @@
 /* List of supported cards */
 enum gxt_cards {
 	GXT4500P,
+	GXT6500P,
+	GXT4000P,
 	GXT6000P
 };

@@ -182,6 +187,8 @@
 	const char *cardname;
 } cardinfo[] = {
 	[GXT4500P] = { .refclk_ps = 9259, .cardname = "IBM GXT4500P" },
+        [GXT6500P] = { .refclk_ps = 9259, .cardname = "IBM GXT6500P" },
+        [GXT4000P] = { .refclk_ps = 40000, .cardname = "IBM GXT4000P" },
 	[GXT6000P] = { .refclk_ps = 40000, .cardname = "IBM GXT6000P" },
 };

@@ -736,6 +743,10 @@
 static const struct pci_device_id gxt4500_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4500P),
 	  .driver_data = GXT4500P },
+        { PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6500P),
+          .driver_data = GXT6500P },
+        { PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4000P),
+          .driver_data = GXT4000P },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6000P),
 	  .driver_data = GXT6000P },
 	{ 0 }
@@ -768,7 +779,7 @@
 module_exit(gxt4500_exit);

 MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
-MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6000P");
+MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6500P and GXT4000P/6000P");
 MODULE_LICENSE("GPL");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as
\"<xres>x<yres>[-<bpp>][@<refresh>]\"");

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
