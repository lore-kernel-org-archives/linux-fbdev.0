From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 1/3] atyfb: Fix HP OmniBook 500 reboot
	hang
Date: Sun, 21 Jun 2009 00:29:42 +0300
Message-ID: <1245533384-28371-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1MI88M-0007yC-0J
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Jun 2009 21:29:58 +0000
Received: from smtp4.welho.com ([213.243.153.38])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MI88K-0002FW-Ln for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Jun 2009 21:29:57 +0000
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, Ville Syrjala <syrjala@sci.fi>

Apparently HP OmniBook 500's BIOS doesn't like the way atyfb reprograms
the hardware. The BIOS will simply hang after a reboot. Fix the problem
by restoring the hardware to it's original state on reboot.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
This is new version of the patch I sent earlier. I tested the earlier
patch with another laptop (Dell Inspiron 7000) and restoring the mode
caused the LCD to bloom briefly. The BIOS restored the LCD to a proper
state but the blooming wasn't too pretty so I decided to add the DMI
match. So now the reboot notifier is registered only on the affected
laptop. I also added fb_info locking into the reboot notifier call.

 drivers/video/aty/atyfb.h      |    2 +
 drivers/video/aty/atyfb_base.c |   89 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/drivers/video/aty/atyfb.h b/drivers/video/aty/atyfb.h
index 7691e73..0369653 100644
--- a/drivers/video/aty/atyfb.h
+++ b/drivers/video/aty/atyfb.h
@@ -187,6 +187,8 @@ struct atyfb_par {
 	int mtrr_reg;
 #endif
 	u32 mem_cntl;
+	struct crtc saved_crtc;
+	union aty_pll saved_pll;
 };
 
     /*
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 1207c20..0678290 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -66,6 +66,8 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/backlight.h>
+#include <linux/reboot.h>
+#include <linux/dmi.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -249,8 +251,6 @@ static int aty_init(struct fb_info *info);
 static int store_video_par(char *videopar, unsigned char m64_num);
 #endif
 
-static struct crtc saved_crtc;
-static union aty_pll saved_pll;
 static void aty_get_crtc(const struct atyfb_par *par, struct crtc *crtc);
 
 static void aty_set_crtc(const struct atyfb_par *par, const struct crtc *crtc);
@@ -261,6 +261,8 @@ static void set_off_pitch(struct atyfb_par *par, const struct fb_info *info);
 static int read_aty_sense(const struct atyfb_par *par);
 #endif
 
+static DEFINE_MUTEX(reboot_lock);
+static struct fb_info *reboot_info;
 
     /*
      *  Interface used by the world
@@ -2390,9 +2392,9 @@ static int __devinit aty_init(struct fb_info *info)
 #endif /* CONFIG_FB_ATY_CT */
 
 	/* save previous video mode */
-	aty_get_crtc(par, &saved_crtc);
+	aty_get_crtc(par, &par->saved_crtc);
 	if(par->pll_ops->get_pll)
-		par->pll_ops->get_pll(info, &saved_pll);
+		par->pll_ops->get_pll(info, &par->saved_pll);
 
 	par->mem_cntl = aty_ld_le32(MEM_CNTL, par);
 	gtb_memsize = M64_HAS(GTB_DSP);
@@ -2667,8 +2669,8 @@ static int __devinit aty_init(struct fb_info *info)
 
 aty_init_exit:
 	/* restore video mode */
-	aty_set_crtc(par, &saved_crtc);
-	par->pll_ops->set_pll(info, &saved_pll);
+	aty_set_crtc(par, &par->saved_crtc);
+	par->pll_ops->set_pll(info, &par->saved_pll);
 
 #ifdef CONFIG_MTRR
 	if (par->mtrr_reg >= 0) {
@@ -3502,6 +3504,11 @@ static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_devi
 	par->mmap_map[1].prot_flag = _PAGE_E;
 #endif /* __sparc__ */
 
+	mutex_lock(&reboot_lock);
+	if (!reboot_info)
+		reboot_info = info;
+	mutex_unlock(&reboot_lock);
+
 	return 0;
 
 err_release_io:
@@ -3614,8 +3621,8 @@ static void __devexit atyfb_remove(struct fb_info *info)
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
 	/* restore video mode */
-	aty_set_crtc(par, &saved_crtc);
-	par->pll_ops->set_pll(info, &saved_pll);
+	aty_set_crtc(par, &par->saved_crtc);
+	par->pll_ops->set_pll(info, &par->saved_pll);
 
 	unregister_framebuffer(info);
 
@@ -3661,6 +3668,11 @@ static void __devexit atyfb_pci_remove(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 
+	mutex_lock(&reboot_lock);
+	if (reboot_info == info)
+		reboot_info = NULL;
+	mutex_unlock(&reboot_lock);
+
 	atyfb_remove(info);
 }
 
@@ -3808,6 +3820,56 @@ static int __init atyfb_setup(char *options)
 }
 #endif  /*  MODULE  */
 
+static int atyfb_reboot_notify(struct notifier_block *nb,
+			       unsigned long code, void *unused)
+{
+	struct atyfb_par *par;
+
+	if (code != SYS_RESTART)
+		return NOTIFY_DONE;
+
+	mutex_lock(&reboot_lock);
+
+	if (!reboot_info)
+		goto out;
+
+	if (!lock_fb_info(reboot_info))
+		goto out;
+
+	par = reboot_info->par;
+
+	/*
+	 * HP OmniBook 500's BIOS doesn't like the state of the
+	 * hardware after atyfb has been used. Restore the hardware
+	 * to the original state to allow successful reboots.
+	 */
+	aty_set_crtc(par, &par->saved_crtc);
+	par->pll_ops->set_pll(reboot_info, &par->saved_pll);
+
+	unlock_fb_info(reboot_info);
+ out:
+	mutex_unlock(&reboot_lock);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block atyfb_reboot_notifier = {
+	.notifier_call = atyfb_reboot_notify,
+};
+
+static const struct dmi_system_id atyfb_reboot_ids[] = {
+	{
+		.ident = "HP OmniBook 500",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP OmniBook PC"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "HP OmniBook 500 FA"),
+		},
+	},
+
+	{ }
+};
+
 static int __init atyfb_init(void)
 {
     int err1 = 1, err2 = 1;
@@ -3826,11 +3888,20 @@ static int __init atyfb_init(void)
     err2 = atyfb_atari_probe();
 #endif
 
-    return (err1 && err2) ? -ENODEV : 0;
+    if (err1 && err2)
+	return -ENODEV;
+
+    if (dmi_check_system(atyfb_reboot_ids))
+	register_reboot_notifier(&atyfb_reboot_notifier);
+
+    return 0;
 }
 
 static void __exit atyfb_exit(void)
 {
+	if (dmi_check_system(atyfb_reboot_ids))
+		unregister_reboot_notifier(&atyfb_reboot_notifier);
+
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&atyfb_driver);
 #endif
-- 
1.6.0.6


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
