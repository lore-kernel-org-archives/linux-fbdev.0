From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Apr 2020 15:55:46 +0000
Subject: [PATCH 1/8] fbdev: w100fb: clean up mach-pxa compile-time dependency
Message-Id: <20200417155553.675905-2-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-fbdev@vger.kernel.org
Cc: marex@denx.de, dsd@laptop.org, Arnd Bergmann <arnd@arndb.de>, Andrzej Hajda <a.hajda@samsung.com>, airlied@linux.ie, masahiroy@kernel.org, Nicolas Pitre <nico@fluxnic.net>, Saeed Mahameed <saeedm@mellanox.com>, thellstrom@vmware.com, haojian.zhuang@gmail.com, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, kieran.bingham+renesas@ideasonboard.com, linux-graphics-maintainer@vmware.com, Laurent.pinchart@ideasonboard.com, jfrederich@gmail.com, robert.jarzmik@free.fr, daniel@zonque.org

In order to get rid of the 'select FB' line in Kconfig for all platforms,
change the w100fb driver to handle the gpio lines itself rather than
using an indirect function call.

This also allows removing the remaining exported interfaces from the
driver, the only other symbol has been unused for a long time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/pxa_defconfig |  2 +
 arch/arm/mach-pxa/Kconfig      |  3 --
 arch/arm/mach-pxa/eseries.c    | 14 +-----
 drivers/video/fbdev/w100fb.c   | 84 +++++-----------------------------
 include/video/w100fb.h         |  6 +--
 5 files changed, 16 insertions(+), 93 deletions(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index b817c57f05f1..8df88e8a3048 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -454,6 +454,8 @@ CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_SOC_CAMERA_MT9M111=m
 CONFIG_DRM=m
 CONFIG_FIRMWARE_EDID=y
+CONFIG_FB=y
+CONFIG_FB_W100=y
 CONFIG_FB_TILEBLITTING=y
 CONFIG_FB_PXA_OVERLAY=y
 CONFIG_FB_PXA_PARAMETERS=y
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f60bc29aef68..8444d40df1b3 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -549,9 +549,6 @@ config MACH_ICONTROL
 
 config ARCH_PXA_ESERIES
 	bool "PXA based Toshiba e-series PDAs"
-	select FB_W100
-	select FB
-	select PXA25x
 
 config MACH_E330
 	bool "Toshiba e330"
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index f37c44b6139d..023ee901a7eb 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -849,20 +849,8 @@ static struct w100_mem_info e800_w100_mem_info = {
 	.size            = 0x1fffff,
 };
 
-static void e800_tg_change(struct w100fb_par *par)
-{
-	unsigned long tmp;
-
-	tmp = w100fb_gpio_read(W100_GPIO_PORT_A);
-	if (par->mode->xres = 480)
-		tmp |= 0x100;
-	else
-		tmp &= ~0x100;
-	w100fb_gpio_write(W100_GPIO_PORT_A, tmp);
-}
-
 static struct w100_tg_info e800_tg_info = {
-	.change = e800_tg_change,
+	.change_e800 = true,
 };
 
 static struct w100fb_mach_info e800_fb_info = {
diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index 2d6e2738b792..512c4d5a73a3 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -48,7 +48,6 @@ static void w100_init_lcd(struct w100fb_par*);
 static void w100_set_dispregs(struct w100fb_par*);
 static void w100_update_enable(void);
 static void w100_update_disable(void);
-static void calc_hsync(struct w100fb_par *par);
 static void w100_init_graphic_engine(struct w100fb_par *par);
 struct w100_pll_info *w100_get_xtal_table(unsigned int freq);
 
@@ -101,8 +100,6 @@ static ssize_t flip_store(struct device *dev, struct device_attribute *attr, con
 	w100_set_dispregs(par);
 	w100_update_enable();
 
-	calc_hsync(par);
-
 	return count;
 }
 
@@ -157,7 +154,6 @@ static ssize_t fastpllclk_store(struct device *dev, struct device_attribute *att
 	}
 
 	w100_init_clocks(par);
-	calc_hsync(par);
 
 	return count;
 }
@@ -173,23 +169,6 @@ static struct attribute *w100fb_attrs[] = {
 };
 ATTRIBUTE_GROUPS(w100fb);
 
-/*
- * Some touchscreens need hsync information from the video driver to
- * function correctly. We export it here.
- */
-unsigned long w100fb_get_hsynclen(struct device *dev)
-{
-	struct fb_info *info = dev_get_drvdata(dev);
-	struct w100fb_par *par=info->par;
-
-	/* If display is blanked/suspended, hsync isn't active */
-	if (par->blanked)
-		return 0;
-	else
-		return par->hsync_len;
-}
-EXPORT_SYMBOL(w100fb_get_hsynclen);
-
 static void w100fb_clear_screen(struct w100fb_par *par)
 {
 	memset_io(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), 0, (par->xres * par->yres * BITS_PER_PIXEL/8));
@@ -405,6 +384,15 @@ static void w100fb_copyarea(struct fb_info *info,
 	writel((w << 16) | (h & 0xffff), remapped_regs + mmDST_WIDTH_HEIGHT);
 }
 
+static void w100fb_e800_tg_change(struct w100fb_par *par)
+{
+	u32 tmp = readl(remapped_regs + mmGPIO_DATA);
+	if (par->mode->xres = 480)
+		tmp |= 0x100;
+	else
+		tmp &= ~0x100;
+	writel(tmp, remapped_regs + mmGPIO_DATA);
+}
 
 /*
  *  Change the resolution by calling the appropriate hardware functions
@@ -425,10 +413,9 @@ static void w100fb_activate_var(struct w100fb_par *par)
 	w100_update_enable();
 	w100_init_graphic_engine(par);
 
-	calc_hsync(par);
-
-	if (!par->blanked && tg && tg->change)
-		tg->change(par);
+	if (IS_ENABLED(CONFIG_ARCH_PXA_ESERIES) &&
+	    !par->blanked && tg && tg->change_e800)
+		w100fb_e800_tg_change(par);
 }
 
 
@@ -837,28 +824,6 @@ static void w100_update_enable(void)
 	writel((u32) (disp_db_buf_wr_cntl.val), remapped_regs + mmDISP_DB_BUF_CNTL);
 }
 
-unsigned long w100fb_gpio_read(int port)
-{
-	unsigned long value;
-
-	if (port=W100_GPIO_PORT_A)
-		value = readl(remapped_regs + mmGPIO_DATA);
-	else
-		value = readl(remapped_regs + mmGPIO_DATA2);
-
-	return value;
-}
-
-void w100fb_gpio_write(int port, unsigned long value)
-{
-	if (port=W100_GPIO_PORT_A)
-		writel(value, remapped_regs + mmGPIO_DATA);
-	else
-		writel(value, remapped_regs + mmGPIO_DATA2);
-}
-EXPORT_SYMBOL(w100fb_gpio_read);
-EXPORT_SYMBOL(w100fb_gpio_write);
-
 /*
  * Initialization of critical w100 hardware
  */
@@ -1497,31 +1462,6 @@ static void w100_set_dispregs(struct w100fb_par *par)
 	writel((par->xres*BITS_PER_PIXEL/8), remapped_regs + mmGRAPHIC_PITCH);
 }
 
-
-/*
- * Work out how long the sync pulse lasts
- * Value is 1/(time in seconds)
- */
-static void calc_hsync(struct w100fb_par *par)
-{
-	unsigned long hsync;
-	struct w100_mode *mode = par->mode;
-	union crtc_ss_u crtc_ss;
-
-	if (mode->pixclk_src = CLK_SRC_XTAL)
-		hsync=par->mach->xtal_freq;
-	else
-		hsync=((par->fastpll_mode && mode->fast_pll_freq) ? mode->fast_pll_freq : mode->pll_freq)*100000;
-
-	hsync /= (w100_pwr_state.pclk_cntl.f.pclk_post_div + 1);
-
-	crtc_ss.val = readl(remapped_regs + mmCRTC_SS);
-	if (crtc_ss.val)
-		par->hsync_len = hsync / (crtc_ss.f.ss_end-crtc_ss.f.ss_start);
-	else
-		par->hsync_len = 0;
-}
-
 static void w100_suspend(u32 mode)
 {
 	u32 val;
diff --git a/include/video/w100fb.h b/include/video/w100fb.h
index a614654d8598..8f260ba4fcac 100644
--- a/include/video/w100fb.h
+++ b/include/video/w100fb.h
@@ -14,13 +14,9 @@
 
 struct w100fb_par;
 
-unsigned long w100fb_gpio_read(int port);
-void w100fb_gpio_write(int port, unsigned long value);
-unsigned long w100fb_get_hsynclen(struct device *dev);
-
 /* LCD Specific Routines and Config */
 struct w100_tg_info {
-	void (*change)(struct w100fb_par*);
+	bool change_e800;
 	void (*suspend)(struct w100fb_par*);
 	void (*resume)(struct w100fb_par*);
 };
-- 
2.26.0
