From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Sat, 28 Apr 2012 10:21:12 +0000
Subject: [PATCH 3/4] video: auo_k190x: add driver for AUO-K1900 variant
Message-Id: <201204281221.12330.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

This controller only supports smaller resolutions and only serial
updates, i.e. it has to wait for an update to finish before
starting another one.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/Kconfig       |    8 ++
 drivers/video/Makefile      |    1 +
 drivers/video/auo_k1900fb.c |  198 +++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 207 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/auo_k1900fb.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 31c029b..148d83c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2399,6 +2399,14 @@ config FB_AUO_K190X
 	  controller drivers. You will also have to enable the driver
 	  for the controller type used in your device.
=20
+config FB_AUO_K1900
+	tristate "AUO-K1900 EPD controller support"
+	depends on FB && FB_AUO_K190X
+	help
+	  This driver implements support for the AUO K1900 epd-controller.
+	  This controller can drive Sipix epaper displays but can only do
+	  serial updates, reducing the number of possible frames per second.
+
 config FB_JZ4740
 	tristate "JZ4740 LCD framebuffer support"
 	depends on FB && MACH_JZ4740
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index d5406f2..e84df73 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_FB_MAXINE)		  +=3D maxinefb.o
 obj-$(CONFIG_FB_METRONOME)        +=3D metronomefb.o
 obj-$(CONFIG_FB_BROADSHEET)       +=3D broadsheetfb.o
 obj-$(CONFIG_FB_AUO_K190X)	  +=3D auo_k190x.o
+obj-$(CONFIG_FB_AUO_K1900)	  +=3D auo_k1900fb.o
 obj-$(CONFIG_FB_S1D13XXX)	  +=3D s1d13xxxfb.o
 obj-$(CONFIG_FB_SH7760)		  +=3D sh7760fb.o
 obj-$(CONFIG_FB_IMX)              +=3D imxfb.o
diff --git a/drivers/video/auo_k1900fb.c b/drivers/video/auo_k1900fb.c
new file mode 100644
index 0000000..c36cf96
--- /dev/null
+++ b/drivers/video/auo_k1900fb.c
@@ -0,0 +1,198 @@
+/*
+ * auok190xfb.c -- FB driver for AUO-K1900 controllers
+ *
+ * Copyright (C) 2011, 2012 Heiko Stuebner <heiko@sntech.de>
+ *
+ * based on broadsheetfb.c
+ *
+ * Copyright (C) 2008, Jaya Kumar
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Layout is based on skeletonfb.c by James Simmons and Geert Uytterhoeven.
+ *
+ * This driver is written to be used with the AUO-K1900 display controller.
+ *
+ * It is intended to be architecture independent. A board specific driver
+ * must be used to perform all the physical IO interactions.
+ *
+ * The controller supports different update modes:
+ * mode0+1 16 step gray (4bit)
+ * mode2 4 step gray (2bit) - FIXME: add strange refresh
+ * mode3 2 step gray (1bit) - FIXME: add strange refresh
+ * mode4 handwriting mode (strange behaviour)
+ * mode5 automatic selection of update mode
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/firmware.h>
+#include <linux/gpio.h>
+#include <linux/pm_runtime.h>
+
+#include <video/auo_k190xfb.h>
+
+#include "auo_k190x.h"
+
+/*
+ * AUO-K1900 specific commands
+ */
+
+#define AUOK1900_CMD_PARTIALDISP	0x1001
+#define AUOK1900_CMD_ROTATION		0x1006
+#define AUOK1900_CMD_LUT_STOP		0x1009
+
+#define AUOK1900_INIT_TEMP_AVERAGE	(1 << 13)
+#define AUOK1900_INIT_ROTATE(_x)	((_x & 0x3) << 10)
+#define AUOK1900_INIT_RESOLUTION(_res)	((_res & 0x7) << 2)
+
+static void auok1900_init(struct auok190xfb_par *par)
+{
+	struct auok190x_board *board =3D par->board;
+	u16 init_param =3D 0;
+
+	init_param |=3D AUOK1900_INIT_TEMP_AVERAGE;
+	init_param |=3D AUOK1900_INIT_ROTATE(par->rotation);
+	init_param |=3D AUOK190X_INIT_INVERSE_WHITE;
+	init_param |=3D AUOK190X_INIT_FORMAT0;
+	init_param |=3D AUOK1900_INIT_RESOLUTION(par->resolution);
+	init_param |=3D AUOK190X_INIT_SHIFT_RIGHT;
+
+	auok190x_send_cmdargs(par, AUOK190X_CMD_INIT, 1, &init_param);
+
+	/* let the controller finish */
+	board->wait_for_rdy(par);
+}
+
+static void auok1900_update_region(struct auok190xfb_par *par, int mode,
+						u16 y1, u16 y2)
+{
+	struct device *dev =3D par->info->device;
+	unsigned char *buf =3D (unsigned char *)par->info->screen_base;
+	int xres =3D par->info->var.xres;
+	u16 args[4];
+
+	pm_runtime_get_sync(dev);
+
+	mutex_lock(&(par->io_lock));
+
+	/* y1 and y2 must be a multiple of 2 so drop the lowest bit */
+	y1 &=3D 0xfffe;
+	y2 &=3D 0xfffe;
+
+	dev_dbg(dev, "update (x,y,w,h,mode)=3D(%d,%d,%d,%d,%d)\n",
+		1, y1+1, xres, y2-y1, mode);
+
+	/* to FIX handle different partial update modes */
+	args[0] =3D mode | 1;
+	args[1] =3D y1 + 1;
+	args[2] =3D xres;
+	args[3] =3D y2 - y1;
+	buf +=3D y1 * xres;
+	auok190x_send_cmdargs_pixels(par, AUOK1900_CMD_PARTIALDISP, 4, args,
+				     ((y2 - y1) * xres)/2, (u16 *) buf);
+	auok190x_send_command(par, AUOK190X_CMD_DATA_STOP);
+
+	par->update_cnt++;
+
+	mutex_unlock(&(par->io_lock));
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+
+static void auok1900fb_dpy_update_pages(struct auok190xfb_par *par,
+						u16 y1, u16 y2)
+{
+	int mode;
+
+	if (par->update_mode < 0) {
+		mode =3D AUOK190X_UPDATE_MODE(1);
+		par->last_mode =3D -1;
+	} else {
+		mode =3D AUOK190X_UPDATE_MODE(par->update_mode);
+		par->last_mode =3D par->update_mode;
+	}
+
+	if (par->flash)
+		mode |=3D AUOK190X_UPDATE_NONFLASH;
+
+	auok1900_update_region(par, mode, y1, y2);
+}
+
+static void auok1900fb_dpy_update(struct auok190xfb_par *par)
+{
+	int mode;
+
+	if (par->update_mode < 0) {
+		mode =3D AUOK190X_UPDATE_MODE(0);
+		par->last_mode =3D -1;
+	} else {
+		mode =3D AUOK190X_UPDATE_MODE(par->update_mode);
+		par->last_mode =3D par->update_mode;
+	}
+
+	if (par->flash)
+		mode |=3D AUOK190X_UPDATE_NONFLASH;
+
+	auok1900_update_region(par, mode, 0, par->info->var.yres);
+	par->update_cnt =3D 0;
+}
+
+static bool auok1900fb_need_refresh(struct auok190xfb_par *par)
+{
+	return (par->update_cnt > 10);
+}
+
+static int __devinit auok1900fb_probe(struct platform_device *pdev)
+{
+	struct auok190x_init_data init;
+	struct auok190x_board *board;
+
+	/* pick up board specific routines */
+	board =3D pdev->dev.platform_data;
+	if (!board)
+		return -EINVAL;
+
+	/* fill temporary init struct for common init */
+	init.id =3D "auo_k1900fb";
+	init.board =3D board;
+	init.update_partial =3D auok1900fb_dpy_update_pages;
+	init.update_all =3D auok1900fb_dpy_update;
+	init.need_refresh =3D auok1900fb_need_refresh;
+	init.init =3D auok1900_init;
+
+	return auok190x_common_probe(pdev, &init);
+}
+
+static int __devexit auok1900fb_remove(struct platform_device *pdev)
+{
+	return auok190x_common_remove(pdev);
+}
+
+static struct platform_driver auok1900fb_driver =3D {
+	.probe	=3D auok1900fb_probe,
+	.remove =3D __devexit_p(auok1900fb_remove),
+	.driver	=3D {
+		.owner	=3D THIS_MODULE,
+		.name	=3D "auo_k1900fb",
+		.pm =3D &auok190x_pm,
+	},
+};
+module_platform_driver(auok1900fb_driver);
+
+MODULE_DESCRIPTION("framebuffer driver for the AUO-K1900 EPD controller");
+MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
+MODULE_LICENSE("GPL");
--=20
1.7.5.4

