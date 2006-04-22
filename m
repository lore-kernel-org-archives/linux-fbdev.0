From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/4] savagefb: Add state save and_restore hooks
Date: Sat, 22 Apr 2006 10:45:35 +0800
Message-ID: <444998CF.10301@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX8Es-0003cK-Lt
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 19:52:50 -0700
Received: from pproxy.gmail.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FX8Es-0001zL-98
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 19:52:50 -0700
Received: by pproxy.gmail.com with SMTP id i49so647147pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Apr 2006 19:52:50 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, rich@hq.vsaa.lv

Reported by: Rich (Bugzilla Bug 6417)

"if savage driver is used in x.org together with savagefb, it results in
seriously garbled and distorted screen - coupled with severe slowdowns."

This bug is the result of Xorg unable to handle savagefb altering the
hardware which results in X failing to start properly and/or failed console
switching. 

Add savagefb_state_save and savagefb_state_restore. These hooks will only
save and restore the extended VGA registers.  Standard VGA registers will be
left alone.  This is enough to make savagefb play nicely with the latest
Xorg savage driver, and perhaps with savage DRI. (Transient screen artifacts
may appear before X loads and during console switches).

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Rich,

Unfortunately, blanking the screen also leaves Xorg in a blanked state, so I
have to unblank the screen before Xorg loads.  So I doubt if the transient
screen artifacts will be completely invisible but hopefully it will only be
for a shorter duration (not much).

Tony

 drivers/video/savage/savagefb_driver.c |  207 +++++++++++++++++++++++++++++---
 1 files changed, 189 insertions(+), 18 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 267d4e5..0a6f244 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -305,7 +305,7 @@ savage2000_waitidle(struct savagefb_par 
 	while ((savage_in32(0x48C60, par) & 0x009fffff));
 }
 
-
+#if defined(CONFIG_FB_SAVAGE_ACCEL)
 static void
 SavageSetup2DEngine (struct savagefb_par  *par)
 {
@@ -388,6 +388,22 @@ SavageSetup2DEngine (struct savagefb_par
 	BCI_SEND( GlobalBitmapDescriptor );
 }
 
+static void savagefb_set_clip(struct fb_info *info)
+{
+    struct savagefb_par *par = (struct savagefb_par *)info->par;
+    int cmd;
+
+    cmd = BCI_CMD_NOP | BCI_CMD_CLIP_NEW;
+    par->bci_ptr = 0;
+    par->SavageWaitFifo(par,3);
+    BCI_SEND(cmd);
+    BCI_SEND(BCI_CLIP_TL(0, 0));
+    BCI_SEND(BCI_CLIP_BR(0xfff, 0xfff));
+}
+#else
+static void SavageSetup2DEngine (struct savagefb_par  *par) {}
+
+#endif
 
 static void SavageCalcClock(long freq, int min_m, int min_n1, int max_n1,
 			    int min_n2, int max_n2, long freq_min,
@@ -666,6 +682,158 @@ static void savage_get_default_par(struc
 	vga_out8 (0x3d5, cr66, par);
 }
 
+static void savage_set_default_par(struct savagefb_par *par, struct savage_reg *reg)
+{
+	unsigned char cr3a, cr53, cr66;
+
+	vga_out16 (0x3d4, 0x4838, par);
+	vga_out16 (0x3d4, 0xa039, par);
+	vga_out16 (0x3c4, 0x0608, par);
+
+	vga_out8 (0x3d4, 0x66, par);
+	cr66 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr66 | 0x80, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	cr3a = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr3a | 0x80, par);
+	vga_out8 (0x3d4, 0x53, par);
+	cr53 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr53 & 0x7f, par);
+
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, cr66, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	vga_out8 (0x3d5, cr3a, par);
+
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, cr66, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	vga_out8 (0x3d5, cr3a, par);
+
+	/* unlock extended seq regs */
+	vga_out8 (0x3c4, 0x08, par);
+	vga_out8 (0x3c5, reg->SR08, par);
+	vga_out8 (0x3c5, 0x06, par);
+
+	/* now restore all the extended regs we need */
+	vga_out8 (0x3d4, 0x31, par);
+	vga_out8 (0x3d5, reg->CR31, par);
+	vga_out8 (0x3d4, 0x32, par);
+	vga_out8 (0x3d5, reg->CR32, par);
+	vga_out8 (0x3d4, 0x34, par);
+	vga_out8 (0x3d5, reg->CR34, par);
+	vga_out8 (0x3d4, 0x36, par);
+	vga_out8 (0x3d5,reg->CR36, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	vga_out8 (0x3d5, reg->CR3A, par);
+	vga_out8 (0x3d4, 0x40, par);
+	vga_out8 (0x3d5, reg->CR40, par);
+	vga_out8 (0x3d4, 0x42, par);
+	vga_out8 (0x3d5, reg->CR42, par);
+	vga_out8 (0x3d4, 0x45, par);
+	vga_out8 (0x3d5, reg->CR45, par);
+	vga_out8 (0x3d4, 0x50, par);
+	vga_out8 (0x3d5, reg->CR50, par);
+	vga_out8 (0x3d4, 0x51, par);
+	vga_out8 (0x3d5, reg->CR51, par);
+	vga_out8 (0x3d4, 0x53, par);
+	vga_out8 (0x3d5, reg->CR53, par);
+	vga_out8 (0x3d4, 0x58, par);
+	vga_out8 (0x3d5, reg->CR58, par);
+	vga_out8 (0x3d4, 0x60, par);
+	vga_out8 (0x3d5, reg->CR60, par);
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, reg->CR66, par);
+	vga_out8 (0x3d4, 0x67, par);
+	vga_out8 (0x3d5, reg->CR67, par);
+	vga_out8 (0x3d4, 0x68, par);
+	vga_out8 (0x3d5, reg->CR68, par);
+	vga_out8 (0x3d4, 0x69, par);
+	vga_out8 (0x3d5, reg->CR69, par);
+	vga_out8 (0x3d4, 0x6f, par);
+	vga_out8 (0x3d5, reg->CR6F, par);
+
+	vga_out8 (0x3d4, 0x33, par);
+	vga_out8 (0x3d5, reg->CR33, par);
+	vga_out8 (0x3d4, 0x86, par);
+	vga_out8 (0x3d5, reg->CR86, par);
+	vga_out8 (0x3d4, 0x88, par);
+	vga_out8 (0x3d5, reg->CR88, par);
+	vga_out8 (0x3d4, 0x90, par);
+	vga_out8 (0x3d5, reg->CR90, par);
+	vga_out8 (0x3d4, 0x91, par);
+	vga_out8 (0x3d5, reg->CR91, par);
+	vga_out8 (0x3d4, 0xb0, par);
+	vga_out8 (0x3d5, reg->CRB0, par);
+
+	/* extended mode timing regs */
+	vga_out8 (0x3d4, 0x3b, par);
+	vga_out8 (0x3d5, reg->CR3B, par);
+	vga_out8 (0x3d4, 0x3c, par);
+	vga_out8 (0x3d5, reg->CR3C, par);
+	vga_out8 (0x3d4, 0x43, par);
+	vga_out8 (0x3d5, reg->CR43, par);
+	vga_out8 (0x3d4, 0x5d, par);
+	vga_out8 (0x3d5, reg->CR5D, par);
+	vga_out8 (0x3d4, 0x5e, par);
+	vga_out8 (0x3d5, reg->CR5E, par);
+	vga_out8 (0x3d4, 0x65, par);
+	vga_out8 (0x3d5, reg->CR65, par);
+
+	/* save seq extended regs for DCLK PLL programming */
+	vga_out8 (0x3c4, 0x0e, par);
+	vga_out8 (0x3c5, reg->SR0E, par);
+	vga_out8 (0x3c4, 0x0f, par);
+	vga_out8 (0x3c5, reg->SR0F, par);
+	vga_out8 (0x3c4, 0x10, par);
+	vga_out8 (0x3c5, reg->SR10, par);
+	vga_out8 (0x3c4, 0x11, par);
+	vga_out8 (0x3c5, reg->SR11, par);
+	vga_out8 (0x3c4, 0x12, par);
+	vga_out8 (0x3c5, reg->SR12, par);
+	vga_out8 (0x3c4, 0x13, par);
+	vga_out8 (0x3c5, reg->SR13, par);
+	vga_out8 (0x3c4, 0x29, par);
+	vga_out8 (0x3c5, reg->SR29, par);
+
+	vga_out8 (0x3c4, 0x15, par);
+	vga_out8 (0x3c5, reg->SR15, par);
+	vga_out8 (0x3c4, 0x30, par);
+	vga_out8 (0x3c5, reg->SR30, par);
+	vga_out8 (0x3c4, 0x18, par);
+	vga_out8 (0x3c5, reg->SR18, par);
+
+	/* Save flat panel expansion regsters. */
+	if (par->chip == S3_SAVAGE_MX) {
+		int i;
+
+		for (i = 0; i < 8; i++) {
+			vga_out8 (0x3c4, 0x54+i, par);
+			vga_out8 (0x3c5, reg->SR54[i], par);
+		}
+	}
+
+	vga_out8 (0x3d4, 0x66, par);
+	cr66 = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr66 | 0x80, par);
+	vga_out8 (0x3d4, 0x3a, par);
+	cr3a = vga_in8 (0x3d5, par);
+	vga_out8 (0x3d5, cr3a | 0x80, par);
+
+	/* now save MIU regs */
+	if (par->chip != S3_SAVAGE_MX) {
+		savage_out32(FIFO_CONTROL_REG, reg->MMPR0, par);
+		savage_out32(MIU_CONTROL_REG, reg->MMPR1, par);
+		savage_out32(STREAMS_TIMEOUT_REG, reg->MMPR2, par);
+		savage_out32(MISC_TIMEOUT_REG, reg->MMPR3, par);
+	}
+
+	vga_out8 (0x3d4, 0x3a, par);
+	vga_out8 (0x3d5, cr3a, par);
+	vga_out8 (0x3d4, 0x66, par);
+	vga_out8 (0x3d5, cr66, par);
+}
+
 static void savage_update_var(struct fb_var_screeninfo *var, struct fb_videomode *modedb)
 {
 	var->xres = var->xres_virtual = modedb->xres;
@@ -1327,21 +1495,6 @@ static void savagefb_set_fix(struct fb_i
 
 }
 
-#if defined(CONFIG_FB_SAVAGE_ACCEL)
-static void savagefb_set_clip(struct fb_info *info)
-{
-    struct savagefb_par *par = info->par;
-    int cmd;
-
-    cmd = BCI_CMD_NOP | BCI_CMD_CLIP_NEW;
-    par->bci_ptr = 0;
-    par->SavageWaitFifo(par,3);
-    BCI_SEND(cmd);
-    BCI_SEND(BCI_CLIP_TL(0, 0));
-    BCI_SEND(BCI_CLIP_BR(0xfff, 0xfff));
-}
-#endif
-
 static int savagefb_set_par (struct fb_info *info)
 {
 	struct savagefb_par *par = info->par;
@@ -1442,6 +1595,22 @@ static int savagefb_blank(int blank, str
 	return (blank == FB_BLANK_NORMAL) ? 1 : 0;
 }
 
+static void savagefb_save_state(struct fb_info *info)
+{
+	struct savagefb_par *par = info->par;
+
+	savage_get_default_par(par, &par->save);
+}
+
+static void savagefb_restore_state(struct fb_info *info)
+{
+	struct savagefb_par *par = info->par;
+
+	savagefb_blank(FB_BLANK_POWERDOWN, info);
+	savage_set_default_par(par, &par->save);
+	savagefb_blank(FB_BLANK_UNBLANK, info);
+}
+
 static struct fb_ops savagefb_ops = {
 	.owner          = THIS_MODULE,
 	.fb_check_var   = savagefb_check_var,
@@ -1449,6 +1618,8 @@ static struct fb_ops savagefb_ops = {
 	.fb_setcolreg   = savagefb_setcolreg,
 	.fb_pan_display = savagefb_pan_display,
 	.fb_blank       = savagefb_blank,
+	.fb_save_state  = savagefb_save_state,
+	.fb_restore_state = savagefb_restore_state,
 #if defined(CONFIG_FB_SAVAGE_ACCEL)
 	.fb_fillrect    = savagefb_fillrect,
 	.fb_copyarea    = savagefb_copyarea,
@@ -2180,6 +2351,7 @@ static int savagefb_suspend (struct pci_
 		info->fbops->fb_sync(info);
 
 	savagefb_blank(FB_BLANK_POWERDOWN, info);
+	savage_set_default_par(par, &par->save);
 	savage_disable_mmio(par);
 	pci_save_state(dev);
 	pci_disable_device(dev);
@@ -2219,9 +2391,8 @@ static int savagefb_resume (struct pci_d
 	pci_set_master(dev);
 	savage_enable_mmio(par);
 	savage_init_hw(par);
-	savagefb_set_par (info);
-	savagefb_blank(FB_BLANK_UNBLANK, info);
 	fb_set_suspend (info, 0);
+	savagefb_blank(FB_BLANK_UNBLANK, info);
 	release_console_sem();
 
 	return 0;



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
