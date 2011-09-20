From: Ajay Kumar <ajaykumar.rs@samsung.com>
Date: Tue, 20 Sep 2011 09:29:04 +0000
Subject: [PATCH 1/3] include: fb: Add definiton for window positioning structure
Message-Id: <1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds a data structure definiton to hold framebuffer windows/planes.
An ioctl number is also added to provide user access
to change window position dynamically.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/fb.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 1d6836c..2141941 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -39,6 +39,7 @@
 #define FBIOPUT_MODEINFO        0x4617
 #define FBIOGET_DISPINFO        0x4618
 #define FBIO_WAITFORVSYNC	_IOW('F', 0x20, __u32)
+#define FBIOPOS_OVERLAY_WIN	_IOW('F', 0x21, struct fb_overlay_win_pos)
 
 #define FB_TYPE_PACKED_PIXELS		0	/* Packed Pixels	*/
 #define FB_TYPE_PLANES			1	/* Non interleaved planes */
@@ -366,6 +367,12 @@ struct fb_image {
 	struct fb_cmap cmap;	/* color map info */
 };
 
+/* Window overlaying */
+struct fb_overlay_win_pos {
+	__u32 win_pos_x;	/* x-offset from LCD(0,0) where window starts */
+	__u32 win_pos_y;	/* y-offset from LCD(0,0) where window starts */
+};
+
 /*
  * hardware cursor control
  */
-- 
1.7.0.4

