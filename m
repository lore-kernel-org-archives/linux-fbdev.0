From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/8] fbcon: Console Rotation - Add support to rotate font
 bitmap
Date: Mon, 07 Nov 2005 19:05:07 +0800
Message-ID: <436F34E3.20304@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5As-0004S9-B1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:30 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5Ar-0006Hq-Ml
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:30 -0800
Received: by xproxy.gmail.com with SMTP id i28so364656wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:28:29 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add support to rotate the font bitmap. To save on processing time, the
entire fontdata will be rotated on a console switch, then stored in a
buffer private to fbcon.  To further save on processing, the fontdata will
only be rotated if the font has changed or if the angle of rotation has
changed.  Only a single copy of the rotated fontdata will be kept.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 Makefile       |    3 +
 fbcon.h        |    4 ++
 fbcon_rotate.c |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fbcon_rotate.h |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+)


diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
index 5222628..4532bdf 100644
--- a/drivers/video/console/Makefile
+++ b/drivers/video/console/Makefile
@@ -31,6 +31,9 @@ obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbc
 ifeq ($(CONFIG_FB_TILEBLITTING),y)
 obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += tileblit.o
 endif
+ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
+obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_rotate.o
+endif
 
 obj-$(CONFIG_FB_STI)              += sticore.o font.o
 
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index 846a5a4..accfd7b 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -215,7 +215,11 @@ static inline int get_attribute(struct f
         (void) (&_r == &_v); \
         (i == FB_ROTATE_UR || i == FB_ROTATE_UD) ? _r : _v; })
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+extern void fbcon_set_rotate(struct fbcon_ops *ops);
+#else
 #define fbcon_set_rotate(x) do {} while(0)
+#endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
 
 #endif /* _VIDEO_FBCON_H */
 
diff --git a/drivers/video/console/fbcon_rotate.c b/drivers/video/console/fbcon_rotate.c
new file mode 100644
index 0000000..6a96931
--- /dev/null
+++ b/drivers/video/console/fbcon_rotate.c
@@ -0,0 +1,105 @@
+/*
+ *  linux/drivers/video/console/fbcon_rotate.c -- Software Rotation
+ *
+ *      Copyright (C) 2005 Antonino Daplas <adaplas @pol.net>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <linux/vt_kern.h>
+#include <linux/console.h>
+#include <asm/types.h>
+#include "fbcon.h"
+#include "fbcon_rotate.h"
+
+static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc,
+			     struct display *p)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+	int len, err = 0;
+	int s_cellsize, d_cellsize, i;
+	const u8 *src;
+	u8 *dst;
+
+	if (vc->vc_font.data == ops->fontdata &&
+	    p->con_rotate == ops->cur_rotate)
+		goto finished;
+
+	src = ops->fontdata = vc->vc_font.data;
+	ops->cur_rotate = p->con_rotate;
+	len = (!p->userfont) ? 256 : FNTCHARCNT(src);
+	s_cellsize = ((vc->vc_font.width + 7)/8) *
+		vc->vc_font.height;
+	d_cellsize = s_cellsize;
+
+	if (ops->rotate == FB_ROTATE_CW ||
+	    ops->rotate == FB_ROTATE_CCW)
+		d_cellsize = ((vc->vc_font.height + 7)/8) *
+			vc->vc_font.width;
+
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
+
+	if (ops->fd_size < d_cellsize * len) {
+		dst = kmalloc(d_cellsize * len, GFP_KERNEL);
+
+		if (dst == NULL) {
+			err = -ENOMEM;
+			goto finished;
+		}
+
+		ops->fd_size = d_cellsize * len;
+		kfree(ops->fontbuffer);
+		ops->fontbuffer = dst;
+	}
+
+	dst = ops->fontbuffer;
+	memset(dst, 0, ops->fd_size);
+
+	switch (ops->rotate) {
+	case FB_ROTATE_UD:
+		for (i = len; i--; ) {
+			rotate_ud(src, dst, vc->vc_font.width,
+				  vc->vc_font.height);
+
+			src += s_cellsize;
+			dst += d_cellsize;
+		}
+		break;
+	case FB_ROTATE_CW:
+		for (i = len; i--; ) {
+			rotate_cw(src, dst, vc->vc_font.width,
+				  vc->vc_font.height);
+			src += s_cellsize;
+			dst += d_cellsize;
+		}
+		break;
+	case FB_ROTATE_CCW:
+		for (i = len; i--; ) {
+			rotate_ccw(src, dst, vc->vc_font.width,
+				   vc->vc_font.height);
+			src += s_cellsize;
+			dst += d_cellsize;
+		}
+		break;
+	}
+
+finished:
+	return err;
+}
+
+void fbcon_set_rotate(struct fbcon_ops *ops)
+{
+	ops->rotate_font = fbcon_rotate_font;
+}
+EXPORT_SYMBOL(fbcon_set_rotate);
+
+MODULE_AUTHOR("Antonino Daplas <adaplas@pol.net>");
+MODULE_DESCRIPTION("Console Rotation Support");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/console/fbcon_rotate.h b/drivers/video/console/fbcon_rotate.h
new file mode 100644
index 0000000..d8acd6d
--- /dev/null
+++ b/drivers/video/console/fbcon_rotate.h
@@ -0,0 +1,102 @@
+/*
+ *  linux/drivers/video/console/fbcon_rotate.h -- Software Display Rotation
+ *
+ *	Copyright (C) 2005 Antonino Daplas <adaplas@pol.net>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive
+ *  for more details.
+ */
+
+#ifndef _FBCON_ROTATE_H
+#define _FBCON_ROTATE_H
+
+#define FNTCHARCNT(fd)	(((int *)(fd))[-3])
+
+#define GETVYRES(s,i) ({                           \
+        (s == SCROLL_REDRAW || s == SCROLL_MOVE) ? \
+        (i)->var.yres : (i)->var.yres_virtual; })
+
+#define GETVXRES(s,i) ({                           \
+        (s == SCROLL_REDRAW || s == SCROLL_MOVE || !(i)->fix.xpanstep) ? \
+        (i)->var.xres : (i)->var.xres_virtual; })
+
+/*
+ * The bitmap is always big endian
+ */
+#if defined(__LITTLE_ENDIAN)
+#define FBCON_BIT(b) (7 - (b))
+#else
+#define FBCON_BIT(b) (b)
+#endif
+
+static inline int pattern_test_bit(u32 x, u32 y, u32 pitch, const char *pat)
+{
+	u32 tmp = (y * pitch) + x, index = tmp / 8,  bit = tmp % 8;
+
+	pat +=index;
+	return (test_bit(FBCON_BIT(bit), (void *)pat));;
+}
+
+static inline void pattern_set_bit(u32 x, u32 y, u32 pitch, char *pat)
+{
+	u32 tmp = (y * pitch) + x, index = tmp / 8, bit = tmp % 8;
+
+	pat += index;
+	set_bit(FBCON_BIT(bit), (void *)pat);
+}
+
+static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
+{
+	int i, j;
+	int shift = width % 8;
+
+	width = (width + 7) & ~7;
+
+	for (i = 0; i < height; i++) {
+		for (j = 0; j < width; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(width - (1 + j + shift),
+						height - (1 + i),
+						width, out);
+		}
+
+	}
+}
+
+static inline void rotate_cw(const char *in, char *out, u32 width, u32 height)
+{
+	int i, j, h = height, w = width;
+	int shift = (8 - (height % 8)) & 7;
+
+	width = (width + 7) & ~7;
+	height = (height + 7) & ~7;
+
+	for (i = 0; i < h; i++) {
+		for (j = 0; j < w; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(height - 1 - i - shift, j,
+						height, out);
+
+		}
+	}
+}
+
+static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
+{
+	int i, j, h = height, w = width;
+	int shift = width % 8;
+
+	width = (width + 7) & ~7;
+	height = (height + 7) & ~7;
+
+	for (i = 0; i < h; i++) {
+		for (j = 0; j < w; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(i, width - 1 - j - shift,
+						height, out);
+		}
+	}
+}
+
+#endif



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
