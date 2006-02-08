From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/2] nvidiafb: Add suspend and resume hooks
Date: Wed, 08 Feb 2006 09:01:33 +0800
Message-ID: <43E942ED.7040902@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6div-0007FW-UG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Feb 2006 17:02:21 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F6div-0004wR-KW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Feb 2006 17:02:22 -0800
Received: by pproxy.gmail.com with SMTP id z59so745612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Feb 2006 17:02:21 -0800 (PST)
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

Add suspend and resume hooks to make software suspend more reliable. Resuming
from standby should generally work.  Resuming from mem and from disk requires
that the GPU is disabled.  Adding these to the suspend script...

fbset -accel false -a
/* suspend here */
fbset -accel true -a

... should generally work. In addition, resuming from mem requires that the
video card has to be POSTed by the BIOS or some other utility.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nv_accel.c |   12 ++++
 drivers/video/nvidia/nv_type.h  |    1 
 drivers/video/nvidia/nvidia.c   |  110 ++++++++++++++++++++++++++++-----------
 3 files changed, 92 insertions(+), 31 deletions(-)

diff --git a/drivers/video/nvidia/nv_accel.c b/drivers/video/nvidia/nv_accel.c
index f377a29..4aefb8f 100644
--- a/drivers/video/nvidia/nv_accel.c
+++ b/drivers/video/nvidia/nv_accel.c
@@ -300,6 +300,9 @@ int nvidiafb_sync(struct fb_info *info)
 {
 	struct nvidia_par *par = info->par;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return 0;
+
 	if (!par->lockup)
 		NVFlush(par);
 
@@ -313,6 +316,9 @@ void nvidiafb_copyarea(struct fb_info *i
 {
 	struct nvidia_par *par = info->par;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+
 	if (par->lockup)
 		return cfb_copyarea(info, region);
 
@@ -329,6 +335,9 @@ void nvidiafb_fillrect(struct fb_info *i
 	struct nvidia_par *par = info->par;
 	u32 color;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+
 	if (par->lockup)
 		return cfb_fillrect(info, rect);
 
@@ -412,6 +421,9 @@ void nvidiafb_imageblit(struct fb_info *
 {
 	struct nvidia_par *par = info->par;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+
 	if (image->depth == 1 && !par->lockup)
 		nvidiafb_mono_color_expand(info, image);
 	else
diff --git a/drivers/video/nvidia/nv_type.h b/drivers/video/nvidia/nv_type.h
index e4a5b1d..acdc266 100644
--- a/drivers/video/nvidia/nv_type.h
+++ b/drivers/video/nvidia/nv_type.h
@@ -129,6 +129,7 @@ struct nvidia_par {
 	int fpHeight;
 	int PanelTweak;
 	int paneltweak;
+	int pm_state;
 	u32 crtcSync_read;
 	u32 fpSyncs;
 	u32 dmaPut;
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index a7c4e5e..a6100e2 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -21,6 +21,7 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/console.h>
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
 #endif
@@ -615,6 +616,30 @@ static int nvidia_panel_tweak(struct nvi
    return tweak;
 }
 
+static void nvidia_vga_protect(struct nvidia_par *par, int on)
+{
+	unsigned char tmp;
+
+	if (on) {
+		/*
+		 * Turn off screen and disable sequencer.
+		 */
+		tmp = NVReadSeq(par, 0x01);
+
+		NVWriteSeq(par, 0x00, 0x01);		/* Synchronous Reset */
+		NVWriteSeq(par, 0x01, tmp | 0x20);	/* disable the display */
+	} else {
+		/*
+		 * Reenable sequencer, then turn on screen.
+		 */
+
+		tmp = NVReadSeq(par, 0x01);
+
+		NVWriteSeq(par, 0x01, tmp & ~0x20);	/* reenable display */
+		NVWriteSeq(par, 0x00, 0x03);		/* End Reset */
+	}
+}
+
 static void nvidia_save_vga(struct nvidia_par *par,
 			    struct _riva_hw_state *state)
 {
@@ -643,9 +668,9 @@ static void nvidia_save_vga(struct nvidi
 
 #undef DUMP_REG
 
-static void nvidia_write_regs(struct nvidia_par *par)
+static void nvidia_write_regs(struct nvidia_par *par,
+			      struct _riva_hw_state *state)
 {
-	struct _riva_hw_state *state = &par->ModeReg;
 	int i;
 
 	NVTRACE_ENTER();
@@ -694,32 +719,6 @@ static void nvidia_write_regs(struct nvi
 	NVTRACE_LEAVE();
 }
 
-static void nvidia_vga_protect(struct nvidia_par *par, int on)
-{
-	unsigned char tmp;
-
-	if (on) {
-		/*
-		 * Turn off screen and disable sequencer.
-		 */
-		tmp = NVReadSeq(par, 0x01);
-
-		NVWriteSeq(par, 0x00, 0x01);		/* Synchronous Reset */
-		NVWriteSeq(par, 0x01, tmp | 0x20);	/* disable the display */
-	} else {
-		/*
-		 * Reenable sequencer, then turn on screen.
-		 */
-
-		tmp = NVReadSeq(par, 0x01);
-
-		NVWriteSeq(par, 0x01, tmp & ~0x20);	/* reenable display */
-		NVWriteSeq(par, 0x00, 0x03);		/* End Reset */
-	}
-}
-
-
-
 static int nvidia_calc_regs(struct fb_info *info)
 {
 	struct nvidia_par *par = info->par;
@@ -1068,7 +1067,8 @@ static int nvidiafb_set_par(struct fb_in
 
 	nvidia_vga_protect(par, 1);
 
-	nvidia_write_regs(par);
+	nvidia_write_regs(par, &par->ModeReg);
+	NVSetStartAddress(par, 0);
 
 #if defined (__BIG_ENDIAN)
 	/* turn on LFB swapping */
@@ -1377,6 +1377,52 @@ static struct fb_ops nvidia_fb_ops = {
 	.fb_sync        = nvidiafb_sync,
 };
 
+static int nvidiafb_suspend (struct pci_dev* dev, pm_message_t state)
+{
+	struct fb_info *info = pci_get_drvdata(dev);
+	struct nvidia_par *par = info->par;
+
+	acquire_console_sem();
+	par->pm_state = state.event;
+
+	if (state.event == PM_EVENT_FREEZE) {
+		dev->dev.power.power_state = state;
+	} else {
+		fb_set_suspend(info, 1);
+		nvidiafb_blank(FB_BLANK_POWERDOWN, info);
+		nvidia_write_regs(par, &par->SavedReg);
+		pci_save_state(dev);
+		pci_disable_device(dev);
+		pci_set_power_state(dev, pci_choose_state(dev, state));
+	}
+
+	release_console_sem();
+	return 0;
+}
+
+static int nvidiafb_resume (struct pci_dev* dev)
+{
+	struct fb_info *info = pci_get_drvdata(dev);
+	struct nvidia_par *par = info->par;
+
+	acquire_console_sem();
+	pci_set_power_state(dev, PCI_D0);
+
+	if (par->pm_state != PM_EVENT_FREEZE) {
+		pci_restore_state(dev);
+		pci_enable_device(dev);
+		pci_set_master(dev);
+	}
+
+	par->pm_state = PM_EVENT_ON;
+	nvidiafb_set_par(info);
+	fb_set_suspend (info, 0);
+	nvidiafb_blank(FB_BLANK_UNBLANK, info);
+
+	release_console_sem();
+	return 0;
+}
+
 static int __devinit nvidia_set_fbinfo(struct fb_info *info)
 {
 	struct fb_monspecs *specs = &info->monspecs;
@@ -1798,8 +1844,10 @@ static int __devinit nvidiafb_setup(char
 static struct pci_driver nvidiafb_driver = {
 	.name = "nvidiafb",
 	.id_table = nvidiafb_pci_tbl,
-	.probe = nvidiafb_probe,
-	.remove = __exit_p(nvidiafb_remove),
+	.probe    = nvidiafb_probe,
+	.suspend  = nvidiafb_suspend,
+	.resume   = nvidiafb_resume,
+	.remove   = __exit_p(nvidiafb_remove),
 };
 
 /* ------------------------------------------------------------------------- *




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
