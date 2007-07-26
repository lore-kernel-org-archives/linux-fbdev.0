From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 22/33] pm2fb: Permedia 2V initialization
	fixes
Date: Thu, 26 Jul 2007 20:27:52 +0800
Message-ID: <46A89348.9020706@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2vF-00019u-PC for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:58:33 -0700
Received: from nz-out-0506.google.com ([64.233.162.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2vF-0008TI-CD
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:58:29 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1352216nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:58:29 -0700 (PDT)
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

This patch:
- initializes correctly the Permedia2V chip if it is not initialized by BIOS
- puts back clock frequency for the ELSA WINNER board to 100kHz
- fixes returned error values from setcolreg() function
- uses more general classes for PCI ids

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c     |   42 ++++++++++++++++++------------------------
 include/video/permedia2.h |    1 +
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index bfbcfe1..06ac564 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -343,7 +343,7 @@ #endif
 
 static void reset_config(struct pm2fb_par* p)
 {
-	WAIT_FIFO(p, 52);
+	WAIT_FIFO(p, 53);
 	pm2_WR(p, PM2R_CHIP_CONFIG, pm2_RD(p, PM2R_CHIP_CONFIG) &
 			~(PM2F_VGA_ENABLE | PM2F_VGA_FIXED));
 	pm2_WR(p, PM2R_BYPASS_WRITE_MASK, ~(0L));
@@ -380,6 +380,7 @@ static void reset_config(struct pm2fb_pa
 	pm2_WR(p, PM2R_STATISTICS_MODE, 0);
 	pm2_WR(p, PM2R_SCISSOR_MODE, 0);
 	pm2_WR(p, PM2R_FILTER_MODE, PM2F_SYNCHRONIZATION);
+	pm2_WR(p, PM2R_RD_PIXEL_MASK, 0xff);
 	switch (p->type) {
 	case PM2_TYPE_PERMEDIA2:
 		pm2_RDAC_WR(p, PM2I_RD_MODE_CONTROL, 0); /* no overlay */
@@ -393,11 +394,6 @@ static void reset_config(struct pm2fb_pa
 		break;
 	case PM2_TYPE_PERMEDIA2V:
 		pm2v_RDAC_WR(p, PM2VI_RD_MISC_CONTROL, 1); /* 8bit */
-		pm2v_RDAC_WR(p, PM2I_RD_COLOR_KEY_CONTROL, 0);
-		pm2v_RDAC_WR(p, PM2I_RD_OVERLAY_KEY, 0);
-		pm2v_RDAC_WR(p, PM2I_RD_RED_KEY, 0);
-		pm2v_RDAC_WR(p, PM2I_RD_GREEN_KEY, 0);
-		pm2v_RDAC_WR(p, PM2I_RD_BLUE_KEY, 0);
 		break;
 	}
 }
@@ -532,7 +528,7 @@ static void set_video(struct pm2fb_par* 
 	vsync &= ~(PM2F_HSYNC_MASK | PM2F_VSYNC_MASK);
 	vsync |= PM2F_HSYNC_ACT_HIGH | PM2F_VSYNC_ACT_HIGH;
 
-	WAIT_FIFO(p, 5);
+	WAIT_FIFO(p, 3);
 	pm2_WR(p, PM2R_VIDEO_CONTROL, vsync);
 
 	switch (p->type) {
@@ -551,7 +547,6 @@ static void set_video(struct pm2fb_par* 
 		if ((video & PM2F_VSYNC_MASK) == PM2F_VSYNC_ACT_LOW)
 			tmp |= 4; /* invert vsync */
 		pm2v_RDAC_WR(p, PM2VI_RD_SYNC_CONTROL, tmp);
-		pm2v_RDAC_WR(p, PM2VI_RD_MISC_CONTROL, 1);
 		break;
 	}
 }
@@ -686,6 +681,7 @@ static int pm2fb_set_par(struct fb_info 
 	u32 txtmap = 0;
 	u32 pixsize = 0;
 	u32 clrformat = 0;
+	u32 misc = 1; /* 8-bit DAC */
 	u32 xres = (info->var.xres + 31) & ~31;
 	int data64;
 
@@ -767,7 +763,7 @@ static int pm2fb_set_par(struct fb_info 
 	switch (depth) {
 	case 8:
 		pm2_WR(par, PM2R_FB_READ_PIXEL, 0);
-		clrformat = 0x0e;
+		clrformat = 0x2e;
 		break;
 	case 16:
 		pm2_WR(par, PM2R_FB_READ_PIXEL, 1);
@@ -775,6 +771,7 @@ static int pm2fb_set_par(struct fb_info 
 		txtmap = PM2F_TEXTEL_SIZE_16;
 		pixsize = 1;
 		clrformat = 0x70;
+		misc |= 8;
 		break;
 	case 32:
 		pm2_WR(par, PM2R_FB_READ_PIXEL, 2);
@@ -782,6 +779,7 @@ static int pm2fb_set_par(struct fb_info 
 		txtmap = PM2F_TEXTEL_SIZE_32;
 		pixsize = 2;
 		clrformat = 0x20;
+		misc |= 8;
 		break;
 	case 24:
 		pm2_WR(par, PM2R_FB_READ_PIXEL, 4);
@@ -789,6 +787,7 @@ static int pm2fb_set_par(struct fb_info 
 		txtmap = PM2F_TEXTEL_SIZE_24;
 		pixsize = 4;
 		clrformat = 0x20;
+		misc |= 8;
 		break;
 	}
 	pm2_WR(par, PM2R_FB_WRITE_MODE, PM2F_FB_WRITE_ENABLE);
@@ -813,7 +812,7 @@ static int pm2fb_set_par(struct fb_info 
 	pm2_WR(par, PM2R_SCREEN_BASE, base);
 	wmb();
 	set_video(par, video);
-	WAIT_FIFO(par, 6);
+	WAIT_FIFO(par, 10);
 	switch (par->type) {
 	case PM2_TYPE_PERMEDIA2:
 		pm2_RDAC_WR(par, PM2I_RD_COLOR_MODE, clrmode);
@@ -821,10 +820,11 @@ static int pm2fb_set_par(struct fb_info 
 			        (depth == 8) ? 0 : PM2F_COLOR_KEY_TEST_OFF);
 		break;
 	case PM2_TYPE_PERMEDIA2V:
+		pm2v_RDAC_WR(par, PM2VI_RD_DAC_CONTROL, 0);
 		pm2v_RDAC_WR(par, PM2VI_RD_PIXEL_SIZE, pixsize);
 		pm2v_RDAC_WR(par, PM2VI_RD_COLOR_FORMAT, clrformat);
-		pm2v_RDAC_WR(par, PM2I_RD_COLOR_KEY_CONTROL,
-			         (depth == 8) ? 0 : PM2F_COLOR_KEY_TEST_OFF);
+		pm2v_RDAC_WR(par, PM2VI_RD_MISC_CONTROL, misc);
+		pm2v_RDAC_WR(par, PM2VI_RD_OVERLAY_KEY, 0);
 		break;
 	}
 	set_pixclock(par, pixclock);
@@ -855,7 +855,7 @@ static int pm2fb_setcolreg(unsigned regn
 	struct pm2fb_par *par = info->par;
 
 	if (regno >= info->cmap.len)  /* no. of hw registers */
-		return 1;
+		return -EINVAL;
 	/*
 	 * Program hardware... do anything you want with transp
 	 */
@@ -914,7 +914,7 @@ #undef CNVT_TOHW
 		u32 v;
 
 		if (regno >= 16)
-			return 1;
+			return -EINVAL;
 
 		v = (red << info->var.red.offset) |
 			(green << info->var.green.offset) |
@@ -1341,7 +1341,7 @@ #endif
 			DPRINTK("We have not been initialized by VGA BIOS "
 				"and are running on an Elsa Winner 2000 Office\n");
 			DPRINTK("Initializing card timings manually...\n");
-			default_par->memclock = 70000;
+			default_par->memclock = 100000;
 		}
 		if (pdev->subsystem_vendor == 0x3d3d &&
 			pdev->subsystem_device == 0x0100) {
@@ -1491,17 +1491,11 @@ #endif /* CONFIG_MTRR */
 
 static struct pci_device_id pm2fb_id_table[] = {
 	{ PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_TVP4020,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  0xff0000, 0 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  0xff0000, 0 },
-	{ PCI_VENDOR_ID_3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2V,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  0xff0000, 0 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2V,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_NOT_DEFINED_VGA << 8,
-	  0xff00, 0 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
 };
 
diff --git a/include/video/permedia2.h b/include/video/permedia2.h
index 144c81c..cf1d95b 100644
--- a/include/video/permedia2.h
+++ b/include/video/permedia2.h
@@ -153,6 +153,7 @@ #define PM2VI_RD_CURSOR_Y_LOW				0x009
 #define PM2VI_RD_CURSOR_Y_HIGH				0x00A
 #define PM2VI_RD_CURSOR_X_HOT				0x00B
 #define PM2VI_RD_CURSOR_Y_HOT				0x00C
+#define PM2VI_RD_OVERLAY_KEY				0x00D
 #define PM2VI_RD_CLK0_PRESCALE				0x201
 #define PM2VI_RD_CLK0_FEEDBACK				0x202
 #define PM2VI_RD_CLK0_POSTSCALE				0x203


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
