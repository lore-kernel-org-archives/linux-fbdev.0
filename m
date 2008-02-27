From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 3/8] pxa: purge unnecessary pr_debug and
	comments from pxafb
Date: Wed, 27 Feb 2008 10:35:03 +0800
Message-ID: <f17812d70802261835r7a96d49ajf4c41205998fb3af@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUC8R-0003Nl-1g for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:35:07 -0800
Received: from el-out-1112.google.com ([209.85.162.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUC8P-0007fU-8S
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:35:06 -0800
Received: by el-out-1112.google.com with SMTP id y26so2496676ele.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Feb 2008 18:35:04 -0800 (PST)
Content-Disposition: inline
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
To: linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

From 5941d429a452424807fc4acd66630455382663d1 Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Tue, 26 Feb 2008 18:11:41 +0800
Subject: [PATCH] pxa: purge unnecessary pr_debug and comments from pxafb

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c |   71 -------------------------------------------------
 1 files changed, 0 insertions(+), 71 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 76e58b4..4b513f4 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -354,7 +354,6 @@ static int pxafb_check_var(struct
fb_var_screeninfo *var, struct fb_info *info)

 static inline void pxafb_set_truecolor(u_int is_true_color)
 {
-	pr_debug("pxafb: true_color = %d\n", is_true_color);
 	/* do your machine-specific setup if needed */
 }

@@ -368,8 +367,6 @@ static int pxafb_set_par(struct fb_info *info)
 	struct fb_var_screeninfo *var = &info->var;
 	unsigned long palette_mem_size;

-	pr_debug("pxafb: set_par\n");
-
 	if (var->bits_per_pixel == 16)
 		fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
 	else if (!fbi->cmap_static)
@@ -396,8 +393,6 @@ static int pxafb_set_par(struct fb_info *info)
 	else
 		palette_mem_size = fbi->palette_size * sizeof(u32);

-	pr_debug("pxafb: palette_mem_size = 0x%08lx\n", palette_mem_size);
-
 	fbi->palette_cpu = (u16 *)(fbi->map_cpu + PAGE_SIZE - palette_mem_size);
 	fbi->palette_dma = fbi->map_dma + PAGE_SIZE - palette_mem_size;

@@ -417,36 +412,6 @@ static int pxafb_set_par(struct fb_info *info)
 }

 /*
- * Formal definition of the VESA spec:
- *  On
- *  	This refers to the state of the display when it is in full operation
- *  Stand-By
- *  	This defines an optional operating state of minimal power reduction with
- *  	the shortest recovery time
- *  Suspend
- *  	This refers to a level of power management in which substantial power
- *  	reduction is achieved by the display.  The display can have a longer
- *  	recovery time from this state than from the Stand-by state
- *  Off
- *  	This indicates that the display is consuming the lowest level of power
- *  	and is non-operational. Recovery from this state may optionally require
- *  	the user to manually power on the monitor
- *
- *  Now, the fbdev driver adds an additional state, (blank), where they
- *  turn off the video (maybe by colormap tricks), but don't mess with the
- *  video itself: think of it semantically between on and Stand-By.
- *
- *  So here's what we should do in our fbdev blank routine:
- *
- *  	VESA_NO_BLANKING (mode 0)	Video on,  front/back light on
- *  	VESA_VSYNC_SUSPEND (mode 1)  	Video on,  front/back light off
- *  	VESA_HSYNC_SUSPEND (mode 2)  	Video on,  front/back light off
- *  	VESA_POWERDOWN (mode 3)		Video off, front/back light off
- *
- *  This will match the matrox implementation.
- */
-
-/*
  * pxafb_blank():
  *	Blank the display by setting all palette values to zero.  Note, the
  * 	16 bpp mode does not really use the palette, so this will not
@@ -457,8 +422,6 @@ static int pxafb_blank(int blank, struct fb_info *info)
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
 	int i;

-	pr_debug("pxafb: blank=%d\n", blank);
-
 	switch (blank) {
 	case FB_BLANK_POWERDOWN:
 	case FB_BLANK_VSYNC_SUSPEND:
@@ -599,16 +562,6 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,
 	u_long flags;
 	u_int lines_per_panel, pcd = get_pcd(fbi, var->pixclock);

-	pr_debug("pxafb: Configuring PXA LCD\n");
-
-	pr_debug("var: xres=%d hslen=%d lm=%d rm=%d\n",
-		 var->xres, var->hsync_len,
-		 var->left_margin, var->right_margin);
-	pr_debug("var: yres=%d vslen=%d um=%d bm=%d\n",
-		 var->yres, var->vsync_len,
-		 var->upper_margin, var->lower_margin);
-	pr_debug("var: pixclock=%d pcd=%d\n", var->pixclock, pcd);
-
 #if DEBUG_VAR
 	if (var->xres < 16 || var->xres > 1024)
 		printk(KERN_ERR "%s: invalid xres %d\n",
@@ -682,11 +635,6 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,
 	if (pcd)
 		new_regs.lccr3 |= LCCR3_PixClkDiv(pcd);

-	pr_debug("nlccr0 = 0x%08x\n", new_regs.lccr0);
-	pr_debug("nlccr1 = 0x%08x\n", new_regs.lccr1);
-	pr_debug("nlccr2 = 0x%08x\n", new_regs.lccr2);
-	pr_debug("nlccr3 = 0x%08x\n", new_regs.lccr3);
-
 	/* Update shadow copy atomically */
 	local_irq_save(flags);

@@ -848,22 +796,12 @@ static void pxafb_enable_controller(struct
pxafb_info *fbi)
 	FDADR0 = fbi->fdadr0;
 	FDADR1 = fbi->fdadr1;
 	LCCR0 |= LCCR0_ENB;
-
-	pr_debug("FDADR0 0x%08x\n", (unsigned int) FDADR0);
-	pr_debug("FDADR1 0x%08x\n", (unsigned int) FDADR1);
-	pr_debug("LCCR0 0x%08x\n", (unsigned int) LCCR0);
-	pr_debug("LCCR1 0x%08x\n", (unsigned int) LCCR1);
-	pr_debug("LCCR2 0x%08x\n", (unsigned int) LCCR2);
-	pr_debug("LCCR3 0x%08x\n", (unsigned int) LCCR3);
-	pr_debug("LCCR4 0x%08x\n", (unsigned int) LCCR4);
 }

 static void pxafb_disable_controller(struct pxafb_info *fbi)
 {
 	DECLARE_WAITQUEUE(wait, current);

-	pr_debug("pxafb: disabling LCD controller\n");
-
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	add_wait_queue(&fbi->ctrlr_wait, &wait);

@@ -1123,9 +1061,6 @@ static int __init pxafb_map_video_memory(struct
pxafb_info *fbi)
 		else
 			palette_mem_size = fbi->palette_size * sizeof(u32);

-		pr_debug("pxafb: palette_mem_size = 0x%08lx\n",
-				palette_mem_size);
-
 		fbi->palette_cpu = (u16 *)(fbi->map_cpu + PAGE_SIZE
 						- palette_mem_size);
 		fbi->palette_dma = fbi->map_dma + PAGE_SIZE - palette_mem_size;
@@ -1482,10 +1417,6 @@ static int __init pxafb_probe(struct
platform_device *dev)
 		goto failed;
 	}

-#ifdef CONFIG_PM
-	/* TODO */
-#endif
-
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = pxafb_freq_transition;
 	fbi->freq_policy.notifier_call = pxafb_freq_policy;
@@ -1510,10 +1441,8 @@ failed:

 static struct platform_driver pxafb_driver = {
 	.probe		= pxafb_probe,
-#ifdef CONFIG_PM
 	.suspend	= pxafb_suspend,
 	.resume		= pxafb_resume,
-#endif
 	.driver		= {
 		.name	= "pxa2xx-fb",
 	},
-- 
1.5.3.8



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
