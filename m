From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] radeonfb: Misc cleanup of engine
	and dst cache handling
Date: Mon, 11 Aug 2008 10:33:47 +1000
Message-ID: <20080811003410.4A683DDE00@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSLMW-0005A3-2i for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 17:34:19 -0700
Received: from ozlabs.org ([203.10.76.45])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KSLMV-0002SY-3Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 17:34:15 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: davem@davemloft.net

This patch fixes a couple of incomplete tests of the chip
families in the engine init/reset code and proper
initialization of the destination cache mode. The result
should better match what the latest X radeon driver does.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/video/aty/radeon_accel.c |   22 +++++++++++++---------
 drivers/video/aty/radeon_base.c  |   13 +++++--------
 drivers/video/aty/radeonfb.h     |   33 ++++++++++++++++++++-------------
 include/video/radeon.h           |    5 ++++-
 4 files changed, 42 insertions(+), 31 deletions(-)

--- linux-work.orig/drivers/video/aty/radeon_accel.c	2008-08-08 09:56:03.000000000 +1000
+++ linux-work/drivers/video/aty/radeon_accel.c	2008-08-08 09:56:40.000000000 +1000
@@ -211,9 +222,7 @@ void radeonfb_engine_reset(struct radeon
 	host_path_cntl = INREG(HOST_PATH_CNTL);
 	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
 
-	if (rinfo->family == CHIP_FAMILY_R300 ||
-	    rinfo->family == CHIP_FAMILY_R350 ||
-	    rinfo->family == CHIP_FAMILY_RV350) {
+	if (IS_R300_VARIANT(rinfo)) {
 		u32 tmp;
 
 		OUTREG(RBBM_SOFT_RESET, (rbbm_soft_reset |
@@ -249,9 +258,7 @@ void radeonfb_engine_reset(struct radeon
 	INREG(HOST_PATH_CNTL);
 	OUTREG(HOST_PATH_CNTL, host_path_cntl);
 
-	if (rinfo->family != CHIP_FAMILY_R300 &&
-	    rinfo->family != CHIP_FAMILY_R350 &&
-	    rinfo->family != CHIP_FAMILY_RV350)
+	if (!IS_R300_VARIANT(rinfo))
 		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
 
 	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
@@ -268,10 +275,18 @@ void radeonfb_engine_init (struct radeon
 	radeonfb_engine_reset(rinfo);
 
 	radeon_fifo_wait (1);
-	if ((rinfo->family != CHIP_FAMILY_R300) &&
-	    (rinfo->family != CHIP_FAMILY_R350) &&
-	    (rinfo->family != CHIP_FAMILY_RV350))
+	if (IS_R300_VARIANT(rinfo)) {
+		OUTREG(RB2D_DSTCACHE_MODE, INREG(RB2D_DSTCACHE_MODE) |
+		       RB2D_DC_AUTOFLUSH_ENABLE |
+		       RB2D_DC_DC_DISABLE_IGNORE_PE);
+	} else {
+		/* This needs to be double checked with ATI. Latest X driver
+		 * completely "forgets" to set this register on < r3xx, and
+		 * we used to just write 0 there... I'll keep the 0 and update
+		 * that when we have sorted things out on X side.
+		 */
 		OUTREG(RB2D_DSTCACHE_MODE, 0);
+	}
 
 	radeon_fifo_wait (3);
 	/* We re-read MC_FB_LOCATION from card as it can have been
Index: linux-work/include/video/radeon.h
===================================================================
--- linux-work.orig/include/video/radeon.h	2008-08-08 09:56:03.000000000 +1000
+++ linux-work/include/video/radeon.h	2008-08-08 09:56:14.000000000 +1000
@@ -386,7 +386,7 @@
 #define SC_BOTTOM_RIGHT                        0x16F0  
 #define SRC_SC_BOTTOM_RIGHT                    0x16F4  
 #define RB2D_DSTCACHE_MODE		       0x3428
-#define RB2D_DSTCACHE_CTLSTAT		       0x342C
+#define RB2D_DSTCACHE_CTLSTAT_broken	       0x342C /* do not use */
 #define LVDS_GEN_CNTL			       0x02d0
 #define LVDS_PLL_CNTL			       0x02d4
 #define FP2_GEN_CNTL                           0x0288
@@ -532,6 +532,9 @@
 #define RB2D_DC_FLUSH_ALL			   (RB2D_DC_FLUSH_2D | RB2D_DC_FREE_2D)
 #define RB2D_DC_BUSY				   (1 << 31)
 
+/* DSTCACHE_MODE bits constants */
+#define RB2D_DC_AUTOFLUSH_ENABLE                   (1 << 8)
+#define RB2D_DC_DC_DISABLE_IGNORE_PE               (1 << 17)
 
 /* CRTC_GEN_CNTL bit constants */
 #define CRTC_DBL_SCAN_EN                           0x00000001
Index: linux-work/drivers/video/aty/radeonfb.h
===================================================================
--- linux-work.orig/drivers/video/aty/radeonfb.h	2008-08-08 09:56:03.000000000 +1000
+++ linux-work/drivers/video/aty/radeonfb.h	2008-08-08 09:56:14.000000000 +1000
@@ -53,6 +53,7 @@ enum radeon_family {
 	CHIP_FAMILY_RV380,    /* RV370/RV380/M22/M24 */
 	CHIP_FAMILY_R420,     /* R420/R423/M18 */
 	CHIP_FAMILY_RC410,
+	CHIP_FAMILY_RS400,
 	CHIP_FAMILY_RS480,
 	CHIP_FAMILY_LAST,
 };
@@ -533,33 +534,39 @@ static inline u32 radeon_get_dstbpp(u16 
 /*
  * 2D Engine helper routines
  */
-static inline void radeon_engine_flush (struct radeonfb_info *rinfo)
+
+static inline void _radeon_fifo_wait(struct radeonfb_info *rinfo, int entries)
 {
 	int i;
 
-	/* initiate flush */
-	OUTREGP(RB2D_DSTCACHE_CTLSTAT, RB2D_DC_FLUSH_ALL,
-	        ~RB2D_DC_FLUSH_ALL);
-
-	for (i=0; i < 2000000; i++) {
-		if (!(INREG(RB2D_DSTCACHE_CTLSTAT) & RB2D_DC_BUSY))
+	for (i=0; i<2000000; i++) {
+		if ((INREG(RBBM_STATUS) & 0x7f) >= entries)
 			return;
 		udelay(1);
 	}
-	printk(KERN_ERR "radeonfb: Flush Timeout !\n");
+	printk(KERN_ERR "radeonfb: FIFO Timeout !\n");
 }
 
-
-static inline void _radeon_fifo_wait(struct radeonfb_info *rinfo, int entries)
+static inline void radeon_engine_flush (struct radeonfb_info *rinfo)
 {
 	int i;
 
-	for (i=0; i<2000000; i++) {
-		if ((INREG(RBBM_STATUS) & 0x7f) >= entries)
+	/* Initiate flush */
+	OUTREGP(DSTCACHE_CTLSTAT, RB2D_DC_FLUSH_ALL,
+	        ~RB2D_DC_FLUSH_ALL);
+
+	/* Ensure FIFO is empty, ie, make sure the flush commands
+	 * has reached the cache
+	 */
+	_radeon_fifo_wait (rinfo, 64);
+
+	/* Wait for the flush to complete */
+	for (i=0; i < 2000000; i++) {
+		if (!(INREG(DSTCACHE_CTLSTAT) & RB2D_DC_BUSY))
 			return;
 		udelay(1);
 	}
-	printk(KERN_ERR "radeonfb: FIFO Timeout !\n");
+	printk(KERN_ERR "radeonfb: Flush Timeout !\n");
 }
 
 
Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2008-08-08 09:56:03.000000000 +1000
+++ linux-work/drivers/video/aty/radeon_base.c	2008-08-08 09:56:14.000000000 +1000
@@ -1286,11 +1286,10 @@ static void radeon_write_pll_regs(struct
 	radeon_pll_errata_after_data(rinfo);
 
 	/* Set PPLL ref. div */
-	if (rinfo->family == CHIP_FAMILY_R300 ||
+	if (IS_R300_VARIANT(rinfo) ||
 	    rinfo->family == CHIP_FAMILY_RS300 ||
-	    rinfo->family == CHIP_FAMILY_R350 ||
-	    rinfo->family == CHIP_FAMILY_RV350 ||
-	    rinfo->family == CHIP_FAMILY_RV380 ) {
+	    rinfo->family == CHIP_FAMILY_RS400 ||
+	    rinfo->family == CHIP_FAMILY_RS480) {
 		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {
 			/* When restoring console mode, use saved PPLL_REF_DIV
 			 * setting.
@@ -1461,10 +1460,7 @@ static void radeon_calc_pll_regs(struct 
 		/* Not all chip revs have the same format for this register,
 		 * extract the source selection
 		 */
-		if (rinfo->family == CHIP_FAMILY_R200 ||
-		    rinfo->family == CHIP_FAMILY_R300 ||
-		    rinfo->family == CHIP_FAMILY_R350 ||
-		    rinfo->family == CHIP_FAMILY_RV350) {
+		if (rinfo->family == CHIP_FAMILY_R200 || IS_R300_VARIANT(rinfo)) {
 			source = (fp2_gen_cntl >> 10) & 0x3;
 			/* sourced from transform unit, check for transform unit
 			 * own source
@@ -2005,6 +2001,7 @@ static void radeon_identify_vram(struct 
             (rinfo->family == CHIP_FAMILY_RS200) ||
             (rinfo->family == CHIP_FAMILY_RS300) ||
             (rinfo->family == CHIP_FAMILY_RC410) ||
+            (rinfo->family == CHIP_FAMILY_RS400) ||
 	    (rinfo->family == CHIP_FAMILY_RS480) ) {
           u32 tom = INREG(NB_TOM);
           tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
