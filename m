From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sat, 25 Aug 2018 19:54:17 +0000
Subject: [PATCH 3/3] mach64: optimize wait_for_fifo
Message-Id: <alpine.LRH.2.02.1808251551570.8284@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

This is a simple optimization for fifo waiting that improves scrolling
performance by 5%. If the queue has more free entries that what we
consume, we can skip the costly register read next time.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/fbdev/aty/atyfb.h        |   12 ++++++++----
 drivers/video/fbdev/aty/mach64_accel.c |    4 +++-
 2 files changed, 11 insertions(+), 5 deletions(-)

Index: linux-stable/drivers/video/fbdev/aty/atyfb.h
=================================--- linux-stable.orig/drivers/video/fbdev/aty/atyfb.h	2018-08-25 21:49:16.000000000 +0200
+++ linux-stable/drivers/video/fbdev/aty/atyfb.h	2018-08-25 21:52:51.000000000 +0200
@@ -147,6 +147,7 @@ struct atyfb_par {
 	u16 pci_id;
 	u32 accel_flags;
 	int blitter_may_be_busy;
+	unsigned fifo_space;
 	int asleep;
 	int lock_blank;
 	unsigned long res_start;
@@ -346,10 +347,13 @@ extern int aty_init_cursor(struct fb_inf
      *  Hardware acceleration
      */
 
-static inline void wait_for_fifo(u16 entries, const struct atyfb_par *par)
+static inline void wait_for_fifo(u16 entries, struct atyfb_par *par)
 {
-	while ((aty_ld_le32(FIFO_STAT, par) & 0xffff) >
-	       ((u32) (0x8000 >> entries)));
+	unsigned fifo_space = par->fifo_space;
+	while (entries > fifo_space) {
+		fifo_space = 16 - fls(aty_ld_le32(FIFO_STAT, par) & 0xffff);
+	}
+	par->fifo_space = fifo_space - entries;
 }
 
 static inline void wait_for_idle(struct atyfb_par *par)
@@ -359,7 +363,7 @@ static inline void wait_for_idle(struct
 	par->blitter_may_be_busy = 0;
 }
 
-extern void aty_reset_engine(const struct atyfb_par *par);
+extern void aty_reset_engine(struct atyfb_par *par);
 extern void aty_init_engine(struct atyfb_par *par, struct fb_info *info);
 
 void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
Index: linux-stable/drivers/video/fbdev/aty/mach64_accel.c
=================================--- linux-stable.orig/drivers/video/fbdev/aty/mach64_accel.c	2018-08-25 21:49:16.000000000 +0200
+++ linux-stable/drivers/video/fbdev/aty/mach64_accel.c	2018-08-25 21:49:16.000000000 +0200
@@ -37,7 +37,7 @@ static u32 rotation24bpp(u32 dx, u32 dir
 	return ((rotation << 8) | DST_24_ROTATION_ENABLE);
 }
 
-void aty_reset_engine(const struct atyfb_par *par)
+void aty_reset_engine(struct atyfb_par *par)
 {
 	/* reset engine */
 	aty_st_le32(GEN_TEST_CNTL,
@@ -50,6 +50,8 @@ void aty_reset_engine(const struct atyfb
 	/* HOST errors */
 	aty_st_le32(BUS_CNTL,
 		aty_ld_le32(BUS_CNTL, par) | BUS_HOST_ERR_ACK | BUS_FIFO_ERR_ACK, par);
+
+	par->fifo_space = 0;
 }
 
 static void reset_GTC_3D_engine(const struct atyfb_par *par)
