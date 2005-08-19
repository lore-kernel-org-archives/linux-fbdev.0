From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/9] savagefb: Driver updates
Date: Sat, 20 Aug 2005 00:36:12 +0800
Message-ID: <43060A7C.6010209@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HH6-0002Jf-9B
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:31:52 -0700
Received: from wproxy.gmail.com ([64.233.184.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6HH3-0000fB-PB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:31:52 -0700
Received: by wproxy.gmail.com with SMTP id i21so610588wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 17:31:42 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    1. Fallback to firmware EDID if chipset has no DDC/I2C support or if I2C
    probing failed

    2. Add fb_blank hook

    3. Fix savagefb_suspend/resume to enable driver to successfully suspend
    and resume from S3, memory or disk

    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 savagefb-i2c.c    |   16 ++++--
 savagefb.h        |   13 ++++-
 savagefb_driver.c |  139 +++++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 147 insertions(+), 21 deletions(-)

diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -259,8 +259,9 @@ static u8 *savage_do_probe_i2c_edid(stru
 	return buf;
 }
 
-int savagefb_probe_i2c_connector(struct savagefb_par *par, u8 **out_edid)
+int savagefb_probe_i2c_connector(struct fb_info *info, u8 **out_edid)
 {
+	struct savagefb_par *par = info->par;
 	u8 *edid = NULL;
 	int i;
 
@@ -270,12 +271,19 @@ int savagefb_probe_i2c_connector(struct 
 		if (edid)
 			break;
 	}
+
+	if (!edid) {
+		/* try to get from firmware */
+		edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
+		if (edid)
+			memcpy(edid, fb_firmware_edid(info->device),
+			       EDID_LENGTH);
+	}
+
 	if (out_edid)
 		*out_edid = edid;
-	if (!edid)
-		return 1;
 
-	return 0;
+	return (edid) ? 0 : 1;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/savage/savagefb.h b/drivers/video/savage/savagefb.h
--- a/drivers/video/savage/savagefb.h
+++ b/drivers/video/savage/savagefb.h
@@ -60,6 +60,7 @@
 
 #define S3_SAVAGE_SERIES(chip)    ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE2000))
 
+#define S3_MOBILE_TWISTER_SERIES(chip) ((chip==S3_TWISTER) || (chip == S3_PROSAVAGEDDR))
 
 /* Chip tags.  These are used to group the adapters into
  * related families.
@@ -73,6 +74,8 @@ typedef enum {
   S3_PROSAVAGE,
   S3_SUPERSAVAGE,
   S3_SAVAGE2000,
+  S3_PROSAVAGEDDR,
+  S3_TWISTER,
   S3_LAST
 } savage_chipset;
 
@@ -128,6 +131,10 @@ typedef enum {
 #define BCI_CMD_SET_ROP(cmd, rop)    ((cmd) |= ((rop & 0xFF) << 16))
 #define BCI_CMD_SEND_COLOR           0x00008000
 
+#define DISP_CRT     1
+#define DISP_LCD     2
+#define DISP_DFP     3
+
 struct xtimings {
 	unsigned int Clock;
 	unsigned int HDisplay;
@@ -166,6 +173,10 @@ struct savagefb_par {
 	struct savagefb_i2c_chan chan;
 	unsigned char   *edid;
 	u32 pseudo_palette[16];
+	int pm_state;
+	int display_type;
+	int dvi;
+	int crtonly;
 	int dacSpeedBpp;
 	int maxClock;
 	int minClock;
@@ -338,7 +349,7 @@ do {                       \
 	} \
 }
 
-extern int savagefb_probe_i2c_connector(struct savagefb_par *par,
+extern int savagefb_probe_i2c_connector(struct fb_info *info,
 					u8 **out_edid);
 extern void savagefb_create_i2c_busses(struct fb_info *info);
 extern void savagefb_delete_i2c_busses(struct fb_info *info);
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1400,6 +1400,58 @@ static int savagefb_pan_display (struct 
 	return 0;
 }
 
+static int savagefb_blank(int blank, struct fb_info *info)
+{
+	struct savagefb_par *par = info->par;
+	u8 sr8 = 0, srd = 0;
+
+	if (par->display_type == DISP_CRT) {
+		vga_out8(0x3c4, 0x08);
+		sr8 = vga_in8(0x3c5);
+		sr8 |= 0x06;
+		vga_out8(0x3c5, sr8);
+		vga_out8(0x3c4, 0x0d);
+		srd = vga_in8(0x3c5);
+		srd &= 0x03;
+
+		switch (blank) {
+		case FB_BLANK_UNBLANK:
+		case FB_BLANK_NORMAL:
+			break;
+		case FB_BLANK_VSYNC_SUSPEND:
+			srd |= 0x10;
+			break;
+		case FB_BLANK_HSYNC_SUSPEND:
+			srd |= 0x40;
+			break;
+		case FB_BLANK_POWERDOWN:
+			srd |= 0x50;
+			break;
+		}
+
+		vga_out8(0x3c4, 0x0d);
+		vga_out8(0x3c5, srd);
+	}
+
+	if (par->display_type == DISP_LCD ||
+	    par->display_type == DISP_DFP) {
+		switch(blank) {
+		case FB_BLANK_UNBLANK:
+		case FB_BLANK_NORMAL:
+			vga_out8(0x3c4, 0x31); /* SR31 bit 4 - FP enable */
+			vga_out8(0x3c5, vga_in8(0x3c5) | 0x10);
+			break;
+		case FB_BLANK_VSYNC_SUSPEND:
+		case FB_BLANK_HSYNC_SUSPEND:
+		case FB_BLANK_POWERDOWN:
+			vga_out8(0x3c4, 0x31); /* SR31 bit 4 - FP enable */
+			vga_out8(0x3c5, vga_in8(0x3c5) & ~0x10);
+			break;
+		}
+	}
+
+	return (blank == FB_BLANK_NORMAL) ? 1 : 0;
+}
 
 static struct fb_ops savagefb_ops = {
 	.owner          = THIS_MODULE,
@@ -1407,6 +1459,7 @@ static struct fb_ops savagefb_ops = {
 	.fb_set_par     = savagefb_set_par,
 	.fb_setcolreg   = savagefb_setcolreg,
 	.fb_pan_display = savagefb_pan_display,
+	.fb_blank       = savagefb_blank,
 #if defined(CONFIG_FB_SAVAGE_ACCEL)
 	.fb_fillrect    = savagefb_fillrect,
 	.fb_copyarea    = savagefb_copyarea,
@@ -1583,8 +1636,7 @@ static int __devinit savage_init_hw (str
 	static unsigned char RamSavage4[] =  { 2, 4, 8, 12, 16, 32, 64, 32 };
 	static unsigned char RamSavageMX[] = { 2, 8, 4, 16, 8, 16, 4, 16 };
 	static unsigned char RamSavageNB[] = { 0, 2, 4, 8, 16, 32, 2, 2 };
-
-	int videoRam, videoRambytes;
+	int videoRam, videoRambytes, dvi;
 
 	DBG("savage_init_hw");
 
@@ -1705,6 +1757,30 @@ static int __devinit savage_init_hw (str
 	printk (KERN_INFO "savagefb: Detected current MCLK value of %d kHz\n",
 		par->MCLK);
 
+	/* check for DVI/flat panel */
+	dvi = 0;
+
+	if (par->chip == S3_SAVAGE4) {
+		unsigned char sr30 = 0x00;
+
+		vga_out8(0x3c4, 0x30);
+		/* clear bit 1 */
+		vga_out8(0x3c5, vga_in8(0x3c5) & ~0x02);
+		sr30 = vga_in8(0x3c5);
+		if (sr30 & 0x02 /*0x04 */) {
+			dvi = 1;
+			printk("savagefb: Digital Flat Panel Detected\n");
+		}
+	}
+
+	if (S3_SAVAGE_MOBILE_SERIES(par->chip) ||
+	    (S3_MOBILE_TWISTER_SERIES(par->chip) && !par->crtonly))
+		par->display_type = DISP_LCD;
+	else if (dvi || (par->chip == S3_SAVAGE4 && par->dvi))
+		par->display_type = DISP_DFP;
+	else
+		par->display_type = DISP_CRT;
+
 	/* Check LCD panel parrmation */
 
 	if (par->chip == S3_SAVAGE_MX) {
@@ -1759,7 +1835,8 @@ static int __devinit savage_init_hw (str
 			par->SavagePanelWidth = panelX;
 			par->SavagePanelHeight = panelY;
 
-		}
+		} else
+			par->display_type = DISP_CRT;
 	}
 
 	savage_get_default_par (par);
@@ -1845,15 +1922,15 @@ static int __devinit savage_init_fb_info
 		snprintf (info->fix.id, 16, "ProSavageKM");
 		break;
 	case FB_ACCEL_S3TWISTER_P:
-		par->chip = S3_PROSAVAGE;
+		par->chip = S3_TWISTER;
 		snprintf (info->fix.id, 16, "TwisterP");
 		break;
 	case FB_ACCEL_S3TWISTER_K:
-		par->chip = S3_PROSAVAGE;
+		par->chip = S3_TWISTER;
 		snprintf (info->fix.id, 16, "TwisterK");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDR:
-		par->chip = S3_PROSAVAGE;
+		par->chip = S3_PROSAVAGEDDR;
 		snprintf (info->fix.id, 16, "ProSavageDDR");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDRK:
@@ -1959,7 +2036,8 @@ static int __devinit savagefb_probe (str
 	INIT_LIST_HEAD(&info->modelist);
 #if defined(CONFIG_FB_SAVAGE_I2C)
 	savagefb_create_i2c_busses(info);
-	savagefb_probe_i2c_connector(par, &par->edid);
+	savagefb_probe_i2c_connector(info, &par->edid);
+	kfree(par->edid);
 	fb_edid_to_monspecs(par->edid, &info->monspecs);
 	fb_videomode_to_modelist(info->monspecs.modedb,
 				 info->monspecs.modedb_len,
@@ -2111,13 +2189,30 @@ static int savagefb_suspend (struct pci_
 
 	DBG("savagefb_suspend");
 
+
+	par->pm_state = state.event;
+
+	/*
+	 * For PM_EVENT_FREEZE, do not power down so the console
+	 * can remain active.
+	 */
+	if (state.event == PM_EVENT_FREEZE) {
+		dev->dev.power.power_state = state;
+		return 0;
+	}
+
 	acquire_console_sem();
-	fb_set_suspend(info, pci_choose_state(dev, state));
-	savage_disable_mmio(par);
-	release_console_sem();
+	fb_set_suspend(info, 1);
+
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
 
+	savagefb_blank(FB_BLANK_POWERDOWN, info);
+	savage_disable_mmio(par);
+	pci_save_state(dev);
 	pci_disable_device(dev);
 	pci_set_power_state(dev, pci_choose_state(dev, state));
+	release_console_sem();
 
 	return 0;
 }
@@ -2127,22 +2222,34 @@ static int savagefb_resume (struct pci_d
 	struct fb_info *info =
 		(struct fb_info *)pci_get_drvdata(dev);
 	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	int cur_state = par->pm_state;
 
 	DBG("savage_resume");
 
-	pci_set_power_state(dev, 0);
-	pci_restore_state(dev);
-	if(pci_enable_device(dev))
-		DBG("err");
+	par->pm_state = PM_EVENT_ON;
 
-	SavagePrintRegs();
+	/*
+	 * The adapter was not powered down coming back from a
+	 * PM_EVENT_FREEZE.
+	 */
+	if (cur_state == PM_EVENT_FREEZE) {
+		pci_set_power_state(dev, PCI_D0);
+		return 0;
+	}
 
 	acquire_console_sem();
 
+	pci_set_power_state(dev, PCI_D0);
+	pci_restore_state(dev);
+
+	if(pci_enable_device(dev))
+		DBG("err");
+
+	pci_set_master(dev);
 	savage_enable_mmio(par);
 	savage_init_hw(par);
 	savagefb_set_par (info);
-
+	savagefb_blank(FB_BLANK_UNBLANK, info);
 	fb_set_suspend (info, 0);
 	release_console_sem();
 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
