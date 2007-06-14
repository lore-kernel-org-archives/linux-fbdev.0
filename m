From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm3fb: 3 small fixes
Date: Thu, 14 Jun 2007 06:42:20 +0200
Message-ID: <4670C72C.5020108@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010005090206040805000204"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hyh8q-0005IW-DX for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Jun 2007 21:41:04 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hyh8p-0006Va-Uq
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Jun 2007 21:41:04 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	14 Jun 2007 06:40:59 +0200
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
--------------010005090206040805000204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch contains 3 small improvements:
- it corrects scan line width calculation in pm3fb_imageblit()
- it corrects mmio mapping for big endian machines
- it enables panning acceleration constants

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

I have no big endian machine to check but the bug is obvious. I hope that someone with the big endian machine could check this driver.


--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-14 06:20:20.981188087 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-13 23:36:49.533883967 +0200
@@ -558,7 +558,8 @@ static void pm3fb_imageblit(struct fb_in
 
 
 	while (height--) {
-		int width = ((image->width + 7) >> 3) + info->pixmap.scan_align;
+		int width = ((image->width + 7) >> 3)
+				+ info->pixmap.scan_align - 1;
 		width >>= 2;
 
 		while (width >= PM3_FIFO_SIZE) {
@@ -1195,6 +1196,10 @@ static int __devinit pm3fb_probe(struct 
 	 */
 	pm3fb_fix.mmio_start = pci_resource_start(dev, 0);
 	pm3fb_fix.mmio_len = PM3_REGS_SIZE;
+#if defined(__BIG_ENDIAN)
+	pm3fb_fix.mmio_start += PM3_REGS_SIZE;
+	DPRINTK("Adjusting register base for big-endian.\n");
+#endif
 
 	/* Registers - request region and map it. */
 	if (!request_mem_region(pm3fb_fix.mmio_start, pm3fb_fix.mmio_len,
@@ -1211,10 +1216,6 @@ static int __devinit pm3fb_probe(struct 
 		goto err_exit_neither;
 	}
 
-#if defined(__BIG_ENDIAN)
-	pm3fb_fix.mmio_start += PM3_REGS_SIZE;
-	DPRINTK("Adjusting register base for big-endian.\n");
-#endif
 	/* Linear frame buffer - request region and map it. */
 	pm3fb_fix.smem_start = pci_resource_start(dev, 1);
 	pm3fb_fix.smem_len = pm3fb_size_memory(par);
@@ -1244,7 +1245,8 @@ static int __devinit pm3fb_probe(struct 
 	info->fix = pm3fb_fix;
 	info->pseudo_palette = par->palette;
 	info->flags = FBINFO_DEFAULT |
-/*			FBINFO_HWACCEL_YPAN |*/
+			FBINFO_HWACCEL_XPAN |
+			FBINFO_HWACCEL_YPAN |
 			FBINFO_HWACCEL_COPYAREA |
 			FBINFO_HWACCEL_IMAGEBLIT |
 			FBINFO_HWACCEL_FILLRECT;


--------------010005090206040805000204
Content-Type: text/plain;
 name="pm3fb-pan.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm3fb-pan.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch contains 3 small improvements:
- it corrects scanline width calculation in pm3fb_imageblit()
- it corrects mmio mapping for big endian machines
- it enables panning acceleration constants

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-14 06:20:20.981188087 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-13 23:36:49.533883967 +0200
@@ -558,7 +558,8 @@ static void pm3fb_imageblit(struct fb_in
 
 
 	while (height--) {
-		int width = ((image->width + 7) >> 3) + info->pixmap.scan_align;
+		int width = ((image->width + 7) >> 3)
+				+ info->pixmap.scan_align - 1;
 		width >>= 2;
 
 		while (width >= PM3_FIFO_SIZE) {
@@ -1195,6 +1196,10 @@ static int __devinit pm3fb_probe(struct 
 	 */
 	pm3fb_fix.mmio_start = pci_resource_start(dev, 0);
 	pm3fb_fix.mmio_len = PM3_REGS_SIZE;
+#if defined(__BIG_ENDIAN)
+	pm3fb_fix.mmio_start += PM3_REGS_SIZE;
+	DPRINTK("Adjusting register base for big-endian.\n");
+#endif
 
 	/* Registers - request region and map it. */
 	if (!request_mem_region(pm3fb_fix.mmio_start, pm3fb_fix.mmio_len,
@@ -1211,10 +1216,6 @@ static int __devinit pm3fb_probe(struct 
 		goto err_exit_neither;
 	}
 
-#if defined(__BIG_ENDIAN)
-	pm3fb_fix.mmio_start += PM3_REGS_SIZE;
-	DPRINTK("Adjusting register base for big-endian.\n");
-#endif
 	/* Linear frame buffer - request region and map it. */
 	pm3fb_fix.smem_start = pci_resource_start(dev, 1);
 	pm3fb_fix.smem_len = pm3fb_size_memory(par);
@@ -1244,7 +1245,8 @@ static int __devinit pm3fb_probe(struct 
 	info->fix = pm3fb_fix;
 	info->pseudo_palette = par->palette;
 	info->flags = FBINFO_DEFAULT |
-/*			FBINFO_HWACCEL_YPAN |*/
+			FBINFO_HWACCEL_XPAN |
+			FBINFO_HWACCEL_YPAN |
 			FBINFO_HWACCEL_COPYAREA |
 			FBINFO_HWACCEL_IMAGEBLIT |
 			FBINFO_HWACCEL_FILLRECT;

--------------010005090206040805000204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------010005090206040805000204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------010005090206040805000204--
