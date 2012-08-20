From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Date: Mon, 20 Aug 2012 18:06:18 +0000
Subject: [PATCH 2/7] aty: remove mode restriction
Message-Id: <alpine.DEB.2.00.1208202005440.4009@artax.karlin.mff.cuni.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

aty: remove mode restriction

The mach64 video card works fine in 1920x1080 resolution,
there's no need to limit it.

Signed-off-by: Mikulas Patocka <mpatocka@artax.karlin.mff.cuni.cz>

---
 drivers/video/aty/atyfb_base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-3.6-rc2-fast/drivers/video/aty/atyfb_base.c
=================================--- linux-3.6-rc2-fast.orig/drivers/video/aty/atyfb_base.c	2012-08-18 04:07:55.000000000 +0200
+++ linux-3.6-rc2-fast/drivers/video/aty/atyfb_base.c	2012-08-18 04:09:09.000000000 +0200
@@ -861,8 +861,8 @@ static int aty_var_to_crtc(const struct 
 	h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
 	v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
 
-	if ((xres > 1600) || (yres > 1200)) {
-		FAIL("MACH64 chips are designed for max 1600x1200\n"
+	if ((xres > 1920) || (yres > 1200)) {
+		FAIL("MACH64 chips are designed for max 1920x1200\n"
 		     "select another resolution.");
 	}
 	h_sync_strt = h_disp + var->right_margin;

