From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 07 Aug 2015 12:16:02 +0000
Subject: [PATCH 1/5] staging: sm750fb: remove multiple blank line
Message-Id: <1438949046-18765-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Multiple blank lines are not kernel coding style and so checkpatch
complains. Remove them.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/sm750.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c7ab818..8990ff4 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -26,7 +26,6 @@
 
 int smi_indent;
 
-
 /*
  * #ifdef __BIG_ENDIAN
  * ssize_t lynxfb_ops_write(struct fb_info *info, const char __user *buf,
@@ -40,7 +39,6 @@ typedef void (*PROC_SPEC_SETUP)(struct lynx_share*, char *);
 typedef int (*PROC_SPEC_MAP)(struct lynx_share*, struct pci_dev*);
 typedef int (*PROC_SPEC_INITHW)(struct lynx_share*, struct pci_dev*);
 
-
 /* common var for all device */
 static int g_hwcursor = 1;
 static int g_noaccel;
@@ -51,7 +49,6 @@ static char *g_settings;
 static int g_dualview;
 static char *g_option;
 
-
 static const struct fb_videomode lynx750_ext[] = {
 	/*	1024x600-60 VESA	[1.71:1] */
 	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
@@ -115,8 +112,6 @@ static const struct fb_videomode lynx750_ext[] = {
 };
 
 
-
-
 /* no hardware cursor supported under version 2.6.10, kernel bug */
 static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 {
@@ -160,7 +155,6 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		cursor->setColor(cursor, fg, bg);
 	}
 
-
 	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
 		cursor->setData(cursor,
 				fbcursor->rop,
@@ -300,7 +294,6 @@ static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
 	struct lynxfb_crtc *crtc;
 	int ret;
 
-
 	if (!info)
 		return -EINVAL;
 
@@ -466,7 +459,6 @@ static int lynxfb_resume(struct pci_dev *pdev)
 
 	int ret;
 
-
 	ret = 0;
 	share = pci_get_drvdata(pdev);
 
@@ -478,7 +470,6 @@ static int lynxfb_resume(struct pci_dev *pdev)
 		return ret;
 	}
 
-
 	if (pdev->dev.power.power_state.event != PM_EVENT_FREEZE) {
 		pci_restore_state(pdev);
 		ret = pci_enable_device(pdev);
@@ -493,7 +484,6 @@ static int lynxfb_resume(struct pci_dev *pdev)
 
 	hw_sm750_inithw(share, pdev);
 
-
 	info = share->fbinfo[0];
 
 	if (info) {
@@ -518,7 +508,6 @@ static int lynxfb_resume(struct pci_dev *pdev)
 		fb_set_suspend(info, 0);
 	}
 
-
 	console_unlock();
 	return ret;
 }
@@ -534,7 +523,6 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	int ret;
 	resource_size_t request;
 
-
 	par = info->par;
 	crtc = &par->crtc;
 	output = &par->output;
@@ -546,7 +534,6 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		 var->yres,
 		 var->bits_per_pixel);
 
-
 	switch (var->bits_per_pixel) {
 	case 8:
 	case 16:
@@ -617,7 +604,6 @@ exit:
 	return ret;
 }
 
-
 static int lynxfb_ops_setcolreg(unsigned regno,
 				unsigned red,
 				unsigned green,
@@ -652,7 +638,6 @@ static int lynxfb_ops_setcolreg(unsigned regno,
 		goto exit;
 	}
 
-
 	if (info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256) {
 		u32 val;
 
@@ -782,7 +767,6 @@ static struct fb_ops lynxfb_ops = {
 	.fb_cursor = lynxfb_ops_cursor,
 };
 
-
 static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 {
 	int i;
@@ -803,7 +787,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-
 	static const char *fixId[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
@@ -824,7 +807,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	sm750fb_set_drv(par);
 	lynxfb_ops.fb_pan_display = lynxfb_ops_pan_display;
 
-
 	/* set current cursor variable and proc pointer,
 	 * must be set after crtc member initialized */
 	crtc->cursor.offset = crtc->oScreen + crtc->vidmem_size - 1024;
@@ -841,7 +823,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	crtc->cursor.setData = hw_cursor_setData;
 	crtc->cursor.vstart = share->pvMem + crtc->cursor.offset;
 
-
 	crtc->cursor.share = share;
 		memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor) {
@@ -849,7 +830,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		crtc->cursor.disable(&crtc->cursor);
 	}
 
-
 	/* set info->fbops, must be set before fb_find_mode */
 	if (!share->accel_off) {
 		/* use 2d acceleration */
@@ -865,7 +845,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 			g_fbmode[index] = g_fbmode[0];
 	}
 
-
 	for (i = 0; i < 3; i++) {
 
 		ret = fb_find_mode(var, info, g_fbmode[index],
@@ -935,7 +914,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	strlcpy(fix->id, fixId[index], sizeof(fix->id));
 
-
 	fix->smem_start = crtc->oScreen + share->vidmem_start;
 	pr_info("fix->smem_start = %lx\n", fix->smem_start);
 	/* according to mmap experiment from user space application,
@@ -998,7 +976,6 @@ static void sm750fb_setup(struct lynx_share *share, char *src)
 #endif
 	int swap;
 
-
 	spec_share = container_of(share, struct sm750_share, share);
 #ifdef CAP_EXPENSIION
 	exp_res = NULL;
@@ -1096,7 +1073,6 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	size_t spec_offset = 0;
 	int fbidx;
 
-
 	/* enable device */
 	if (pci_enable_device(pdev)) {
 		pr_err("can not enable device.\n");
@@ -1268,7 +1244,6 @@ static int __init lynxfb_setup(char *options)
 	int len;
 	char *opt, *tmp;
 
-
 	if (!options || !*options) {
 		pr_warn("no options.\n");
 		return 0;
@@ -1332,7 +1307,6 @@ static struct pci_driver lynxfb_driver = {
 #endif
 };
 
-
 static int __init lynxfb_init(void)
 {
 	char *option;
-- 
1.9.1

