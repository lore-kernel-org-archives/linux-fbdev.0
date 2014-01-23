From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 23 Jan 2014 19:40:28 +0000
Subject: [PATCH 5/10] atyfb: remove resolution limit 1600
Message-Id: <alpine.LRH.2.02.1401231440040.7971@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The card works fine in 1980x1080 resolution. Therefore, there is no need
to limit the resolution to 1600 pixels.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/aty/atyfb_base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-3.11-rc7-fast/drivers/video/aty/atyfb_base.c
=================================--- linux-3.11-rc7-fast.orig/drivers/video/aty/atyfb_base.c	2013-09-02 18:50:52.000000000 +0200
+++ linux-3.11-rc7-fast/drivers/video/aty/atyfb_base.c	2013-09-02 18:50:58.000000000 +0200
@@ -862,8 +862,8 @@ static int aty_var_to_crtc(const struct 
 	h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
 	v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
 
-	if ((xres > 1600) || (yres > 1200)) {
-		FAIL("MACH64 chips are designed for max 1600x1200\n"
+	if ((xres > 1920) || (yres > 1200)) {
+		FAIL("MACH64 chips are designed for max 1920x1200\n"
 		     "select another resolution.");
 	}
 	h_sync_strt = h_disp + var->right_margin;

