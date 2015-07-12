From: Vinay Simha BN <simhavcs@gmail.com>
Date: Sun, 12 Jul 2015 18:30:59 +0000
Subject: [PATCH] Const-qualify, WARNING, out-of memory usage fixes
Message-Id: <1436725139-32636-1-git-send-email-simhavcs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 53 +++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 6b642d7..f378843 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -24,7 +24,7 @@
 
 #include "modedb.h"
 
-int smi_indent = 0;
+int smi_indent;
 
 
 /*
@@ -45,11 +45,11 @@ typedef int (*PROC_SPEC_INITHW)(struct lynx_share*, struct pci_dev*);
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
-static const char *g_def_fbmode = "800x600-16@60";
-static char *g_settings = NULL;
+static const char *const g_fbmode[] = {NULL, NULL};
+static const char *const g_def_fbmode = "800x600-16@60";
+static char *g_settings;
 static int g_dualview;
-static char *g_option = NULL;
+static char *g_option;
 
 
 static const struct fb_videomode lynx750_ext[] = {
@@ -150,12 +150,16 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		u16 fg, bg;
 
 		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800))|
-		      ((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5)|
-		      ((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
+		      ((info->cmap.green[fbcursor->image.fg_color]
+			 & 0xfc00) >> 5)|
+		      ((info->cmap.blue[fbcursor->image.fg_color]
+			& 0xf800) >> 11);
 
 		bg = ((info->cmap.red[fbcursor->image.bg_color] & 0xf800))|
-		      ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5)|
-		      ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
+		      ((info->cmap.green[fbcursor->image.bg_color] &
+			0xfc00) >> 5)|
+		      ((info->cmap.blue[fbcursor->image.bg_color] &
+			0xf800) >> 11);
 
 		cursor->setColor(cursor, fg, bg);
 	}
@@ -194,7 +198,8 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
-	color = (Bpp = 1)?region->color:((u32 *)info->pseudo_palette)[region->color];
+	color = (Bpp = 1) ?
+	region->color : ((u32 *)info->pseudo_palette)[region->color];
 	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR:HW_ROP2_COPY;
 
 	/*
@@ -445,7 +450,8 @@ static int lynxfb_suspend(struct pci_dev *pdev, pm_message_t mesg)
 		pci_disable_device(pdev);
 		ret = pci_set_power_state(pdev, pci_choose_state(pdev, mesg));
 		if (ret) {
-			pr_err("error:%d occurred in pci_set_power_state\n", ret);
+			pr_err("error:%d occurred in
+				pci_set_power_state\n", ret);
 			return ret;
 		}
 	}
@@ -699,7 +705,8 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	output = &par->output;
 	crtc = &par->crtc;
 
-	crtc->vidmem_size = (share->dual)?share->vidmem_size>>1:share->vidmem_size;
+	crtc->vidmem_size = (share->dual) ?
+		share->vidmem_size>>1 : share->vidmem_size;
 	/* setup crtc and output member */
 	spec_share->hwCursor = g_hwcursor;
 
@@ -716,10 +723,12 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	output->proc_setMode = hw_sm750_output_setMode;
 	output->proc_checkMode = hw_sm750_output_checkMode;
 
-	output->proc_setBLANK = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_setBLANK:hw_sm750_setBLANK;
+	output->proc_setBLANK = (share->revid = SM750LE_REVISION_ID) ?
+				hw_sm750le_setBLANK : hw_sm750_setBLANK;
 	output->clear = hw_sm750_output_clear;
 	/* chip specific phase */
-	share->accel.de_wait = (share->revid = SM750LE_REVISION_ID)?hw_sm750le_deWait : hw_sm750_deWait;
+	share->accel.de_wait = (share->revid = SM750LE_REVISION_ID) ?
+				hw_sm750le_deWait : hw_sm750_deWait;
 	switch (spec_share->state.dataflow) {
 	case sm750_simul_pri:
 		output->paths = sm750_pnc;
@@ -743,7 +752,8 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
-			/* not consider of padding stuffs for oScreen,need fix */
+			/* not consider of padding stuffs
+			 for oScreen,need fix */
 			crtc->oScreen = (share->vidmem_size >> 1);
 			crtc->vScreen = share->pvMem + crtc->oScreen;
 		}
@@ -757,7 +767,8 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
-			/* not consider of padding stuffs for oScreen,need fix */
+			/* not consider of padding stuffs
+			for oScreen,need fix */
 			crtc->oScreen = (share->vidmem_size >> 1);
 			crtc->vScreen = share->pvMem + crtc->oScreen;
 		}
@@ -797,7 +808,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		lynx750_ext, NULL, vesa_modes,
 	};
 	int cdb[] = {ARRAY_SIZE(lynx750_ext), 0, VESA_MODEDB_SIZE};
-	static const char *mdb_desc[] = {
+	static const char *const mdb_desc[] = {
 		"driver prepared modes",
 		"kernel prepared default modedb",
 		"kernel HELPERS prepared vesa_modes",
@@ -895,7 +906,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	/* some member of info->var had been set by fb_find_mode */
 
-	pr_info("Member of info->var is :\n\
+	pr_info("Member of info->var is :\n
 		xres=%d\n\
 		yres=%d\n\
 		xres_virtual=%d\n\
@@ -967,7 +978,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	var->accel_flags = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
-	pr_debug("#1 show info->cmap : \nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
+	pr_debug("#1 show info->cmap :\nstart=%d,len=%d,red=%p,green=%p,blue=%p,transp=%p\n",
 		 info->cmap.start, info->cmap.len,
 		 info->cmap.red, info->cmap.green, info->cmap.blue,
 		 info->cmap.transp);
@@ -1087,7 +1098,7 @@ NO_PARAM:
 }
 
 static int lynxfb_pci_probe(struct pci_dev *pdev,
-			    const struct pci_device_id * ent)
+			    const struct pci_device_id *ent)
 {
 	struct fb_info *info[] = {NULL, NULL};
 	struct lynx_share *share = NULL;
@@ -1109,7 +1120,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 
 	spec_share = kzalloc(sizeof(*spec_share), GFP_KERNEL);
 	if (!spec_share) {
-		pr_err("Could not allocate memory for share.\n");
+		/*pr_err("Could not allocate memory for share.\n");*/
 		goto err_share;
 	}
 
-- 
2.1.2

