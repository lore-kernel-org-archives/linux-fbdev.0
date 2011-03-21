From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 21 Mar 2011 22:46:39 +0000
Subject: [PATCH 2/2] viafb: initialize margins correct
Message-Id: <1300748487-9883-3-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300748487-9883-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1300748487-9883-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This patch initializes the margins for the initial mode correct.
This is required to get the desired initial refresh rate. Also do
more verbose sanity checking to prevent misbehavior.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/viafbdev.c |   31 +++++++++++--------------------
 1 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index fd6a15f..9d9bb9b 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1806,14 +1806,9 @@ int __devinit via_fb_pci_probe(struct viafb_dev *vdev)
 	default_var.xres_virtual = default_xres;
 	default_var.yres_virtual = default_yres;
 	default_var.bits_per_pixel = viafb_bpp;
-	default_var.pixclock -	    viafb_get_pixclock(default_xres, default_yres, viafb_refresh);
-	default_var.left_margin = (default_xres >> 3) & 0xf8;
-	default_var.right_margin = 32;
-	default_var.upper_margin = 16;
-	default_var.lower_margin = 4;
-	default_var.hsync_len = default_var.left_margin;
-	default_var.vsync_len = 4;
+	viafb_fill_var_timing_info(&default_var, viafb_get_refresh(
+		default_var.xres, default_var.yres, viafb_refresh),
+		viafb_get_mode(default_var.xres, default_var.yres));
 	viafb_setup_fixinfo(&viafbinfo->fix, viaparinfo);
 	viafbinfo->var = default_var;
 
@@ -1852,15 +1847,9 @@ int __devinit via_fb_pci_probe(struct viafb_dev *vdev)
 		default_var.xres_virtual = viafb_second_virtual_xres;
 		default_var.yres_virtual = viafb_second_virtual_yres;
 		default_var.bits_per_pixel = viafb_bpp1;
-		default_var.pixclock -		    viafb_get_pixclock(viafb_second_xres, viafb_second_yres,
-		    viafb_refresh1);
-		default_var.left_margin = (viafb_second_xres >> 3) & 0xf8;
-		default_var.right_margin = 32;
-		default_var.upper_margin = 16;
-		default_var.lower_margin = 4;
-		default_var.hsync_len = default_var.left_margin;
-		default_var.vsync_len = 4;
+		viafb_fill_var_timing_info(&default_var, viafb_get_refresh(
+			default_var.xres, default_var.yres, viafb_refresh1),
+			viafb_get_mode(default_var.xres, default_var.yres));
 
 		viafb_setup_fixinfo(&viafbinfo1->fix, viaparinfo1);
 		viafb_check_var(&default_var, viafbinfo1);
@@ -2015,15 +2004,17 @@ static int __init viafb_setup(char *options)
  */
 int __init viafb_init(void)
 {
-	u32 dummy;
+	u32 dummy_x, dummy_y;
 #ifndef MODULE
 	char *option = NULL;
 	if (fb_get_options("viafb", &option))
 		return -ENODEV;
 	viafb_setup(option);
 #endif
-	if (parse_mode(viafb_mode, &dummy, &dummy)
-		|| parse_mode(viafb_mode1, &dummy, &dummy)
+	if (parse_mode(viafb_mode, &dummy_x, &dummy_y)
+		|| !viafb_get_mode(dummy_x, dummy_y)
+		|| parse_mode(viafb_mode1, &dummy_x, &dummy_y)
+		|| !viafb_get_mode(dummy_x, dummy_y)
 		|| viafb_bpp < 0 || viafb_bpp > 32
 		|| viafb_bpp1 < 0 || viafb_bpp1 > 32
 		|| parse_active_dev())
-- 
1.6.3.2

