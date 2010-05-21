From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 21 May 2010 15:15:41 +0000
Subject: [PATCH 3/5] sh: add a YUV422 output data format, that is also
Message-Id: <Pine.LNX.4.64.1005211703140.8450@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1005201829260.26000@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005201829260.26000@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev, @vger.kernel.org" <linux-fbdev@vger.kernel.org>, "lin, ux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

The LCDC block is allowed to use one of the two output data formats, when used
with MIPI DSI: RGB24 and YUV422. YUV422 is not currently handled by the LCDC
driver, but we have to add a define for it for MIPI.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Unchanged from v1.

 include/video/sh_mobile_lcdc.h |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index 2cc893f..5eaea78 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -3,24 +3,27 @@
 
 #include <linux/fb.h>
 
-enum { RGB8,   /* 24bpp, 8:8:8 */
-       RGB9,   /* 18bpp, 9:9 */
-       RGB12A, /* 24bpp, 12:12 */
-       RGB12B, /* 12bpp */
-       RGB16,  /* 16bpp */
-       RGB18,  /* 18bpp */
-       RGB24,  /* 24bpp */
-       SYS8A,  /* 24bpp, 8:8:8 */
-       SYS8B,  /* 18bpp, 8:8:2 */
-       SYS8C,  /* 18bpp, 2:8:8 */
-       SYS8D,  /* 16bpp, 8:8 */
-       SYS9,   /* 18bpp, 9:9 */
-       SYS12,  /* 24bpp, 12:12 */
-       SYS16A, /* 16bpp */
-       SYS16B, /* 18bpp, 16:2 */
-       SYS16C, /* 18bpp, 2:16 */
-       SYS18,  /* 18bpp */
-       SYS24 };/* 24bpp */
+enum {
+	RGB8,   /* 24bpp, 8:8:8 */
+	RGB9,   /* 18bpp, 9:9 */
+	RGB12A, /* 24bpp, 12:12 */
+	RGB12B, /* 12bpp */
+	RGB16,  /* 16bpp */
+	RGB18,  /* 18bpp */
+	RGB24,  /* 24bpp */
+	YUV422, /* 16bpp */
+	SYS8A,  /* 24bpp, 8:8:8 */
+	SYS8B,  /* 18bpp, 8:8:2 */
+	SYS8C,  /* 18bpp, 2:8:8 */
+	SYS8D,  /* 16bpp, 8:8 */
+	SYS9,   /* 18bpp, 9:9 */
+	SYS12,  /* 24bpp, 12:12 */
+	SYS16A, /* 16bpp */
+	SYS16B, /* 18bpp, 16:2 */
+	SYS16C, /* 18bpp, 2:16 */
+	SYS18,  /* 18bpp */
+	SYS24,  /* 24bpp */
+};
 
 enum { LCDC_CHAN_DISABLED = 0,
        LCDC_CHAN_MAINLCD,
-- 
1.6.2.4

