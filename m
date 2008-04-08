From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH RFC] pxafb: introduce "struct
	pxafb_output" to abstract the output interface
Date: Tue, 8 Apr 2008 17:59:14 +0800
Message-ID: <f17812d70804080259n7e69fc54n7a18bca77c88b8bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JjAbl-0007kT-8t for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 02:59:17 -0700
Received: from wr-out-0506.google.com ([64.233.184.228])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JjAbk-0007kE-6a
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 02:59:17 -0700
Received: by wr-out-0506.google.com with SMTP id c48so1563780wra.1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 Apr 2008 02:59:15 -0700 (PDT)
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
To: linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Mack <daniel@caiaq.de>

From 8a735df5e45b35f76672e79b44aeedece1dd68da Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Tue, 8 Apr 2008 17:48:09 +0800
Subject: [PATCH] pxafb: introduce "struct pxafb_output" to abstract
the output interface

Currently two output interfaces are supported:

    ppi - parallel port interface
    spi - smart panel interface

and possibly MIPI or video output in the future.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/video/Kconfig |    8 +-
 drivers/video/pxafb.c |  550 +++++++++++++++++++++++++++++++++----------------
 drivers/video/pxafb.h |   26 ++-
 3 files changed, 394 insertions(+), 190 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 9721b5c..f769a2f 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1742,9 +1742,13 @@ config FB_PXA

 	  If unsure, say N.

-config FB_PXA_SMARTPANEL
-	bool "PXA Smartpanel LCD support"
+config FB_PXA_PPI
+	bool "PXA LCD Parallel Port Interface support"
+	depends on FB_PXA
 	default y
+
+config FB_PXA_SPI
+	bool "PXA LCD Smart Panel Interface support"
 	depends on FB_PXA

 config FB_PXA_PARAMETERS
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 0e9eeac..b33e7cf 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -22,6 +22,8 @@
  *
  */

+#define DEBUG
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -304,21 +306,8 @@ static int pxafb_check_var(struct
fb_var_screeninfo *var, struct fb_info *info)
 	if (var->yres < MIN_YRES)
 		var->yres = MIN_YRES;

-	if (inf->fixed_modes) {
-		struct pxafb_mode_info *mode;
-
-		mode = pxafb_getmode(inf, var);
-		if (!mode)
-			return -EINVAL;
-		pxafb_setmode(var, mode);
-	} else {
-		if (var->xres > inf->modes->xres)
-			return -EINVAL;
-		if (var->yres > inf->modes->yres)
-			return -EINVAL;
-		if (var->bits_per_pixel > inf->modes->bpp)
-			return -EINVAL;
-	}
+	if (fbi->output->check(fbi, var))
+		return -EINVAL;

 	var->xres_virtual =
 		max(var->xres_virtual, var->xres);
@@ -545,62 +534,205 @@ unsigned long pxafb_get_hsync_time(struct device *dev)
 }
 EXPORT_SYMBOL(pxafb_get_hsync_time);

-static int setup_frame_dma(struct pxafb_info *fbi, int dma, int pal,
-		unsigned int offset, size_t size)
+static int dummy_ret(struct pxafb_info *fbi)
 {
-	struct pxafb_dma_descriptor *dma_desc, *pal_desc;
-	unsigned int dma_desc_off, pal_desc_off;
+	return 0;
+}

-	if (dma < 0 || dma >= DMA_MAX)
-		return -EINVAL;
+static void dummy_noret(struct pxafb_info *fbi)
+{
+}

-	dma_desc = &fbi->dma_buff->dma_desc[dma];
-	dma_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[dma]);
+static int dummy_check(struct pxafb_info *fbi, struct fb_var_screeninfo *var)
+{
+	return 0;
+}

-	dma_desc->fsadr = fbi->screen_dma + offset;
-	dma_desc->fidr  = 0;
-	dma_desc->ldcmd = size;
+static void dummy_irq(struct pxafb_info *fbi, uint32_t lcsr)
+{
+}

-	if (pal < 0 || pal >= PAL_MAX) {
-		dma_desc->fdadr = fbi->dma_buff_phys + dma_desc_off;
-		fbi->fdadr[dma] = fbi->dma_buff_phys + dma_desc_off;
+static struct pxafb_output pxafb_output_dummy = {
+	.name		= "dummy",
+	.init		= dummy_ret,
+	.exit		= dummy_ret,
+	.check		= dummy_check,
+	.setup		= dummy_check,
+	.enable		= dummy_noret,
+	.disable	= dummy_noret,
+	.handle_irq	= dummy_irq,
+};
+
+#ifdef CONFIG_FB_PXA_PPI
+struct pxafb_output_ppi_priv {
+	struct completion	disable_done;
+};
+
+static void pxafb_ppi_irq(struct pxafb_info *fbi, uint32_t lcsr)
+{
+	struct pxafb_output_ppi_priv *ppi = fbi->output_priv;
+	uint32_t lccr0;
+
+	if (lcsr & LCSR_LDD) {
+		lccr0 = lcd_readl(fbi, LCCR0);
+		lcd_writel(fbi, LCCR0, lccr0 | LCCR0_LDM);
+		complete(&ppi->disable_done);
+	}
+}
+
+static int pxafb_ppi_check(struct pxafb_info *fbi,
+			   struct fb_var_screeninfo *var)
+{
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
+
+	if (inf->fixed_modes) {
+		struct pxafb_mode_info *mode;
+
+		mode = pxafb_getmode(inf, var);
+		if (!mode)
+			return -EINVAL;
+		pxafb_setmode(var, mode);
 	} else {
-		pal_desc = &fbi->dma_buff->pal_desc[dma];
-		pal_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[pal]);
+		if (var->xres > inf->modes->xres)
+			return -EINVAL;
+		if (var->yres > inf->modes->yres)
+			return -EINVAL;
+		if (var->bits_per_pixel > inf->modes->bpp)
+			return -EINVAL;
+	}

-		pal_desc->fsadr = fbi->dma_buff_phys + pal * PALETTE_SIZE;
-		pal_desc->fidr  = 0;
+	return 0;
+}

-		if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) == LCCR4_PAL_FOR_0)
-			pal_desc->ldcmd = fbi->palette_size * sizeof(u16);
-		else
-			pal_desc->ldcmd = fbi->palette_size * sizeof(u32);
+static int pxafb_ppi_setup(struct pxafb_info *fbi,
+			   struct fb_var_screeninfo *var)
+{
+	unsigned int lines_per_panel, pcd = get_pcd(fbi, var->pixclock);

-		pal_desc->ldcmd |= LDCMD_PAL;
+	fbi->reg_lccr1 =
+		LCCR1_DisWdth(var->xres) +
+		LCCR1_HorSnchWdth(var->hsync_len) +
+		LCCR1_BegLnDel(var->left_margin) +
+		LCCR1_EndLnDel(var->right_margin);

-		/* flip back and forth between palette and frame buffer */
-		pal_desc->fdadr = fbi->dma_buff_phys + dma_desc_off;
-		dma_desc->fdadr = fbi->dma_buff_phys + pal_desc_off;
-		fbi->fdadr[dma] = fbi->dma_buff_phys + dma_desc_off;
+	/*
+	 * If we have a dual scan LCD, we need to halve
+	 * the YRES parameter.
+	 */
+	lines_per_panel = var->yres;
+	if ((fbi->lccr0 & LCCR0_SDS) == LCCR0_Dual)
+		lines_per_panel /= 2;
+
+	fbi->reg_lccr2 =
+		LCCR2_DisHght(lines_per_panel) +
+		LCCR2_VrtSnchWdth(var->vsync_len) +
+		LCCR2_BegFrmDel(var->upper_margin) +
+		LCCR2_EndFrmDel(var->lower_margin);
+
+	fbi->reg_lccr3 = fbi->lccr3 |
+		(var->sync & FB_SYNC_HOR_HIGH_ACT ?
+		 LCCR3_HorSnchH : LCCR3_HorSnchL) |
+		(var->sync & FB_SYNC_VERT_HIGH_ACT ?
+		 LCCR3_VrtSnchH : LCCR3_VrtSnchL);
+
+	if (pcd) {
+		fbi->reg_lccr3 |= LCCR3_PixClkDiv(pcd);
+		set_hsync_time(fbi, pcd);
 	}
+	return 0;
+}

+static void pxafb_ppi_enable(struct pxafb_info *fbi)
+{
+	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);
+}
+
+static void pxafb_ppi_disable(struct pxafb_info *fbi)
+{
+	struct pxafb_output_ppi_priv *ppi = fbi->output_priv;
+	uint32_t lccr0;
+	int timeout = 200 * HZ / 1000;
+
+	/* Clear LCD Status Register */
+	lcd_writel(fbi, LCSR, 0xffffffff);
+
+	lccr0 = lcd_readl(fbi, LCCR0) & ~LCCR0_LDM;
+	lcd_writel(fbi, LCCR0, lccr0);
+	lcd_writel(fbi, LCCR0, lccr0 | LCCR0_DIS);
+
+	if (wait_for_completion_timeout(&ppi->disable_done, timeout) == 0)
+		pr_warning("%s: time out waiting for stop\n", __func__);
+}
+
+static int pxafb_ppi_init(struct pxafb_info *fbi)
+{
+	struct pxafb_output_ppi_priv *ppi;
+
+	printk("%s:\n", __func__);
+	ppi = kzalloc(sizeof(*ppi), GFP_KERNEL);
+	if (ppi == NULL)
+		return -ENOMEM;
+
+	init_completion(&ppi->disable_done);
+	fbi->output_priv = ppi;
+	return 0;
+}
+
+static int pxafb_ppi_exit(struct pxafb_info *fbi)
+{
+	kfree(fbi->output_priv);
 	return 0;
 }

-#ifdef CONFIG_FB_PXA_SMARTPANEL
+struct pxafb_output pxafb_output_ppi = {
+	.name		= "parallel",
+	.init		= pxafb_ppi_init,
+	.exit		= pxafb_ppi_exit,
+	.check		= pxafb_ppi_check,
+	.setup		= pxafb_ppi_setup,
+	.enable		= pxafb_ppi_enable,
+	.disable	= pxafb_ppi_disable,
+	.handle_irq	= pxafb_ppi_irq,
+};
+#else
+#define pxafb_output_ppi	pxafb_output_dummy
+#endif
+
+#ifdef CONFIG_FB_PXA_SPI
+#define CMD_BUFF_SIZE	(1024 * 50)
+#define MAX_CMD_NR	(CMD_BUFF_SIZE / sizeof(uint16_t))
+
+struct pxafb_output_spi_priv {
+	dma_addr_t		cmd_buff_dma;
+	uint16_t		*smart_cmds;
+	size_t			n_smart_cmds;
+	struct completion	command_done;
+	struct completion	refresh_done;
+	struct task_struct	*smart_thread;
+	struct pxafb_mode_info	*mode;
+};
+
+static void pxafb_spi_irq(struct pxafb_info *fbi, uint32_t lcsr)
+{
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;
+
+	if (lcsr & LCSR_CMD_INT)
+		complete(&spi->command_done);
+}
+
 static int setup_smart_dma(struct pxafb_info *fbi)
 {
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;
 	struct pxafb_dma_descriptor *dma_desc;
-	unsigned long dma_desc_off, cmd_buff_off;
+	unsigned long dma_desc_off;

 	dma_desc = &fbi->dma_buff->dma_desc[DMA_CMD];
 	dma_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[DMA_CMD]);
-	cmd_buff_off = offsetof(struct pxafb_dma_buff, cmd_buff);

 	dma_desc->fdadr = fbi->dma_buff_phys + dma_desc_off;
-	dma_desc->fsadr = fbi->dma_buff_phys + cmd_buff_off;
+	dma_desc->fsadr = spi->cmd_buff_dma;
 	dma_desc->fidr  = 0;
-	dma_desc->ldcmd = fbi->n_smart_cmds * sizeof(uint16_t);
+	dma_desc->ldcmd = spi->n_smart_cmds * sizeof(uint16_t);

 	fbi->fdadr[DMA_CMD] = dma_desc->fdadr;
 	return 0;
@@ -609,6 +741,7 @@ static int setup_smart_dma(struct pxafb_info *fbi)
 int pxafb_smart_flush(struct fb_info *info)
 {
 	struct pxafb_info *fbi = container_of(info, struct pxafb_info, fb);
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;
 	uint32_t prsr;
 	int ret = 0;

@@ -620,11 +753,11 @@ int pxafb_smart_flush(struct fb_info *info)
 	 *    keep track of the end of the transfer
 	 */

-	while (fbi->n_smart_cmds & 1)
-		fbi->smart_cmds[fbi->n_smart_cmds++] = SMART_CMD_NOOP;
+	while (spi->n_smart_cmds & 1)
+		spi->smart_cmds[spi->n_smart_cmds++] = SMART_CMD_NOOP;

-	fbi->smart_cmds[fbi->n_smart_cmds++] = SMART_CMD_INTERRUPT;
-	fbi->smart_cmds[fbi->n_smart_cmds++] = SMART_CMD_WAIT_FOR_VSYNC;
+	spi->smart_cmds[spi->n_smart_cmds++] = SMART_CMD_INTERRUPT;
+	spi->smart_cmds[spi->n_smart_cmds++] = SMART_CMD_WAIT_FOR_VSYNC;
 	setup_smart_dma(fbi);

 	/* continue to execute next command */
@@ -646,7 +779,7 @@ int pxafb_smart_flush(struct fb_info *info)
 	/* begin sending */
 	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);

-	if (wait_for_completion_timeout(&fbi->command_done, HZ/2) == 0) {
+	if (wait_for_completion_timeout(&spi->command_done, HZ/2) == 0) {
 		pr_warning("%s: timeout waiting for command done\n",
 				__func__);
 		ret = -ETIMEDOUT;
@@ -657,23 +790,74 @@ int pxafb_smart_flush(struct fb_info *info)
 	lcd_writel(fbi, PRSR, prsr);
 	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 & ~LCCR0_ENB);
 	lcd_writel(fbi, FDADR6, 0);
-	fbi->n_smart_cmds = 0;
+	spi->n_smart_cmds = 0;
 	return ret;
 }

 int pxafb_smart_queue(struct fb_info *info, uint16_t *cmds, int n_cmds)
 {
-	int i;
 	struct pxafb_info *fbi = container_of(info, struct pxafb_info, fb);
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;
+	int i;

 	/* leave 2 commands for INTERRUPT and WAIT_FOR_SYNC */
 	for (i = 0; i < n_cmds; i++) {
-		if (fbi->n_smart_cmds == CMD_BUFF_SIZE - 8)
+		if (spi->n_smart_cmds == MAX_CMD_NR - 8)
 			pxafb_smart_flush(info);

-		fbi->smart_cmds[fbi->n_smart_cmds++] = *cmds++;
+		spi->smart_cmds[spi->n_smart_cmds++] = *cmds++;
+	}
+
+	return 0;
+}
+
+static int pxafb_smart_thread(void *arg)
+{
+	struct pxafb_info *fbi = (struct pxafb_info *) arg;
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
+
+	if (!fbi || !inf->smart_update) {
+		pr_err("%s: not properly initialized, thread terminated\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	pr_debug("%s(): task starting\n", __func__);
+
+	set_freezable();
+	while (!kthread_should_stop()) {
+
+		if (try_to_freeze())
+			continue;
+
+		if (fbi->state == C_ENABLE) {
+			inf->smart_update(&fbi->fb);
+			complete(&spi->refresh_done);
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(30 * HZ / 1000);
 	}

+	pr_debug("%s(): task ending\n", __func__);
+	return 0;
+}
+
+/* smartpanel doesn't understand the timing information in
+ * fb_var_screeninfo, they are ignored and pxafb_getmode()
+ * is used to check the suitable mode
+ */
+static int pxafb_spi_check(struct pxafb_info *fbi,
+			   struct fb_var_screeninfo *var)
+{
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
+
+	spi->mode = pxafb_getmode(inf, var);
+	if (spi->mode == NULL)
+		return -EINVAL;
+
 	return 0;
 }

@@ -683,11 +867,12 @@ static unsigned int __smart_timing(unsigned
time_ns, unsigned long lcd_clk)
 	return (t == 0) ? 1 : t;
 }

-static void setup_smart_timing(struct pxafb_info *fbi,
-				struct fb_var_screeninfo *var)
+static int pxafb_spi_setup(struct pxafb_info *fbi,
+			   struct fb_var_screeninfo *var)
 {
-	struct pxafb_mach_info *inf = fbi->dev->platform_data;
-	struct pxafb_mode_info *mode = &inf->modes[0];
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;
+	struct pxafb_mode_info *mode = spi->mode;
+
 	unsigned long lclk = clk_get_rate(fbi->clk);
 	unsigned t1, t2, t3, t4;

@@ -707,98 +892,154 @@ static void setup_smart_timing(struct pxafb_info *fbi,

 	/* FIXME: make this configurable */
 	fbi->reg_cmdcr = 1;
+	return 0;
 }

-static int pxafb_smart_thread(void *arg)
+static void pxafb_spi_enable(struct pxafb_info *fbi)
 {
-	struct pxafb_info *fbi = (struct pxafb_info *) arg;
-	struct pxafb_mach_info *inf = fbi->dev->platform_data;
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;

-	if (!fbi || !inf->smart_update) {
-		pr_err("%s: not properly initialized, thread terminated\n",
-				__func__);
-		return -EINVAL;
-	}
+	wake_up_process(spi->smart_thread);
+}

-	pr_debug("%s(): task starting\n", __func__);
+static void pxafb_spi_disable(struct pxafb_info *fbi)
+{
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;
+	int timeout = 200 * HZ / 1000;

-	set_freezable();
-	while (!kthread_should_stop()) {
+	if (wait_for_completion_timeout(&spi->refresh_done, timeout) == 0)
+		pr_warning("%s: time out waiting for stop\n", __func__);
+}

-		if (try_to_freeze())
-			continue;
+static int pxafb_spi_init(struct pxafb_info *fbi)
+{
+	struct pxafb_output_spi_priv *spi;
+	int ret = -EINVAL;

-		if (fbi->state == C_ENABLE) {
-			inf->smart_update(&fbi->fb);
-			complete(&fbi->refresh_done);
-		}
+	spi = kzalloc(sizeof(*spi), GFP_KERNEL);
+	if (spi == NULL)
+		return -ENOMEM;

-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(30 * HZ / 1000);
+	spi->smart_cmds = dma_alloc_coherent(fbi->dev, CMD_BUFF_SIZE,
+				&spi->cmd_buff_dma, GFP_KERNEL);
+	if (spi->smart_cmds == NULL) {
+		ret = -ENOMEM;
+		goto err_free_spi;
 	}

-	pr_debug("%s(): task ending\n", __func__);
+	spi->smart_thread = kthread_create(pxafb_smart_thread, fbi,
+				"lcdrefresh");
+	if (IS_ERR(spi->smart_thread)) {
+		ret = PTR_ERR(spi->smart_thread);
+		goto err_free_dma;
+	}
+
+	init_completion(&spi->command_done);
+	init_completion(&spi->refresh_done);
+	spi->mode = NULL;
+
+	fbi->output_priv = spi;
 	return 0;
+err_free_dma:
+	dma_free_coherent(fbi->dev, CMD_BUFF_SIZE,
+			&spi->cmd_buff_dma, GFP_KERNEL);
+err_free_spi:
+	kfree(spi);
+	return ret;
 }

-static int pxafb_smart_init(struct pxafb_info *fbi)
+static int pxafb_spi_exit(struct pxafb_info *fbi)
 {
-	fbi->smart_thread = kthread_run(pxafb_smart_thread, fbi,
-					"lcd_refresh");
-	if (IS_ERR(fbi->smart_thread)) {
-		printk(KERN_ERR "%s: unable to create kernel thread\n",
-				__func__);
-		return PTR_ERR(fbi->smart_thread);
-	}
+	struct pxafb_output_spi_priv *spi = fbi->output_priv;
+
+	kthread_stop(spi->smart_thread);
+	dma_free_coherent(fbi->dev, CMD_BUFF_SIZE,
+			&spi->cmd_buff_dma, GFP_KERNEL);
+	kfree(spi);
+	fbi->output_priv = NULL;
 	return 0;
 }
+
+struct pxafb_output pxafb_output_spi = {
+	.name		= "smartpanel",
+	.init		= pxafb_spi_init,
+	.exit		= pxafb_spi_exit,
+	.check		= pxafb_spi_check,
+	.setup		= pxafb_spi_setup,
+	.enable		= pxafb_spi_enable,
+	.disable	= pxafb_spi_disable,
+	.handle_irq	= pxafb_spi_irq,
+};
 #else
-int pxafb_smart_queue(struct fb_info *info, uint16_t *cmds, int n_cmds)
+#define pxafb_output_spi	pxafb_output_dummy
+
+int pxafb_smart_flush(struct fb_info *info)
 {
 	return 0;
 }

-int pxafb_smart_flush(struct fb_info *info)
+int pxafb_smart_queue(struct fb_info *info, uint16_t *cmds, int n_cmds)
 {
 	return 0;
 }
-#endif /* CONFIG_FB_SMART_PANEL */
+#endif

-static void setup_parallel_timing(struct pxafb_info *fbi,
-				  struct fb_var_screeninfo *var)
+static int pxafb_output_init(struct pxafb_info *fbi,
+			     struct pxafb_output *output)
 {
-	unsigned int lines_per_panel, pcd = get_pcd(fbi, var->pixclock);
+	if (output == NULL)
+		output = &pxafb_output_dummy;

-	fbi->reg_lccr1 =
-		LCCR1_DisWdth(var->xres) +
-		LCCR1_HorSnchWdth(var->hsync_len) +
-		LCCR1_BegLnDel(var->left_margin) +
-		LCCR1_EndLnDel(var->right_margin);
+	if (fbi->output) {
+		fbi->output->exit(fbi);
+		fbi->output = NULL;
+		return 0;
+	}

-	/*
-	 * If we have a dual scan LCD, we need to halve
-	 * the YRES parameter.
-	 */
-	lines_per_panel = var->yres;
-	if ((fbi->lccr0 & LCCR0_SDS) == LCCR0_Dual)
-		lines_per_panel /= 2;
+	fbi->output = output;
+	return output->init(fbi);
+}

-	fbi->reg_lccr2 =
-		LCCR2_DisHght(lines_per_panel) +
-		LCCR2_VrtSnchWdth(var->vsync_len) +
-		LCCR2_BegFrmDel(var->upper_margin) +
-		LCCR2_EndFrmDel(var->lower_margin);
+static int setup_frame_dma(struct pxafb_info *fbi, int dma, int pal,
+		unsigned int offset, size_t size)
+{
+	struct pxafb_dma_descriptor *dma_desc, *pal_desc;
+	unsigned int dma_desc_off, pal_desc_off;

-	fbi->reg_lccr3 = fbi->lccr3 |
-		(var->sync & FB_SYNC_HOR_HIGH_ACT ?
-		 LCCR3_HorSnchH : LCCR3_HorSnchL) |
-		(var->sync & FB_SYNC_VERT_HIGH_ACT ?
-		 LCCR3_VrtSnchH : LCCR3_VrtSnchL);
+	if (dma < 0 || dma >= DMA_MAX)
+		return -EINVAL;

-	if (pcd) {
-		fbi->reg_lccr3 |= LCCR3_PixClkDiv(pcd);
-		set_hsync_time(fbi, pcd);
+	dma_desc = &fbi->dma_buff->dma_desc[dma];
+	dma_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[dma]);
+
+	dma_desc->fsadr = fbi->screen_dma + offset;
+	dma_desc->fidr  = 0;
+	dma_desc->ldcmd = size;
+
+	if (pal < 0 || pal >= PAL_MAX) {
+		dma_desc->fdadr = fbi->dma_buff_phys + dma_desc_off;
+		fbi->fdadr[dma] = fbi->dma_buff_phys + dma_desc_off;
+	} else {
+		pal_desc = &fbi->dma_buff->pal_desc[dma];
+		pal_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[pal]);
+
+		pal_desc->fsadr = fbi->dma_buff_phys + pal * PALETTE_SIZE;
+		pal_desc->fidr  = 0;
+
+		if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) == LCCR4_PAL_FOR_0)
+			pal_desc->ldcmd = fbi->palette_size * sizeof(u16);
+		else
+			pal_desc->ldcmd = fbi->palette_size * sizeof(u32);
+
+		pal_desc->ldcmd |= LDCMD_PAL;
+
+		/* flip back and forth between palette and frame buffer */
+		pal_desc->fdadr = fbi->dma_buff_phys + dma_desc_off;
+		dma_desc->fdadr = fbi->dma_buff_phys + pal_desc_off;
+		fbi->fdadr[dma] = fbi->dma_buff_phys + dma_desc_off;
 	}
+
+	return 0;
 }

 /*
@@ -856,12 +1097,8 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,
 	/* Update shadow copy atomically */
 	local_irq_save(flags);

-#ifdef CONFIG_FB_PXA_SMARTPANEL
-	if (fbi->lccr0 & LCCR0_LCDT)
-		setup_smart_timing(fbi, var);
-	else
-#endif
-		setup_parallel_timing(fbi, var);
+	/* setup timing */
+	fbi->output->setup(fbi, var);

 	fbi->reg_lccr0 = fbi->lccr0 |
 		(LCCR0_LDM | LCCR0_SFM | LCCR0_IUM | LCCR0_EFM |
@@ -979,9 +1216,6 @@ static void pxafb_enable_controller(struct pxafb_info *fbi)
 	/* enable LCD controller clock */
 	clk_enable(fbi->clk);

-	if (fbi->lccr0 & LCCR0_LCDT)
-		return;
-
 	/* Sequence from 11.7.10 */
 	lcd_writel(fbi, LCCR3, fbi->reg_lccr3);
 	lcd_writel(fbi, LCCR2, fbi->reg_lccr2);
@@ -990,29 +1224,13 @@ static void pxafb_enable_controller(struct
pxafb_info *fbi)

 	lcd_writel(fbi, FDADR0, fbi->fdadr[0]);
 	lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
-	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);
+
+	fbi->output->enable(fbi);
 }

 static void pxafb_disable_controller(struct pxafb_info *fbi)
 {
-	uint32_t lccr0;
-
-#ifdef CONFIG_FB_PXA_SMARTPANEL
-	if (fbi->lccr0 & LCCR0_LCDT) {
-		wait_for_completion_timeout(&fbi->refresh_done,
-				200 * HZ / 1000);
-		return;
-	}
-#endif
-
-	/* Clear LCD Status Register */
-	lcd_writel(fbi, LCSR, 0xffffffff);
-
-	lccr0 = lcd_readl(fbi, LCCR0) & ~LCCR0_LDM;
-	lcd_writel(fbi, LCCR0, lccr0);
-	lcd_writel(fbi, LCCR0, lccr0 | LCCR0_DIS);
-
-	wait_for_completion_timeout(&fbi->disable_done, 200 * HZ / 1000);
+	fbi->output->disable(fbi);

 	/* disable LCD controller clock */
 	clk_disable(fbi->clk);
@@ -1024,18 +1242,9 @@ static void pxafb_disable_controller(struct
pxafb_info *fbi)
 static irqreturn_t pxafb_handle_irq(int irq, void *dev_id)
 {
 	struct pxafb_info *fbi = dev_id;
-	unsigned int lccr0, lcsr = lcd_readl(fbi, LCSR);
+	uint32_t lcsr = lcd_readl(fbi, LCSR);

-	if (lcsr & LCSR_LDD) {
-		lccr0 = lcd_readl(fbi, LCCR0);
-		lcd_writel(fbi, LCCR0, lccr0 | LCCR0_LDM);
-		complete(&fbi->disable_done);
-	}
-
-#ifdef CONFIG_FB_PXA_SMARTPANEL
-	if (lcsr & LCSR_CMD_INT)
-		complete(&fbi->command_done);
-#endif
+	fbi->output->handle_irq(fbi, lcsr);

 	lcd_writel(fbi, LCSR, lcsr);
 	return IRQ_HANDLED;
@@ -1267,11 +1476,6 @@ static int __init pxafb_map_video_memory(struct
pxafb_info *fbi)
 		fbi->dma_buff = (void *) fbi->map_cpu;
 		fbi->dma_buff_phys = fbi->map_dma;
 		fbi->palette_cpu = (u16 *) fbi->dma_buff->palette;
-
-#ifdef CONFIG_FB_PXA_SMARTPANEL
-		fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
-		fbi->n_smart_cmds = 0;
-#endif
 	}

 	return fbi->map_cpu ? 0 : -ENOMEM;
@@ -1324,7 +1528,6 @@ static int pxafb_decode_mach_info(struct pxafb_info *fbi,
 		fbi->lccr0 = inf->lccr0;
 		fbi->lccr3 = inf->lccr3;
 		fbi->lccr4 = inf->lccr4;
-		return -EINVAL;
 	}

 	if (lcd_conn == LCD_MONO_STN_8BPP)
@@ -1335,6 +1538,12 @@ static int pxafb_decode_mach_info(struct pxafb_info *fbi,
 	fbi->lccr3 |= (lcd_conn & LCD_PCLK_EDGE_FALL)  ? LCCR3_PCP : 0;

 	pxafb_decode_mode_info(fbi, inf->modes, inf->num_modes);
+
+	if (fbi->lccr0 & LCCR0_LCDT)
+		pxafb_output_init(fbi, &pxafb_output_spi);
+	else
+		pxafb_output_init(fbi, &pxafb_output_ppi);
+
 	return 0;
 }

@@ -1343,7 +1552,6 @@ static struct pxafb_info * __init
pxafb_init_fbinfo(struct device *dev)
 	struct pxafb_info *fbi;
 	void *addr;
 	struct pxafb_mach_info *inf = dev->platform_data;
-	struct pxafb_mode_info *mode = inf->modes;

 	/* Alloc the pxafb_info and pseudo_palette in one step */
 	fbi = kmalloc(sizeof(struct pxafb_info) + sizeof(u32) * 16, GFP_KERNEL);
@@ -1391,11 +1599,6 @@ static struct pxafb_info * __init
pxafb_init_fbinfo(struct device *dev)
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, pxafb_task);
 	init_MUTEX(&fbi->ctrlr_sem);
-	init_completion(&fbi->disable_done);
-#ifdef CONFIG_FB_PXA_SMARTPANEL
-	init_completion(&fbi->command_done);
-	init_completion(&fbi->refresh_done);
-#endif

 	return fbi;
 }
@@ -1715,13 +1918,6 @@ static int __init pxafb_probe(struct
platform_device *dev)
 		goto failed_free_mem;
 	}

-#ifdef CONFIG_FB_PXA_SMARTPANEL
-	ret = pxafb_smart_init(fbi);
-	if (ret) {
-		dev_err(&dev->dev, "failed to initialize smartpanel\n");
-		goto failed_free_irq;
-	}
-#endif
 	/*
 	 * This makes sure that our colour bitfield
 	 * descriptors are correctly initialised.
diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index 8238dc8..b2660bd 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -52,15 +52,26 @@ enum {

 /* maximum palette size - 256 entries, each 4 bytes long */
 #define PALETTE_SIZE	(256 * 4)
-#define CMD_BUFF_SIZE	(1024 * 50)

 struct pxafb_dma_buff {
 	unsigned char palette[PAL_MAX * PALETTE_SIZE];
-	uint16_t cmd_buff[CMD_BUFF_SIZE];
 	struct pxafb_dma_descriptor pal_desc[PAL_MAX];
 	struct pxafb_dma_descriptor dma_desc[DMA_MAX];
 };

+/* Output Interface - e.g. Parallel Port or Smart Panel */
+struct pxafb_info;
+struct pxafb_output {
+	const char *name;
+	int	(*init)(struct pxafb_info *);
+	int	(*exit)(struct pxafb_info *);
+	int	(*check)(struct pxafb_info *, struct fb_var_screeninfo *);
+	int	(*setup)(struct pxafb_info *, struct fb_var_screeninfo *);
+	void	(*enable)(struct pxafb_info *);
+	void	(*disable)(struct pxafb_info *);
+	void	(*handle_irq)(struct pxafb_info *, uint32_t lcsr);
+};
+
 struct pxafb_info {
 	struct fb_info		fb;
 	struct device		*dev;
@@ -110,15 +121,8 @@ struct pxafb_info {
 	wait_queue_head_t	ctrlr_wait;
 	struct work_struct	task;

-	struct completion	disable_done;
-
-#ifdef CONFIG_FB_PXA_SMARTPANEL
-	uint16_t		*smart_cmds;
-	size_t			n_smart_cmds;
-	struct completion	command_done;
-	struct completion	refresh_done;
-	struct task_struct	*smart_thread;
-#endif
+	struct pxafb_output	*output;
+	void			*output_priv;

 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
-- 
1.5.4.3


Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
