From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] radeonfb: remove reg_lock nonsense
Date: Tue, 6 Jul 2004 04:10:38 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040706081037.GA9036@havoc.gtf.org>
References: <200407051043.i65AhCG13509@mail.osdl.org> <Pine.LNX.4.58.0407051028250.1764@ppc970.osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bhl2O-0004EA-7o
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 01:10:48 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bhl2N-0007gD-HN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 01:10:48 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407051028250.1764@ppc970.osdl.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net

On Mon, Jul 05, 2004 at 10:34:29AM -0700, Linus Torvalds wrote:
> On Mon, 5 Jul 2004 akpm@osdl.org wrote:
> >
> > From: David Eger <eger@havoc.gtf.org>
> > 
> > radeonfb: the Stanford lock checker found us double-locking rinfo->reg_lock
> > via sequences like OUTPLL(foo, INPLL(bar) | baz ), as both OUTPLL and INPLL
> > grab the register lock.  This should fix the problem.
> 
> Ok, I applied it, since I don't have a better tested alternative, but it's 
> really very very ugly.
>
  [ generally well-meaning suggestions - snip ]  
>
> Ben, any comments? How did this code ever survive? Why didn't my G5 lock 
> up?

I agree, the patch is horrid.  In fact, now that I really look at it,
it seems that the spinlock is totally bogus.  This patch removes it.
Details below.

BenH: thoughts, objections?

-dte

This patch removes all of the reg_lock nonsense in radeonfb, reversing
the ugliness of my previous patch to placate the Stanford lock checker,
and getting rid of any false sense of security we had seeing a spinlock
in the radeonfb_info.

The truth seems, there's no rhyme nor reason to the use of the register 
lock in radeonfb_info.  It becomes apparent when you look 
past your nose ;-)

The macros INREG() and OUTREG() don't touch it while INPLL(), OUTPLL(),
OUTPLLP(), and OUTREGP() do.  Nonetheless, we have:

* radeonfb_engine_reset() writes to CLOCK_CNTL_INDEX without taking the
  register lock, while radeon_write_pll_regs() uses OUTREGP() to modify it.

* there are these nonsensical quick-successions of grabbing the same lock
  with OUTPLL() calls
  
I think the only places where sane register access arbitration takes
place is over in *cough* drivers/char/drm *cough* and the VC code
(which, AFAIK, already serializes access to the FB device, no?)

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2004-07-06 10:02:45 +02:00
+++ b/drivers/video/aty/radeon_base.c	2004-07-06 10:02:45 +02:00
@@ -2087,7 +2087,6 @@
 	rinfo->info = info;	
 	rinfo->pdev = pdev;
 	
-	spin_lock_init(&rinfo->reg_lock);
 	init_timer(&rinfo->lvds_timer);
 	rinfo->lvds_timer.function = radeon_lvds_timer_func;
 	rinfo->lvds_timer.data = (unsigned long)rinfo;
diff -Nru a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
--- a/drivers/video/aty/radeon_pm.c	2004-07-06 10:02:45 +02:00
+++ b/drivers/video/aty/radeon_pm.c	2004-07-06 10:02:45 +02:00
@@ -319,30 +319,26 @@
 
 static void radeon_pm_program_v2clk(struct radeonfb_info *rinfo)
 {
-	/* we use __INPLL and _OUTPLL and do the locking ourselves... */
-	unsigned long flags;
-	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	/* Set v2clk to 65MHz */
-  	__OUTPLL(pllPIXCLKS_CNTL,
-  		__INPLL(rinfo, pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
+  	OUTPLL(pllPIXCLKS_CNTL,
+  		INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
 	 
-  	__OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
-	__OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
-	__OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);
+  	OUTPLL(pllP2PLL_REF_DIV, 0x0000000c);
+	OUTPLL(pllP2PLL_CNTL, 0x0000bf00);
+	OUTPLL(pllP2PLL_DIV_0, 0x00020074 | P2PLL_DIV_0__P2PLL_ATOMIC_UPDATE_W);
 	
-	__OUTPLL(pllP2PLL_CNTL,
-		__INPLL(rinfo, pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
+	OUTPLL(pllP2PLL_CNTL,
+		INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_SLEEP);
 	mdelay(1);
 
-	__OUTPLL(pllP2PLL_CNTL,
-		__INPLL(rinfo, pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET);
+	OUTPLL(pllP2PLL_CNTL,
+		INPLL(pllP2PLL_CNTL) & ~P2PLL_CNTL__P2PLL_RESET);
 	mdelay( 1);
 
-  	__OUTPLL(pllPIXCLKS_CNTL,
-  		(__INPLL(rinfo, pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
+  	OUTPLL(pllPIXCLKS_CNTL,
+  		(INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK)
   		| (0x03 << PIXCLKS_CNTL__PIX2CLK_SRC_SEL__SHIFT));
 	mdelay( 1);	
-	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 static void radeon_pm_low_current(struct radeonfb_info *rinfo)
@@ -397,7 +393,6 @@
 	u32 pixclks_cntl;
 	u32 disp_mis_cntl;
 	u32 disp_pwr_man;
-	u32 tmp;
 	
 	/* Force Core Clocks */
 	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
@@ -503,9 +498,8 @@
 	
 	clk_pin_cntl &= ~CLK_PIN_CNTL__ACCESS_REGS_IN_SUSPEND;
 
-	/* because both INPLL and OUTPLL take the same lock, that's why. */
-	tmp = INPLL( pllMCLK_MISC) | MCLK_MISC__EN_MCLK_TRISTATE_IN_SUSPEND;
-	OUTPLL( pllMCLK_MISC, tmp);
+	OUTPLL( pllMCLK_MISC, 
+		INPLL( pllMCLK_MISC) | MCLK_MISC__EN_MCLK_TRISTATE_IN_SUSPEND);
 	
 	/* AGP PLL control */
 	OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
@@ -525,9 +519,8 @@
 		| (0x20<<AGP_CNTL__MAX_IDLE_CLK__SHIFT));
 
 	/* ACPI mode */
-	/* because both INPLL and OUTPLL take the same lock, that's why. */
-	tmp = INPLL( pllPLL_PWRMGT_CNTL) & ~PLL_PWRMGT_CNTL__PM_MODE_SEL;
-	OUTPLL( pllPLL_PWRMGT_CNTL, tmp);
+	OUTPLL( pllPLL_PWRMGT_CNTL, 
+		INPLL( pllPLL_PWRMGT_CNTL) & ~PLL_PWRMGT_CNTL__PM_MODE_SEL);
 
 
 	disp_mis_cntl = INREG(DISP_MISC_CNTL);
@@ -778,7 +771,6 @@
 static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 {
 	u16 pwr_cmd;
-	u32 tmp;
 
 	if (!rinfo->pm_reg)
 		return;
@@ -815,8 +807,9 @@
 
 			/* Reset the MDLL */
 			/* because both INPLL and OUTPLL take the same lock, that's why. */
-			tmp = INPLL( pllMDLL_CKO) | MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET;
-			OUTPLL( pllMDLL_CKO, tmp );
+			
+			OUTPLL( pllMDLL_CKO,
+				INPLL( pllMDLL_CKO) | MDLL_CKO__MCKOA_RESET | MDLL_CKO__MCKOB_RESET);
 		}
 
 		/* Switch PCI power managment to D2. */
diff -Nru a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
--- a/drivers/video/aty/radeonfb.h	2004-07-06 10:02:45 +02:00
+++ b/drivers/video/aty/radeonfb.h	2004-07-06 10:02:45 +02:00
@@ -311,9 +311,6 @@
 	int			asleep;
 	int			lock_blank;
 
-	/* Lock on register access */
-	spinlock_t		reg_lock;
-
 	/* Timer used for delayed LVDS operations */
 	struct timer_list	lvds_timer;
 	u32			pending_lvds_gen_cntl;
@@ -363,11 +360,11 @@
 	OUTREG(CLOCK_CNTL_INDEX, save);
 }
 
-#define __OUTPLL(addr,val)	\
-	do {	\
-		OUTREG8(CLOCK_CNTL_INDEX, (addr & 0x0000003f) | 0x00000080); \
-		OUTREG(CLOCK_CNTL_DATA, val); \
-} while(0)
+static inline u32 __OUTPLL(struct radeonfb_info *rinfo, u32 addr, u32 val)
+{
+		OUTREG8(CLOCK_CNTL_INDEX, (addr & 0x0000003f) | 0x00000080);
+		OUTREG(CLOCK_CNTL_DATA, val);
+}
 
 
 static inline u32 __INPLL(struct radeonfb_info *rinfo, u32 addr)
@@ -380,49 +377,25 @@
 	return data;
 }
 
-static inline u32 _INPLL(struct radeonfb_info *rinfo, u32 addr)
-{
-       	unsigned long flags;
-	u32 data;
-
-	spin_lock_irqsave(&rinfo->reg_lock, flags);
-	data = __INPLL(rinfo, addr);
-	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
-	return data;
-}
-
-#define INPLL(addr)		_INPLL(rinfo, addr)
-
-#define OUTPLL(addr,val)	\
-	do {	\
-		unsigned long flags;\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); \
-		__OUTPLL(addr, val); \
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); \
-	} while(0)
+#define INPLL(addr)       __INPLL(rinfo, addr)
+#define OUTPLL(addr, val) __OUTPLL(rinfo, addr, val)
 
 #define OUTPLLP(addr,val,mask)  					\
 	do {								\
-		unsigned long flags;                                    \
 		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
 		_tmp  = __INPLL(rinfo,addr);				\
 		_tmp &= (mask);						\
 		_tmp |= (val);						\
-		__OUTPLL(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
+		__OUTPLL(rinfo, addr, _tmp);					\
 	} while (0)
 
 #define OUTREGP(addr,val,mask)  					\
 	do {								\
-		unsigned long flags;                                    \
 		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
 		_tmp = INREG(addr);				       	\
 		_tmp &= (mask);						\
 		_tmp |= (val);						\
 		OUTREG(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
 	} while (0)
 
 #define MS_TO_HZ(ms)       ((ms * HZ + 999) / 1000)


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
