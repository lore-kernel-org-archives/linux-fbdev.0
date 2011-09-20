From: Ajay Kumar <ajaykumar.rs@samsung.com>
Date: Tue, 20 Sep 2011 09:29:04 +0000
Subject: [PATCH 2/3] ARM: SAMSUNG: Embed window positioning data structure in
Message-Id: <1316532641-2657-3-git-send-email-ajaykumar.rs@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds a new field in s3c_fb_pd_win structure,
thereby allowing the user to place window at the desired position.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/plat-samsung/include/plat/fb.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index 0fedf47..920decd 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -27,6 +27,7 @@
  * @win_mode: The display parameters to initialise (not for window 0)
  * @virtual_x: The virtual X size.
  * @virtual_y: The virtual Y size.
+ * @winpos: Position of overlayed window w.r.t the LCD screen.
  */
 struct s3c_fb_pd_win {
 	struct fb_videomode	win_mode;
@@ -35,6 +36,8 @@ struct s3c_fb_pd_win {
 	unsigned short		max_bpp;
 	unsigned short		virtual_x;
 	unsigned short		virtual_y;
+
+	struct fb_overlay_win_pos	winpos;
 };
 
 /**
-- 
1.7.0.4

