From: Ajay Kumar <ajaykumar.rs@samsung.com>
Date: Thu, 25 Aug 2011 13:54:49 +0000
Subject: [PATCH 1/2] ARM: SAMSUNG: Add Window Positioning Support for s3c-fb
Message-Id: <1314301917-9938-2-git-send-email-ajaykumar.rs@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314301917-9938-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1314301917-9938-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch:
	--adds a data-structure to hold the current position of windows.
	--adds an ioctl number to support dynamic positioning the windows.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/plat-samsung/include/plat/fb.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index bd79c0a..77ed75c 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -22,6 +22,18 @@
  */
 #define S3C_FB_MAX_WIN	(5)
 
+/* struct s3cfb_window_pos
+ * @win_pos_x: X-coordinate of window from the left.
+ * @win_pos_y: Y-coordinate of window from the top.
+ */
+struct s3cfb_window_pos {
+	int	win_pos_x;
+	int	win_pos_y;
+};
+
+/* Custom ioctl */
+#define S3CFB_WIN_POSITION	_IOW('F', 1, struct s3cfb_window_pos)
+
 /**
  * struct s3c_fb_pd_win - per window setup data
  * @win_mode: The display parameters to initialise (not for window 0)
@@ -35,6 +47,8 @@ struct s3c_fb_pd_win {
 	unsigned short		max_bpp;
 	unsigned short		virtual_x;
 	unsigned short		virtual_y;
+
+	struct s3cfb_window_pos		winpos;
 };
 
 /**
-- 
1.7.0.4

