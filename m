From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Sun, 27 Dec 2009 07:19:57 +0000
Subject: [PATCH 2.6.33-rc2 1/1] broadsheetfb: add multiple panel type support
Message-Id: <1261898397-22949-1-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Geert, Krzysztof, Andrew, fbdev friends,

This patch updates broadsheetfb to add support for multiple panel types. The
3.7" and 6" are known to work but the 9.7" is untested due to lack of
hardware. Please let me know your feedback.

Thanks,
jaya

This patch adds support for multiple panel types to broadsheetfb.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: adaplas@gmail.com
Cc: akpm@linux-foundation.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 arch/arm/mach-pxa/am300epd.c |    2 +-
 drivers/video/broadsheetfb.c |  127 ++++++++++++++++++++++++++++++++++++------
 include/video/broadsheetfb.h |    1 +
 3 files changed, 112 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
index 4bd10a1..993d75e 100644
--- a/arch/arm/mach-pxa/am300epd.c
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -288,7 +288,7 @@ int __init am300_init(void)
 }
 
 module_param(panel_type, uint, 0);
-MODULE_PARM_DESC(panel_type, "Select the panel type: 6, 8, 97");
+MODULE_PARM_DESC(panel_type, "Select the panel type: 37, 6, 97");
 
 MODULE_DESCRIPTION("board driver for am300 epd kit");
 MODULE_AUTHOR("Jaya Kumar");
diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index df9ccb9..8f01106 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -33,7 +33,60 @@
 
 #include <video/broadsheetfb.h>
 
-/* Display specific information */
+/* track panel specific parameters */
+struct panel_info {
+	int w;
+	int h;
+	u16 sdcfg;
+	u16 gdcfg;
+	u16 lutfmt;
+	u16 fsynclen;
+	u16 fendfbegin;
+	u16 lsynclen;
+	u16 lendlbegin;
+	u16 pixclk;
+};
+
+/* table of panel specific parameters to be indexed into by the board drivers */
+static struct panel_info panel_table[] = {
+	{	/* standard 6" on TFT backplane */
+		.w = 800,
+		.h = 600,
+		.sdcfg = (100 | (1 << 8) | (1 << 9)),
+		.gdcfg = 2,
+		.lutfmt = (4 | (1 << 7)),
+		.fsynclen = 4,
+		.fendfbegin = (10 << 8) | 4,
+		.lsynclen = 10,
+		.lendlbegin = (100 << 8) | 4,
+		.pixclk = 6,
+	},
+	{	/* custom 3.7" flexible on PET or steel */
+		.w = 320,
+		.h = 240,
+		.sdcfg = (67 | (0 << 8) | (0 << 9) | (0 << 10) | (0 << 12)),
+		.gdcfg = 3,
+		.lutfmt = (4 | (1 << 7)),
+		.fsynclen = 0,
+		.fendfbegin = (80 << 8) | 4,
+		.lsynclen = 10,
+		.lendlbegin = (80 << 8) | 20,
+		.pixclk = 14,
+	},
+	{	/* standard 9.7" on TFT backplane */
+		.w = 1200,
+		.h = 825,
+		.sdcfg = (100 | (1 << 8) | (1 << 9) | (0 << 10) | (0 << 12)),
+		.gdcfg = 2,
+		.lutfmt = (4 | (1 << 7)),
+		.fsynclen = 0,
+		.fendfbegin = (4 << 8) | 4,
+		.lsynclen = 4,
+		.lendlbegin = (60 << 8) | 10,
+		.pixclk = 3,
+	},
+};
+
 #define DPY_W 800
 #define DPY_H 600
 
@@ -160,6 +213,14 @@ static void broadsheet_write_reg(struct broadsheetfb_par *par, u16 reg,
 	par->board->set_ctl(par, BS_CS, 1);
 }
 
+static void broadsheet_write_reg32(struct broadsheetfb_par *par, u16 reg,
+					u32 data)
+{
+	broadsheet_write_reg(par, reg, cpu_to_le32(data) & 0xFFFF);
+	broadsheet_write_reg(par, reg + 2, (cpu_to_le32(data) >> 16) & 0xFFFF);
+}
+
+
 static u16 broadsheet_read_reg(struct broadsheetfb_par *par, u16 reg)
 {
 	broadsheet_send_command(par, reg);
@@ -170,24 +231,28 @@ static u16 broadsheet_read_reg(struct broadsheetfb_par *par, u16 reg)
 static void __devinit broadsheet_init_display(struct broadsheetfb_par *par)
 {
 	u16 args[5];
-
-	args[0] = DPY_W;
-	args[1] = DPY_H;
-	args[2] = (100 | (1 << 8) | (1 << 9)); /* sdcfg */
-	args[3] = 2; /* gdrv cfg */
-	args[4] = (4 | (1 << 7)); /* lut index format */
+	int xres = par->info->var.xres;
+	int yres = par->info->var.yres;
+
+	args[0] = panel_table[par->panel_index].w;
+	args[1] = panel_table[par->panel_index].h;
+	args[2] = panel_table[par->panel_index].sdcfg;
+	args[3] = panel_table[par->panel_index].gdcfg;
+	args[4] = panel_table[par->panel_index].lutfmt;
 	broadsheet_send_cmdargs(par, BS_CMD_INIT_DSPE_CFG, 5, args);
 
 	/* did the controller really set it? */
 	broadsheet_send_cmdargs(par, BS_CMD_INIT_DSPE_CFG, 5, args);
 
-	args[0] = 4; /* fsync len */
-	args[1] = (10 << 8) | 4; /* fend/fbegin len */
-	args[2] = 10; /* line sync len */
-	args[3] = (100 << 8) | 4; /* line end/begin len */
-	args[4] = 6; /* pixel clock cfg */
+	args[0] = panel_table[par->panel_index].fsynclen;
+	args[1] = panel_table[par->panel_index].fendfbegin;
+	args[2] = panel_table[par->panel_index].lsynclen;
+	args[3] = panel_table[par->panel_index].lendlbegin;
+	args[4] = panel_table[par->panel_index].pixclk;
 	broadsheet_send_cmdargs(par, BS_CMD_INIT_DSPE_TMG, 5, args);
 
+	broadsheet_write_reg32(par, 0x310, xres*yres*2);
+
 	/* setup waveform */
 	args[0] = 0x886;
 	args[1] = 0;
@@ -207,8 +272,9 @@ static void __devinit broadsheet_init_display(struct broadsheetfb_par *par)
 	args[0] = 0x154;
 	broadsheet_send_cmdargs(par, BS_CMD_WR_REG, 1, args);
 
-	broadsheet_burst_write(par, DPY_W*DPY_H/2,
-				(u16 *) par->info->screen_base);
+	broadsheet_burst_write(par, (panel_table[par->panel_index].w *
+					panel_table[par->panel_index].h)/2,
+					(u16 *) par->info->screen_base);
 
 	broadsheet_send_command(par, BS_CMD_LD_IMG_END);
 
@@ -277,8 +343,9 @@ static void broadsheetfb_dpy_update(struct broadsheetfb_par *par)
 
 	args[0] = 0x154;
 	broadsheet_send_cmdargs(par, BS_CMD_WR_REG, 1, args);
-	broadsheet_burst_write(par, DPY_W*DPY_H/2,
-				(u16 *) par->info->screen_base);
+	broadsheet_burst_write(par, (panel_table[par->panel_index].w *
+					panel_table[par->panel_index].h)/2,
+					(u16 *) par->info->screen_base);
 
 	broadsheet_send_command(par, BS_CMD_LD_IMG_END);
 
@@ -436,6 +503,8 @@ static int __devinit broadsheetfb_probe(struct platform_device *dev)
 	unsigned char *videomemory;
 	struct broadsheetfb_par *par;
 	int i;
+	int dpyw, dpyh;
+	int panel_index;
 
 	/* pick up board specific routines */
 	board = dev->dev.platform_data;
@@ -450,7 +519,24 @@ static int __devinit broadsheetfb_probe(struct platform_device *dev)
 	if (!info)
 		goto err;
 
-	videomemorysize = (DPY_W*DPY_H);
+	switch (board->get_panel_type()) {
+	case 37:
+		panel_index = 1;
+		break;
+	case 97:
+		panel_index = 2;
+		break;
+	case 6:
+	default:
+		panel_index = 0;
+		break;
+	}
+
+	dpyw = panel_table[panel_index].w;
+	dpyh = panel_table[panel_index].h;
+
+	videomemorysize = roundup((dpyw*dpyh), PAGE_SIZE);
+
 	videomemory = vmalloc(videomemorysize);
 	if (!videomemory)
 		goto err_fb_rel;
@@ -460,10 +546,17 @@ static int __devinit broadsheetfb_probe(struct platform_device *dev)
 	info->screen_base = (char *)videomemory;
 	info->fbops = &broadsheetfb_ops;
 
+	broadsheetfb_var.xres = dpyw;
+	broadsheetfb_var.yres = dpyh;
+	broadsheetfb_var.xres_virtual = dpyw;
+	broadsheetfb_var.yres_virtual = dpyh;
 	info->var = broadsheetfb_var;
+
+	broadsheetfb_fix.line_length = dpyw;
 	info->fix = broadsheetfb_fix;
 	info->fix.smem_len = videomemorysize;
 	par = info->par;
+	par->panel_index = panel_index;
 	par->info = info;
 	par->board = board;
 	par->write_reg = broadsheet_write_reg;
diff --git a/include/video/broadsheetfb.h b/include/video/broadsheetfb.h
index a758534..a2c2829 100644
--- a/include/video/broadsheetfb.h
+++ b/include/video/broadsheetfb.h
@@ -41,6 +41,7 @@ struct broadsheetfb_par {
 	void (*write_reg)(struct broadsheetfb_par *, u16 reg, u16 val);
 	u16 (*read_reg)(struct broadsheetfb_par *, u16 reg);
 	wait_queue_head_t waitq;
+	int panel_index;
 };
 
 /* board specific routines */
-- 
1.6.3.3

