From: Rongrong Zou <rongrongchau@outlook.com>
Date: Tue, 03 Nov 2015 13:54:57 +0000
Subject: [PATCH 2/3] Hisilicon graphic driver: add hardware cursor support to hisilicon hi1710 graphi chip
Message-Id: <BLU437-SMTP24E693DA7F7317CF67053AC32B0@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Rongrong Zou <zourongrong@huawei.com>

This patch implements hardware cursor.

Signed-off-by: Rongrong Zou <zourongrong@huawei.com>
---
 drivers/video/fbdev/hisilicon/Makefile      |   2 +-
 drivers/video/fbdev/hisilicon/hisi_cursor.c | 121 ++++++++++++++++++++++++++++
 drivers/video/fbdev/hisilicon/hisi_cursor.h |  11 +++
 drivers/video/fbdev/hisilicon/hisi_drv.c    |  88 ++++++++++++++++++++
 4 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_cursor.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_cursor.h

diff --git a/drivers/video/fbdev/hisilicon/Makefile b/drivers/video/fbdev/hisilicon/Makefile
index 540b6d2..5f478ed 100644
--- a/drivers/video/fbdev/hisilicon/Makefile
+++ b/drivers/video/fbdev/hisilicon/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_FB_HISILICON) += hisiliconfb.o
 
-hisiliconfb-y := hisi_drv.o hisi_hw.o hisi_chip.o
+hisiliconfb-y := hisi_drv.o hisi_hw.o hisi_cursor.o hisi_chip.o
 hisiliconfb-y += hisi_mode.o hisi_power.o
 
 hisiliconfb-objs := $(hisiliconfb-y)
diff --git a/drivers/video/fbdev/hisilicon/hisi_cursor.c b/drivers/video/fbdev/hisilicon/hisi_cursor.c
new file mode 100644
index 0000000..84b0156
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_cursor.c
@@ -0,0 +1,121 @@
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/screen_info.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+#include "hisi_drv.h"
+#include "hisi_cursor.h"
+#include "hisi_help.h"
+#include "hisi_reg.h"
+
+
+#define WRITE_REG(addr, data) writel((data), cursor->mmio + (addr))
+
+
+void hw_cursor_enable(struct hisi_cursor *cursor)
+{
+	u32 reg;
+
+	reg = FIELD_VALUE(0, HWC_ADDRESS, ADDRESS, cursor->offset) |
+		FIELD_SET(0, HWC_ADDRESS, EXT, LOCAL) |
+		FIELD_SET(0, HWC_ADDRESS, ENABLE, ENABLE);
+	WRITE_REG(HWC_ADDRESS, reg);
+}
+
+void hw_cursor_disable(struct hisi_cursor *cursor)
+{
+	WRITE_REG(HWC_ADDRESS, 0);
+}
+
+void hw_cursor_set_size(struct hisi_cursor *cursor, int w, int h)
+{
+	cursor->w = w;
+	cursor->h = h;
+}
+
+void hw_cursor_set_pos(struct hisi_cursor *cursor, int x, int y)
+{
+	u32 reg;
+
+	reg = FIELD_VALUE(0, HWC_LOCATION, Y, y) |
+		FIELD_VALUE(0, HWC_LOCATION, X, x);
+	WRITE_REG(HWC_LOCATION, reg);
+}
+
+void hw_cursor_set_color(struct hisi_cursor *cursor, u32 fg,  u32 bg)
+{
+	WRITE_REG(HWC_COLOR_12, (fg << 16)|(bg & 0xffff));
+	WRITE_REG(HWC_COLOR_3, 0xffe0);
+}
+
+void hw_cursor_set_data(struct hisi_cursor *cursor,
+			u16 rop, const u8 *pcol, const u8 *pmsk)
+{
+	struct hisifb_crtc *crtc;
+
+	int i, j, count, pitch, offset;
+	u8 color, mask, opr;
+	u16 data;
+	u16  *pbuffer, *pstart;
+
+	crtc = container_of(cursor, struct hisifb_crtc, cursor);
+	/*  in byte*/
+	pitch = cursor->w >> 3;
+
+	/* in byte	*/
+	count = pitch * cursor->h;
+
+	/* in ushort */
+	offset = cursor->maxW * 2 / 8 / 2;
+
+	data = 0;
+	pstart = (u16 *)cursor->vstart;
+	pbuffer = pstart;
+
+
+	for (i = 0; i < count; i++) {
+		color = *pcol++;
+		mask = *pmsk++;
+		data = 0;
+
+		/* either method below works well,
+		 * but method 2 shows no lag
+		 * and method 1 seems a bit wrong
+		 */
+
+		for (j = 0; j < 8; j++) {
+			if (mask & (0x80 >> j)) {
+				if (rop = ROP_XOR)
+					opr = mask ^ color;
+				else
+					opr = mask & color;
+
+				/* 2 stands for forecolor and 1 for backcolor */
+				data |= ((opr & (0x80 >> j)) ? 2 : 1) <<
+					(j * 2);
+			}
+		}
+
+		*pbuffer = data;
+
+		/* assume pitch is 1,2,4,8,...*/
+		if ((i+1) % pitch = 0) {
+			/* need a return */
+			pstart += offset;
+			pbuffer = pstart;
+		} else {
+			pbuffer++;
+		}
+	}
+}
diff --git a/drivers/video/fbdev/hisilicon/hisi_cursor.h b/drivers/video/fbdev/hisilicon/hisi_cursor.h
new file mode 100644
index 0000000..551b743
--- /dev/null
+++ b/drivers/video/fbdev/hisilicon/hisi_cursor.h
@@ -0,0 +1,11 @@
+#ifndef HISI_CURSOR_H__
+#define HISI_CURSOR_H__
+
+void hw_cursor_enable(struct hisi_cursor *cursor);
+void hw_cursor_disable(struct hisi_cursor *cursor);
+void hw_cursor_set_size(struct hisi_cursor *cursor, int w, int h);
+void hw_cursor_set_pos(struct hisi_cursor *cursor, int x, int y);
+void hw_cursor_set_color(struct hisi_cursor *cursor, u32 fg, u32 bg);
+void hw_cursor_set_data(struct hisi_cursor *cursor, u16 rop,
+						const u8 *data, const u8 *mask);
+#endif
diff --git a/drivers/video/fbdev/hisilicon/hisi_drv.c b/drivers/video/fbdev/hisilicon/hisi_drv.c
index 521a279..54231d3 100644
--- a/drivers/video/fbdev/hisilicon/hisi_drv.c
+++ b/drivers/video/fbdev/hisilicon/hisi_drv.c
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include "hisi_drv.h"
+#include "hisi_cursor.h"
 #include "hisi_hw.h"
 
 
@@ -37,6 +38,7 @@ static int hisifb_ops_set_par(struct fb_info *);
 static int hisifb_ops_setcolreg(unsigned, unsigned, unsigned,
 	unsigned, unsigned, struct fb_info *);
 static int hisifb_ops_blank(int, struct fb_info *);
+static int hisifb_ops_cursor(struct fb_info *, struct fb_cursor *);
 
 typedef void (*PROC_SPEC_SETUP)(struct hisi_share *, char *);
 typedef int (*PROC_SPEC_MAP)(struct hisi_share *, struct pci_dev *);
@@ -128,6 +130,63 @@ static struct pci_driver hisifb_driver = {
 #endif
 };
 
+static int hisifb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
+{
+	struct hisifb_par *par;
+	struct hisifb_crtc *crtc;
+	struct hisi_cursor *cursor;
+
+	par = info->par;
+	crtc = &par->crtc;
+	cursor = &crtc->cursor;
+
+	if (fbcursor->image.width > cursor->maxW ||
+		fbcursor->image.height > cursor->maxH ||
+		 fbcursor->image.depth > 1){
+		return -ENXIO;
+	}
+
+	cursor->disable(cursor);
+	if (fbcursor->set & FB_CUR_SETSIZE)
+		cursor->set_size(cursor, fbcursor->image.width,
+				 fbcursor->image.height);
+
+
+	if (fbcursor->set & FB_CUR_SETPOS)
+		cursor->set_pos(cursor, fbcursor->image.dx - info->var.xoffset,
+				fbcursor->image.dy - info->var.yoffset);
+
+	if (fbcursor->set & FB_CUR_SETCMAP) {
+		/* get the 16bit color of kernel means */
+		u16 fg, bg;
+
+		fg +		((info->cmap.red[fbcursor->image.fg_color] & 0xf800)) |
+		((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5)|
+		((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
+
+		bg +		((info->cmap.red[fbcursor->image.bg_color] & 0xf800))|
+		((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5)|
+		((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
+
+		cursor->set_color(cursor, fg, bg);
+	}
+
+
+	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
+		cursor->set_data(cursor,
+				 fbcursor->rop,
+				 fbcursor->image.data,
+				 fbcursor->mask);
+	}
+
+	if (fbcursor->enable)
+		cursor->enable(cursor);
+
+	return 0;
+}
+
 static struct fb_ops hisifb_ops = {
 	.owner = THIS_MODULE,
 	.fb_check_var =  hisifb_ops_check_var,
@@ -138,6 +197,8 @@ static struct fb_ops hisifb_ops = {
 	.fb_fillrect = cfb_fillrect,
 	.fb_imageblit = cfb_imageblit,
 	.fb_copyarea = cfb_copyarea,
+	/* cursor */
+	.fb_cursor = hisifb_ops_cursor,
 };
 
 #ifdef CONFIG_PM
@@ -621,6 +682,33 @@ static int hisifb_set_fbinfo(struct fb_info *info, int index)
 	output->channel = &crtc->channel;
 	hisifb_set_drv(par);
 
+	/*
+	 * Set current cursor variable and proc pointer,
+	 * must be set after crtc member initialized.
+	 */
+	crtc->cursor.offset = crtc->oscreen +
+		crtc->vidmem_size - 1024;
+	crtc->cursor.mmio = share->pvreg + 0x800f0 +
+		(int)crtc->channel * 0x140;
+
+	inf_msg("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
+	crtc->cursor.maxH = crtc->cursor.maxW = 64;
+	crtc->cursor.size = crtc->cursor.maxH *
+		crtc->cursor.maxW * 2 / 8;
+	crtc->cursor.disable = hw_cursor_disable;
+	crtc->cursor.enable = hw_cursor_enable;
+	crtc->cursor.set_color = hw_cursor_set_color;
+	crtc->cursor.set_pos = hw_cursor_set_pos;
+	crtc->cursor.set_size = hw_cursor_set_size;
+	crtc->cursor.set_data = hw_cursor_set_data;
+	crtc->cursor.vstart = crtc->vscreen + crtc->cursor.offset;
+
+	crtc->cursor.share = share;
+	if (!g_hwcursor) {
+		hisifb_ops.fb_cursor = NULL;
+		crtc->cursor.disable(&crtc->cursor);
+	}
+
 	/* set info->fbops, must be set before fb_find_mode */
 
 	info->fbops = &hisifb_ops;
-- 
1.9.1

