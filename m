From: Tormod Volden <lists.tormod@gmail.com>
Date: Sat, 28 May 2011 15:06:11 +0000
Subject: [PATCH] savagefb: Use panel CVT mode as default
Message-Id: <1306595171-18633-1-git-send-email-lists.tormod@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Tormod Volden <debian.tormod@gmail.com>

If there is no EDID but an LCD panel is detected, generate a CVT
mode from the panel resolution (at 60 Hz), and use this as a
default mode instead of the hardcoded 800x600x8 mode.

Signed-off-by: Tormod Volden <debian.tormod@gmail.com>

---

This is maybe tight for 2.6.40, however this is long-standing
issue on savage-equipped laptops: The framebuffer would
default to an antiquated resolution of 800x600 instead of
using the LCD panel native mode (if there is no EDID).

The logic was inspired by the xorg DDX, which also feeds the
panel resolution (and 60 Hz) to a CVT function to get a mode
in this case.

I had to export fb_find_mode_cvt() from modedb.c for this. The
alternative would be to build up a string similar to the
mode_option given by the user and pass this to fb_find_mode
but that seems awkward.

Any suggestions or comments on this?

I searched a number of other drivers to see if they do something
similar, but I could not find any good match.

Regards,
Tormod


 drivers/video/modedb.c                 |    1 +
 drivers/video/savage/savagefb_driver.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 48c3ea8..cb175fe 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -1128,3 +1128,4 @@ EXPORT_SYMBOL(fb_find_best_mode);
 EXPORT_SYMBOL(fb_find_nearest_mode);
 EXPORT_SYMBOL(fb_videomode_to_modelist);
 EXPORT_SYMBOL(fb_find_mode);
+EXPORT_SYMBOL(fb_find_mode_cvt);
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 9f172fa..eddca61 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2243,6 +2243,22 @@ static int __devinit savagefb_probe(struct pci_dev* dev,
 				 &info->modelist);
 #endif
 	info->var = savagefb_var800x600x8;
+	/* if a panel was detected, default to a CVT mode instead */
+	if (par->SavagePanelWidth) {
+		struct fb_videomode cvt_mode;
+
+		memset(&cvt_mode, 0, sizeof(cvt_mode));
+		cvt_mode.xres = par->SavagePanelWidth;
+		cvt_mode.yres = par->SavagePanelHeight;
+		cvt_mode.refresh = 60;
+		/* FIXME: if we know there is only the panel
+		 * we can enable reduced blanking as well */
+		if (fb_find_mode_cvt(&cvt_mode, 0, 0))
+			printk(KERN_WARNING "No CVT mode found for panel\n");
+		else if (fb_find_mode(&info->var, info, NULL, NULL, 0,
+				      &cvt_mode, 0) != 3)
+			info->var = savagefb_var800x600x8;
+	}
 
 	if (mode_option) {
 		fb_find_mode(&info->var, info, mode_option,
-- 
1.7.0.4

