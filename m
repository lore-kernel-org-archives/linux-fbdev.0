From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/6] nvidiafb: ioremap and i2c fixes
Date: Sat, 16 Apr 2005 13:13:20 +0800
Message-ID: <200504161313.25574.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMfr8-0002Aq-Bp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:34 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMfr6-0008B7-L5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:34 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9C589105BD6B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Apr 2005 05:28:19 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- Add 'vram' option to specify amount of video RAM to remap
- Limit remap size to 128 MIB
- Use info->screen_size for remapped RAM
- Fix misplaced label in failure path

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nvidia.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-04-14 12:06:02 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-04-16 11:54:44 +08:00
@@ -408,6 +408,7 @@
 static int noaccel __devinitdata = 0;
 static int noscale __devinitdata = 0;
 static int paneltweak __devinitdata = 0;
+static int vram __devinitdata = 0;
 #ifdef CONFIG_MTRR
 static int nomtrr __devinitdata = 0;
 #endif
@@ -1180,7 +1181,7 @@
 
 	var->xres_virtual = (var->xres_virtual + 63) & ~63;
 
-	vramlen = info->fix.smem_len;
+	vramlen = info->screen_size;
 	pitch = ((var->xres_virtual * var->bits_per_pixel) + 7) / 8;
 	memlen = pitch * var->yres_virtual;
 
@@ -1343,7 +1344,7 @@
 	/* maximize virtual vertical length */
 	lpitch = info->var.xres_virtual *
 		((info->var.bits_per_pixel + 7) >> 3);
-	info->var.yres_virtual = info->fix.smem_len / lpitch;
+	info->var.yres_virtual = info->screen_size / lpitch;
 
 	info->pixmap.scan_align = 4;
 	info->pixmap.buf_align = 4;
@@ -1507,12 +1508,20 @@
 
 	par->FbAddress = nvidiafb_fix.smem_start;
 	par->FbMapSize = par->RamAmountKBytes * 1024;
+	if (vram && vram * 1024 * 1024 < par->FbMapSize)
+		par->FbMapSize = vram * 1024 * 1024;
+
+	/* Limit amount of vram to 128 MB */
+	if (par->FbMapSize > 128 * 1024 * 1024)
+		par->FbMapSize = 128 * 1024 * 1024;
+
 	par->FbUsableSize = par->FbMapSize - (128 * 1024);
 	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :
 	    16 * 1024;
 	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
 	info->screen_base = ioremap(nvidiafb_fix.smem_start, par->FbMapSize);
-	nvidiafb_fix.smem_len = par->FbUsableSize;
+	info->screen_size = par->FbUsableSize;
+	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
 
 	if (!info->screen_base) {
 		printk(KERN_ERR PFX "cannot ioremap FB base\n");
@@ -1524,7 +1533,8 @@
 #ifdef CONFIG_MTRR
 	if (!nomtrr) {
 		par->mtrr.vram = mtrr_add(nvidiafb_fix.smem_start,
-					  par->FbMapSize, MTRR_TYPE_WRCOMB, 1);
+					  par->RamAmountKBytes * 1024,
+					  MTRR_TYPE_WRCOMB, 1);
 		if (par->mtrr.vram < 0) {
 			printk(KERN_ERR PFX "unable to setup MTRR\n");
 		} else {
@@ -1566,9 +1576,9 @@
 
       err_out_iounmap_fb:
 	iounmap(info->screen_base);
+      err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
-      err_out_free_base1:
 	iounmap(par->REGS);
       err_out_free_base0:
 	pci_release_regions(pd);
@@ -1645,6 +1655,8 @@
 			noscale = 1;
 		} else if (!strncmp(this_opt, "paneltweak:", 11)) {
 			paneltweak = simple_strtoul(this_opt+11, NULL, 0);
+		} else if (!strncmp(this_opt, "vram:", 5)) {
+			vram = simple_strtoul(this_opt+5, NULL, 0);
 #ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
@@ -1716,6 +1728,10 @@
 MODULE_PARM_DESC(forceCRTC,
 		 "Forces usage of a particular CRTC in case autodetection "
 		 "fails. (0 or 1) (default=autodetect)");
+module_param(vram, int, 0);
+MODULE_PARM_DESC(vram,
+		 "amount of framebuffer memory to remap in MiB"
+		 "(default=0 - remap entire memory)");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) "




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
