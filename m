From: Yifeng Li <tomli@tomli.me>
Date: Sat, 02 Feb 2019 06:16:43 +0000
Subject: [PATCH 3/8] fbdev: sm712fb: add 2D-related I/O headers and functions.
Message-Id: <20190202061648.30374-4-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190202061648.30374-1-tomli@tomli.me>
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This commit adds I/O macros and functions related to 2D opeartions.
A hunk of hardware register definitions are taken verbatim from
OpenBSD.

In addition, a utility function pad_to_dword() is added to help
padding data for the 2D engine. It  accepts 3, 2, or 1 byte(s) of
data, and pads it to a 32-bit word suitable for 2D Drawing Engine.

Yes, we can set info->pixmap.scan_align/buf_align = 4 and forget
about padding, but it's incompatible with cfb_imageblit() w/
depth = 1. In case we need to fallback (e.g. debugging), it would
be inconvenient, so we pad it manually.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712.h | 96 +++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index 942019dc816a..6d096c1b254c 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -95,6 +95,102 @@ static inline u8 smtc_seqr(u8 reg)
 	return smtc_mmiorb(0x3c5);
 }
 
+/*
+ * DPR (2D drawing engine)
+ */
+#define DPR_COORDS(x, y)		(((x) << 16) | (y))
+
+#define SCR_DE_STATUS			0x16
+#define SCR_DE_STATUS_MASK		0x18
+#define SCR_DE_ENGINE_IDLE		0x10
+
+#define DPR_BASE			0x00408000
+#define DPR_SRC_COORDS			0x00
+#define DPR_DST_COORDS			0x04
+#define DPR_SPAN_COORDS			0x08
+#define DPR_DE_CTRL			0x0c
+#define DPR_PITCH			0x10
+#define DPR_FG_COLOR			0x14
+#define DPR_BG_COLOR			0x18
+#define DPR_STRETCH			0x1c
+#define DPR_DE_FORMAT_SELECT		0x1e
+#define DPR_COLOR_COMPARE		0x20
+#define DPR_COLOR_COMPARE_MASK		0x24
+#define DPR_BYTE_BIT_MASK		0x28
+#define DPR_CROP_TOPLEFT_COORDS		0x2c
+#define DPR_CROP_BOTRIGHT_COORDS	0x30
+#define DPR_MONO_PATTERN_LO32		0x34
+#define DPR_MONO_PATTERN_HI32		0x38
+#define DPR_SRC_WINDOW			0x3c
+#define DPR_SRC_BASE			0x40
+#define DPR_DST_BASE			0x44
+
+#define DE_CTRL_START			0x80000000
+#define DE_CTRL_RTOL			0x08000000
+#define DE_CTRL_COMMAND_MASK		0x001f0000
+#define DE_CTRL_COMMAND_SHIFT			16
+#define DE_CTRL_COMMAND_BITBLT			0x00
+#define DE_CTRL_COMMAND_SOLIDFILL		0x01
+#define DE_CTRL_COMMAND_HOSTWRITE		0x08
+#define DE_CTRL_ROP2_SELECT		0x00008000
+#define DE_CTRL_ROP2_SRC_IS_PATTERN	0x00004000
+#define DE_CTRL_ROP2_SHIFT			0
+#define DE_CTRL_ROP2_COPY			0x0c
+#define DE_CTRL_HOST_SHIFT			22
+#define DE_CTRL_HOST_SRC_IS_MONO		0x01
+#define DE_CTRL_FORMAT_XY			0x00
+#define DE_CTRL_FORMAT_24BIT			0x30
+
+/*
+ * 32-bit I/O for 2D opeartions.
+ */
+extern void __iomem *smtc_dprbaseaddress;   /* DPR, 2D control registers */
+
+static inline u8 smtc_dprr(u8 reg)
+{
+	return readl(smtc_dprbaseaddress + reg);
+}
+
+static inline void smtc_dprw(u8 reg, u32 val)
+{
+	writel(val, smtc_dprbaseaddress + reg);
+}
+
+static inline void smtc_dprw_16(u8 reg, u16 val)
+{
+	writew(val, smtc_dprbaseaddress + reg);
+}
+
+static inline u32 pad_to_dword(const u8 *bytes, int length)
+{
+	u32 dword = 0;
+
+	switch (length) {
+#ifdef __BIG_ENDIAN
+	case 3:
+		dword |= bytes[2] << 8;
+	/* fallthrough */
+	case 2:
+		dword |= bytes[1] << 16;
+	/* fallthrough */
+	case 1:
+		dword |= bytes[0] << 24;
+		break;
+#else
+	case 3:
+		dword |= bytes[2] << 16;
+	/* fallthrough */
+	case 2:
+		dword |= bytes[1] << 8;
+	/* fallthrough */
+	case 1:
+		dword |= bytes[0];
+		break;
+#endif
+	}
+	return dword;
+}
+
 /* The next structure holds all information relevant for a specific video mode.
  */
 
-- 
2.20.1
