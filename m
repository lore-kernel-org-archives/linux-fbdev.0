From: Denys Vlasenko <dvlasenk@redhat.com>
Date: Mon, 18 May 2015 14:25:26 +0000
Subject: [PATCH] radeonfb: Deinline large functions
Message-Id: <1431959126-4318-1-git-send-email-dvlasenk@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Richard Purdie <rpurdie@rpsys.net>, Chris Wilson <chris@chris-wilson.co.uk>, David Airlie <airlied@linux.ie>, Alex Deucher <alexdeucher@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

With this .config: http://busybox.net/~vda/kernel_config,
after uninlining these functions have sizes and callsite counts
as follows:

__OUTPLLP: 61 bytes, 12 callsites
__INPLL:   79 bytes, 150 callsites
__OUTPLL:  82 bytes, 138 callsites
_OUTREGP: 101 bytes, 8 callsites
_radeon_msleep:      66 bytes, 18 callsites
_radeon_fifo_wait:   83 bytes, 24 callsites
_radeon_engine_idle: 92 bytes, 10 callsites
radeon_engine_flush: 105 bytes, 2 callsites
radeon_pll_errata_after_index_slow: 31 bytes, 11 callsites
radeon_pll_errata_after_data_slow:  91 bytes, 9 callsites

radeon_pll_errata_after_FOO functions are split into two parts:
the inlined part which checks corresponding rinfo->errata bit,
and out-of-line part which performs workaround magic per se.

Reduction in code size is about 49,500 bytes:

    text     data      bss       dec     hex filename
85789648 22294616 20627456 128711720 7abfc28 vmlinux.before
85740176 22294680 20627456 128662312 7ab3b28 vmlinux

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: David Airlie <airlied@linux.ie>
Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Dave Airlie <airlied@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/aty/radeon_base.c | 133 ++++++++++++++++++++++++++++++-
 drivers/video/fbdev/aty/radeonfb.h    | 144 ++++------------------------------
 2 files changed, 146 insertions(+), 131 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 26d80a4..bd9b6ca 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -282,9 +282,138 @@ static int backlight = 1;
 static int backlight = 0;
 #endif
 
-/*
- * prototypes
+/* Note about this function: we have some rare cases where we must not schedule,
+ * this typically happen with our special "wake up early" hook which allows us to
+ * wake up the graphic chip (and thus get the console back) before everything else
+ * on some machines that support that mechanism. At this point, interrupts are off
+ * and scheduling is not permitted
  */
+void _radeon_msleep(struct radeonfb_info *rinfo, unsigned long ms)
+{
+	if (rinfo->no_schedule || oops_in_progress)
+		mdelay(ms);
+	else
+		msleep(ms);
+}
+
+void radeon_pll_errata_after_index_slow(struct radeonfb_info *rinfo)
+{
+	/* Called if (rinfo->errata & CHIP_ERRATA_PLL_DUMMYREADS) is set */
+	(void)INREG(CLOCK_CNTL_DATA);
+	(void)INREG(CRTC_GEN_CNTL);
+}
+
+void radeon_pll_errata_after_data_slow(struct radeonfb_info *rinfo)
+{
+	if (rinfo->errata & CHIP_ERRATA_PLL_DELAY) {
+		/* we can't deal with posted writes here ... */
+		_radeon_msleep(rinfo, 5);
+	}
+	if (rinfo->errata & CHIP_ERRATA_R300_CG) {
+		u32 save, tmp;
+		save = INREG(CLOCK_CNTL_INDEX);
+		tmp = save & ~(0x3f | PLL_WR_EN);
+		OUTREG(CLOCK_CNTL_INDEX, tmp);
+		tmp = INREG(CLOCK_CNTL_DATA);
+		OUTREG(CLOCK_CNTL_INDEX, save);
+	}
+}
+
+void _OUTREGP(struct radeonfb_info *rinfo, u32 addr, u32 val, u32 mask)
+{
+	unsigned long flags;
+	unsigned int tmp;
+
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	tmp = INREG(addr);
+	tmp &= (mask);
+	tmp |= (val);
+	OUTREG(addr, tmp);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+u32 __INPLL(struct radeonfb_info *rinfo, u32 addr)
+{
+	u32 data;
+
+	OUTREG8(CLOCK_CNTL_INDEX, addr & 0x0000003f);
+	radeon_pll_errata_after_index(rinfo);
+	data = INREG(CLOCK_CNTL_DATA);
+	radeon_pll_errata_after_data(rinfo);
+	return data;
+}
+
+void __OUTPLL(struct radeonfb_info *rinfo, unsigned int index, u32 val)
+{
+	OUTREG8(CLOCK_CNTL_INDEX, (index & 0x0000003f) | 0x00000080);
+	radeon_pll_errata_after_index(rinfo);
+	OUTREG(CLOCK_CNTL_DATA, val);
+	radeon_pll_errata_after_data(rinfo);
+}
+
+void __OUTPLLP(struct radeonfb_info *rinfo, unsigned int index,
+			     u32 val, u32 mask)
+{
+	unsigned int tmp;
+
+	tmp  = __INPLL(rinfo, index);
+	tmp &= (mask);
+	tmp |= (val);
+	__OUTPLL(rinfo, index, tmp);
+}
+
+void _radeon_fifo_wait(struct radeonfb_info *rinfo, int entries)
+{
+	int i;
+
+	for (i=0; i<2000000; i++) {
+		if ((INREG(RBBM_STATUS) & 0x7f) >= entries)
+			return;
+		udelay(1);
+	}
+	printk(KERN_ERR "radeonfb: FIFO Timeout !\n");
+}
+
+void radeon_engine_flush(struct radeonfb_info *rinfo)
+{
+	int i;
+
+	/* Initiate flush */
+	OUTREGP(DSTCACHE_CTLSTAT, RB2D_DC_FLUSH_ALL,
+	        ~RB2D_DC_FLUSH_ALL);
+
+	/* Ensure FIFO is empty, ie, make sure the flush commands
+	 * has reached the cache
+	 */
+	_radeon_fifo_wait(rinfo, 64);
+
+	/* Wait for the flush to complete */
+	for (i=0; i < 2000000; i++) {
+		if (!(INREG(DSTCACHE_CTLSTAT) & RB2D_DC_BUSY))
+			return;
+		udelay(1);
+	}
+	printk(KERN_ERR "radeonfb: Flush Timeout !\n");
+}
+
+void _radeon_engine_idle(struct radeonfb_info *rinfo)
+{
+	int i;
+
+	/* ensure FIFO is empty before waiting for idle */
+	_radeon_fifo_wait(rinfo, 64);
+
+	for (i=0; i<2000000; i++) {
+		if (((INREG(RBBM_STATUS) & GUI_ACTIVE)) = 0) {
+			radeon_engine_flush(rinfo);
+			return;
+		}
+		udelay(1);
+	}
+	printk(KERN_ERR "radeonfb: Idle Timeout !\n");
+}
+
+
 
 static void radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
 {
diff --git a/drivers/video/fbdev/aty/radeonfb.h b/drivers/video/fbdev/aty/radeonfb.h
index cb84604..85b80cd 100644
--- a/drivers/video/fbdev/aty/radeonfb.h
+++ b/drivers/video/fbdev/aty/radeonfb.h
@@ -370,20 +370,7 @@ struct radeonfb_info {
  * IO macros
  */
 
-/* Note about this function: we have some rare cases where we must not schedule,
- * this typically happen with our special "wake up early" hook which allows us to
- * wake up the graphic chip (and thus get the console back) before everything else
- * on some machines that support that mechanism. At this point, interrupts are off
- * and scheduling is not permitted
- */
-static inline void _radeon_msleep(struct radeonfb_info *rinfo, unsigned long ms)
-{
-	if (rinfo->no_schedule || oops_in_progress)
-		mdelay(ms);
-	else
-		msleep(ms);
-}
-
+void _radeon_msleep(struct radeonfb_info *rinfo, unsigned long ms);
 
 #define INREG8(addr)		readb((rinfo->mmio_base)+addr)
 #define OUTREG8(addr,val)	writeb(val, (rinfo->mmio_base)+addr)
@@ -392,19 +379,7 @@ static inline void _radeon_msleep(struct radeonfb_info *rinfo, unsigned long ms)
 #define INREG(addr)		readl((rinfo->mmio_base)+addr)
 #define OUTREG(addr,val)	writel(val, (rinfo->mmio_base)+addr)
 
-static inline void _OUTREGP(struct radeonfb_info *rinfo, u32 addr,
-		       u32 val, u32 mask)
-{
-	unsigned long flags;
-	unsigned int tmp;
-
-	spin_lock_irqsave(&rinfo->reg_lock, flags);
-	tmp = INREG(addr);
-	tmp &= (mask);
-	tmp |= (val);
-	OUTREG(addr, tmp);
-	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
-}
+void _OUTREGP(struct radeonfb_info *rinfo, u32 addr, u32 val, u32 mask);
 
 #define OUTREGP(addr,val,mask)	_OUTREGP(rinfo, addr, val,mask)
 
@@ -425,64 +400,24 @@ static inline void _OUTREGP(struct radeonfb_info *rinfo, u32 addr,
  * possible exception to this rule is the call to unblank(), which may
  * be done at irq time if an oops is in progress.
  */
+void radeon_pll_errata_after_index_slow(struct radeonfb_info *rinfo);
 static inline void radeon_pll_errata_after_index(struct radeonfb_info *rinfo)
 {
-	if (!(rinfo->errata & CHIP_ERRATA_PLL_DUMMYREADS))
-		return;
-
-	(void)INREG(CLOCK_CNTL_DATA);
-	(void)INREG(CRTC_GEN_CNTL);
+	if (rinfo->errata & CHIP_ERRATA_PLL_DUMMYREADS)
+		radeon_pll_errata_after_index_slow(rinfo);
 }
 
+void radeon_pll_errata_after_data_slow(struct radeonfb_info *rinfo);
 static inline void radeon_pll_errata_after_data(struct radeonfb_info *rinfo)
 {
-	if (rinfo->errata & CHIP_ERRATA_PLL_DELAY) {
-		/* we can't deal with posted writes here ... */
-		_radeon_msleep(rinfo, 5);
-	}
-	if (rinfo->errata & CHIP_ERRATA_R300_CG) {
-		u32 save, tmp;
-		save = INREG(CLOCK_CNTL_INDEX);
-		tmp = save & ~(0x3f | PLL_WR_EN);
-		OUTREG(CLOCK_CNTL_INDEX, tmp);
-		tmp = INREG(CLOCK_CNTL_DATA);
-		OUTREG(CLOCK_CNTL_INDEX, save);
-	}
-}
-
-static inline u32 __INPLL(struct radeonfb_info *rinfo, u32 addr)
-{
-	u32 data;
-
-	OUTREG8(CLOCK_CNTL_INDEX, addr & 0x0000003f);
-	radeon_pll_errata_after_index(rinfo);
-	data = INREG(CLOCK_CNTL_DATA);
-	radeon_pll_errata_after_data(rinfo);
-	return data;
-}
-
-static inline void __OUTPLL(struct radeonfb_info *rinfo, unsigned int index,
-			    u32 val)
-{
-
-	OUTREG8(CLOCK_CNTL_INDEX, (index & 0x0000003f) | 0x00000080);
-	radeon_pll_errata_after_index(rinfo);
-	OUTREG(CLOCK_CNTL_DATA, val);
-	radeon_pll_errata_after_data(rinfo);
-}
-
-
-static inline void __OUTPLLP(struct radeonfb_info *rinfo, unsigned int index,
-			     u32 val, u32 mask)
-{
-	unsigned int tmp;
-
-	tmp  = __INPLL(rinfo, index);
-	tmp &= (mask);
-	tmp |= (val);
-	__OUTPLL(rinfo, index, tmp);
+	if (rinfo->errata & (CHIP_ERRATA_PLL_DELAY|CHIP_ERRATA_R300_CG))
+		radeon_pll_errata_after_data_slow(rinfo);
 }
 
+u32 __INPLL(struct radeonfb_info *rinfo, u32 addr);
+void __OUTPLL(struct radeonfb_info *rinfo, unsigned int index, u32 val);
+void __OUTPLLP(struct radeonfb_info *rinfo, unsigned int index,
+			     u32 val, u32 mask);
 
 #define INPLL(addr)			__INPLL(rinfo, addr)
 #define OUTPLL(index, val)		__OUTPLL(rinfo, index, val)
@@ -532,58 +467,9 @@ static inline u32 radeon_get_dstbpp(u16 depth)
  * 2D Engine helper routines
  */
 
-static inline void _radeon_fifo_wait(struct radeonfb_info *rinfo, int entries)
-{
-	int i;
-
-	for (i=0; i<2000000; i++) {
-		if ((INREG(RBBM_STATUS) & 0x7f) >= entries)
-			return;
-		udelay(1);
-	}
-	printk(KERN_ERR "radeonfb: FIFO Timeout !\n");
-}
-
-static inline void radeon_engine_flush (struct radeonfb_info *rinfo)
-{
-	int i;
-
-	/* Initiate flush */
-	OUTREGP(DSTCACHE_CTLSTAT, RB2D_DC_FLUSH_ALL,
-	        ~RB2D_DC_FLUSH_ALL);
-
-	/* Ensure FIFO is empty, ie, make sure the flush commands
-	 * has reached the cache
-	 */
-	_radeon_fifo_wait (rinfo, 64);
-
-	/* Wait for the flush to complete */
-	for (i=0; i < 2000000; i++) {
-		if (!(INREG(DSTCACHE_CTLSTAT) & RB2D_DC_BUSY))
-			return;
-		udelay(1);
-	}
-	printk(KERN_ERR "radeonfb: Flush Timeout !\n");
-}
-
-
-static inline void _radeon_engine_idle(struct radeonfb_info *rinfo)
-{
-	int i;
-
-	/* ensure FIFO is empty before waiting for idle */
-	_radeon_fifo_wait (rinfo, 64);
-
-	for (i=0; i<2000000; i++) {
-		if (((INREG(RBBM_STATUS) & GUI_ACTIVE)) = 0) {
-			radeon_engine_flush (rinfo);
-			return;
-		}
-		udelay(1);
-	}
-	printk(KERN_ERR "radeonfb: Idle Timeout !\n");
-}
-
+void _radeon_fifo_wait(struct radeonfb_info *rinfo, int entries);
+void radeon_engine_flush(struct radeonfb_info *rinfo);
+void _radeon_engine_idle(struct radeonfb_info *rinfo);
 
 #define radeon_engine_idle()		_radeon_engine_idle(rinfo)
 #define radeon_fifo_wait(entries)	_radeon_fifo_wait(rinfo,entries)
-- 
1.8.1.4

