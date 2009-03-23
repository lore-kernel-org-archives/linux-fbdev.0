From: Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] tdfxfb: make use of DDC information about connected
 monitor
Date: Mon, 23 Mar 2009 19:26:46 +0100
Message-ID: <20090323192646.da98a636.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

From: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>

Read DDC information from a connected monitor
and use it to select initial mode (if the mode
is not specified).
Also, use the information to protect against
modes outside the monitor specs.

Signed-off-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
---
 drivers/video/tdfxfb.c |   67 +++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index be40506..d48bcab 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -487,6 +487,12 @@ static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		return -EINVAL;
 	}
 
+	if (info->monspecs.hfmax && info->monspecs.vfmax &&
+	    info->monspecs.dclkmax && fb_validate_mode(var, info) < 0) {
+		DPRINTK("mode outside monitor's specs\n");
+		return -EINVAL;
+	}
+
 	var->xres = (var->xres + 15) & ~15; /* could sometimes be 8 */
 	lpitch = var->xres * ((var->bits_per_pixel + 7) >> 3);
 
@@ -1355,6 +1361,23 @@ static void tdfxfb_delete_i2c_busses(struct tdfx_par *par)
 		i2c_del_adapter(&par->chan[1].adapter);
 	par->chan[1].par = NULL;
 }
+
+static int tdfxfb_probe_i2c_connector(struct tdfx_par *par,
+				      struct fb_monspecs *specs)
+{
+	u8 *edid = NULL;
+
+	DPRINTK("Probe DDC Bus\n");
+	if (par->chan[0].par)
+		edid = fb_ddc_read(&par->chan[0].adapter);
+
+	if (edid) {
+		fb_edid_to_monspecs(edid, specs);
+		kfree(edid);
+		return 0;
+	}
+	return 1;
+}
 #endif /* CONFIG_FB_3DFX_I2C */
 
 /**
@@ -1372,6 +1395,8 @@ static int __devinit tdfxfb_probe(struct pci_dev *pdev,
 	struct tdfx_par *default_par;
 	struct fb_info *info;
 	int err, lpitch;
+	struct fb_monspecs *specs;
+	bool found;
 
 	err = pci_enable_device(pdev);
 	if (err) {
@@ -1474,15 +1499,49 @@ static int __devinit tdfxfb_probe(struct pci_dev *pdev,
 	if (hwcursor)
 		info->fix.smem_len = (info->fix.smem_len - 1024) &
 					(PAGE_MASK << 1);
+	specs = &info->monspecs;
+	found = false;
+	info->var.bits_per_pixel = 8;
 #ifdef CONFIG_FB_3DFX_I2C
 	tdfxfb_create_i2c_busses(info);
+	err = tdfxfb_probe_i2c_connector(default_par, specs);
+
+	if (!err) {
+		if (specs->modedb == NULL)
+			DPRINTK("Unable to get Mode Database\n");
+		else {
+			const struct fb_videomode *m;
+
+			fb_videomode_to_modelist(specs->modedb,
+						 specs->modedb_len,
+						 &info->modelist);
+			m = fb_find_best_display(specs, &info->modelist);
+			if (m) {
+				fb_videomode_to_var(&info->var, m);
+				/* fill all other info->var's fields */
+				if (tdfxfb_check_var(&info->var, info) < 0)
+					info->var = tdfx_var;
+				else
+					found = true;
+			}
+		}
+	}
 #endif
-	if (!mode_option)
+	if (!mode_option && !found)
 		mode_option = "640x480@60";
 
-	err = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL, 8);
-	if (!err || err == 4)
-		info->var = tdfx_var;
+	if (mode_option) {
+		err = fb_find_mode(&info->var, info, mode_option,
+				   specs->modedb, specs->modedb_len,
+				   NULL, info->var.bits_per_pixel);
+		if (!err || err == 4)
+			info->var = tdfx_var;
+	}
+
+	if (found) {
+		fb_destroy_modedb(specs->modedb);
+		specs->modedb = NULL;
+	}
 
 	/* maximize virtual vertical length */
 	lpitch = info->var.xres_virtual * ((info->var.bits_per_pixel + 7) >> 3);
-- 
1.5.2.2


----------------------------------------------------------------------
10% zysku na lokacie bankowej z gwarancja BFG. Sprawdz!
http://clk.tradedoubler.com/click?p=74281&a=1586724&g=17879004
