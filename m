From: James Simmons <jsimmons@infradead.org>
Subject: Patch for review and testing
Date: Tue, 27 Jan 2004 20:07:07 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401272006120.19265-100000@phoenix.infradead.org>
References: <1075188083.6191.181.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlZUQ-0002Sb-69
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 12:07:14 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AlZUP-0007Xn-BC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 12:07:13 -0800
In-Reply-To: <1075188083.6191.181.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


I like to submit this patch to linus today. Could you test it to see if it 
works on ppcs. 

diff -urN -X /home/jsimmons/dontdiff linus-2.6/arch/i386/boot/video.S fbdev-2.6/arch/i386/boot/video.S
--- linus-2.6/arch/i386/boot/video.S	2004-01-27 14:11:30.000000000 -0800
+++ fbdev-2.6/arch/i386/boot/video.S	2004-01-27 13:28:20.000000000 -0800
@@ -1889,6 +1889,7 @@
 	ret
 
 store_edid:
+#ifdef CONFIG_EDID_FIRMWARE
 	pushw	%es				# just save all registers 
 	pushw	%ax				
 	pushw	%bx
@@ -1919,6 +1920,7 @@
 	popw	%bx
 	popw	%ax
 	popw	%es	
+#endif         /* CONFIG_EDID_FIRMWARE */
 	ret
 
 # VIDEO_SELECT-only variables
diff -urN -X /home/jsimmons/dontdiff linus-2.6/arch/i386/kernel/setup.c fbdev-2.6/arch/i386/kernel/setup.c
--- linus-2.6/arch/i386/kernel/setup.c	2004-01-27 14:11:32.000000000 -0800
+++ fbdev-2.6/arch/i386/kernel/setup.c	2004-01-27 13:46:34.000000000 -0800
@@ -105,7 +105,9 @@
 	unsigned short length;
 	unsigned char table[0];
 };
+#ifdef CONFIG_EDID_FIRMWARE
 struct edid_info edid_info;
+#endif /* CONFIG_EDID_FIRMWARE */
 struct ist_info ist_info;
 struct e820map e820;
 
@@ -1060,7 +1062,9 @@
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
+#ifdef CONFIG_EDID_FIRMWARE
 	edid_info = EDID_INFO;
+#endif /* CONFIG_EDID_FIRMWARE */
 	apm_info.bios = APM_BIOS_INFO;
 	ist_info = IST_INFO;
 	saved_videomode = VIDEO_MODE;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/Kconfig fbdev-2.6/drivers/video/Kconfig
--- linus-2.6/drivers/video/Kconfig	2004-01-27 14:17:11.000000000 -0800
+++ fbdev-2.6/drivers/video/Kconfig	2004-01-27 11:46:36.000000000 -0800
@@ -38,6 +38,18 @@
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
 
+config EDID_FIRMWARE
+	bool "Get EDID using the platform's firmware"
+	depends on X86
+	default n
+	help
+	  If you choose Y, the EDID (useful for setting video modes) will be
+	  acquired using a BIOS call before the kernel boots to protected mode.
+	  For computers with broken BIOSes, this can hang your computer. This can
+	  also be a very slow process.
+
+	  If unsure, choose N.
+
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (AMIGA || PCI) && BROKEN
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmon.c fbdev-2.6/drivers/video/fbmon.c
--- linus-2.6/drivers/video/fbmon.c	2004-01-27 14:17:12.000000000 -0800
+++ fbdev-2.6/drivers/video/fbmon.c	2004-01-27 11:55:32.000000000 -0800
@@ -828,42 +828,42 @@
 	printk("========================================\n");
 }
 
-#ifdef CONFIG_PPC_OF
-char *get_EDID_from_OF(struct pci_dev *pdev)
+#ifdef CONFIG_EDID_FIRMWARE
+char *get_EDID_from_Firmware(struct device *dev)
 {
+#ifdef CONFIG_PPC_OF
 	static char *propnames[] =
 	    { "DFP,EDID", "LCD,EDID", "EDID", "EDID1", NULL };
 	unsigned char *pedid = NULL;
 	struct device_node *dp;
+	struct pci_dev *pdev;
 	int i;
 
+	pdev = to_pci_dev(dev);
+	
 	if (pdev == NULL)
 		return NULL;
 	dp = pci_device_to_OF_node(pdev);
-	while (dp != NULL) {
+	while (dp) {
 		for (i = 0; propnames[i] != NULL; ++i) {
 			pedid = (unsigned char *) get_property(dp, propnames[i], NULL);
-			if (pedid != NULL)
+			if (pedid)
 				return pedid;
 		}
 		dp = dp->child;
 	}
-	show_edid(pedid);
-	return pedid;
-}
 #endif
-
 #ifdef CONFIG_X86
-char *get_EDID_from_BIOS(void *dummy)
-{
-	unsigned char *pedid = edid_info.dummy;
-	
+	unsigned char *pedid = NULL;
+
+	pedid = edid_info.dummy;
 	if (!pedid)
 		return NULL;
+#endif	
 	show_edid(pedid);
-	return pedid;				
+	return pedid;
 }
-#endif
+#endif /* CONFIG_EDID_FIRMWARE */
 
 /* 
  * VESA Generalized Timing Formula (GTF) 
@@ -1229,11 +1229,8 @@
 
 EXPORT_SYMBOL(parse_edid);
 EXPORT_SYMBOL(show_edid);
-#ifdef CONFIG_X86
-EXPORT_SYMBOL(get_EDID_from_BIOS);
-#endif
-#ifdef CONFIG_PPC_OF
-EXPORT_SYMBOL(get_EDID_from_OF);
+#ifdef CONFIG_EDID_FIRMWARE
+EXPORT_SYMBOL(get_EDID_from_Firmware);
 #endif
 EXPORT_SYMBOL(fb_get_monitor_limits);
 EXPORT_SYMBOL(fb_get_mode);



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
