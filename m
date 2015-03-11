From: Davor Joja <davorjoja@logicbricks.com>
Date: Wed, 11 Mar 2015 15:27:08 +0000
Subject: [PATCH 07/10] uapi: linux: Xylon framebuffer driver header file
Message-Id: <475f3ca4-2c0a-4c98-96bf-2831b5396966@mail.xylon.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426087631-9952-1-git-send-email-davorjoja@logicbricks.com>
In-Reply-To: <1426087631-9952-1-git-send-email-davorjoja@logicbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, geert@linux-m68k.org
Cc: Davor Joja <davorjoja@logicbricks.com>

Driver header file containing structures and IOCTLs for user space
applications to be able to use advanced logiCVC hw functionality.

Signed-off-by: Davor Joja <davorjoja@logicbricks.com>
---
 include/uapi/linux/xylonfb.h | 85 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 include/uapi/linux/xylonfb.h

diff --git a/include/uapi/linux/xylonfb.h b/include/uapi/linux/xylonfb.h
new file mode 100644
index 0000000..662c02f
--- /dev/null
+++ b/include/uapi/linux/xylonfb.h
@@ -0,0 +1,85 @@
+/*
+ * Xylon logiCVC frame buffer driver IOCTL parameters
+ *
+ * Copyright (C) 2015 Xylon d.o.o.
+ * Author: Davor Joja <davor.joja@logicbricks.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __XYLONFB_H__
+#define __XYLONFB_H__
+
+#include <linux/types.h>
+
+struct xylonfb_hw_access {
+	__u32 offset;
+	__u32 value;
+	bool set;
+};
+
+/* Used only with logiCVC 3.x */
+struct xylonfb_layer_buffer {
+	__u8 id;
+	bool set;
+};
+
+struct xylonfb_layer_color {
+	__u32 raw_rgb;
+	__u8 use_raw;
+	__u8 r;
+	__u8 g;
+	__u8 b;
+	bool set;
+};
+
+struct xylonfb_layer_geometry {
+	__u16 x;
+	__u16 y;
+	__u16 width;
+	__u16 height;
+	__u16 x_offset;
+	__u16 y_offset;
+	bool set;
+};
+
+struct xylonfb_layer_transparency {
+	__u8 alpha;
+	bool set;
+};
+
+/* Xylon FB IOCTL's */
+#define XYLONFB_IOW(num, dtype)		_IOW('x', num, dtype)
+#define XYLONFB_IOR(num, dtype)		_IOR('x', num, dtype)
+#define XYLONFB_IOWR(num, dtype)	_IOWR('x', num, dtype)
+#define XYLONFB_IO(num)			_IO('x', num)
+
+#define XYLONFB_VSYNC_CTRL		XYLONFB_IOR(30, bool)
+#define XYLONFB_LAYER_IDX		XYLONFB_IOR(31, unsigned int)
+#define XYLONFB_LAYER_ALPHA		\
+	XYLONFB_IOR(32, struct xylonfb_layer_transparency)
+#define XYLONFB_LAYER_COLOR_TRANSP_CTRL	XYLONFB_IOW(33, bool)
+#define XYLONFB_LAYER_COLOR_TRANSP \
+	XYLONFB_IOR(34, struct xylonfb_layer_color)
+#define XYLONFB_LAYER_GEOMETRY \
+	XYLONFB_IOR(35, struct xylonfb_layer_geometry)
+#define XYLONFB_LAYER_BUFFER \
+	XYLONFB_IOR(36, struct xylonfb_layer_buffer)
+#define XYLONFB_LAYER_BUFFER_OFFSET	XYLONFB_IOR(37, unsigned int)
+#define XYLONFB_BACKGROUND_COLOR \
+	XYLONFB_IOR(38, struct xylonfb_layer_color)
+#define XYLONFB_LAYER_EXT_BUFF_SWITCH	XYLONFB_IOW(39, bool)
+#define XYLONFB_HW_ACCESS \
+	XYLONFB_IOR(40, struct xylonfb_hw_access)
+#define XYLONFB_IP_CORE_VERSION		XYLONFB_IOR(41, __u32)
+#define XYLONFB_WAIT_EDID		XYLONFB_IOW(42, unsigned int)
+#define XYLONFB_GET_EDID		XYLONFB_IOR(43, char)
+
+#endif /* __XYLONFB_H__ */
-- 
1.9.1

