From: Peter Rosin <peda@axentia.se>
Date: Mon, 26 Nov 2018 21:57:41 +0000
Subject: [PATCH 2/2] fbdev: fbmem: add config option to center the bootup logo
Message-Id: <20181126215725.2548-3-peda@axentia.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126215725.2548-1-peda@axentia.se>
In-Reply-To: <20181126215725.2548-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

If there are extra logos (CONFIG_FB_LOGO_EXTRA) the heights of these
extra logos are not considered when centering the first logo vertically.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/video/fbdev/core/fbmem.c | 25 ++++++++++++++++++++++++-
 drivers/video/logo/Kconfig       |  9 +++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 43d4047f472a..fdbad029e5e6 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -502,8 +502,25 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 		fb_set_logo(info, logo, logo_new, fb_logo.depth);
 	}
 
+#ifdef CONFIG_FB_LOGO_CENTER
+	{
+		int xres = info->var.xres;
+		int yres = info->var.yres;
+
+		if (rotate == FB_ROTATE_CW || rotate == FB_ROTATE_CCW) {
+			xres = info->var.yres;
+			yres = info->var.xres;
+		}
+
+		while (n && (n * (logo->width + 8) - 8 > xres))
+			--n;
+		image.dx = (xres - n * (logo->width + 8) - 8) / 2;
+		image.dy = y ?: (yres - logo->height) / 2;
+	}
+#else
 	image.dx = 0;
 	image.dy = y;
+#endif
 	image.width = logo->width;
 	image.height = logo->height;
 
@@ -600,6 +617,7 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 {
 	int depth = fb_get_color_depth(&info->var, &info->fix);
 	unsigned int yres;
+	int height;
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
@@ -661,7 +679,12 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
  		}
  	}
 
-	return fb_prepare_extra_logos(info, fb_logo.logo->height, yres);
+	height = fb_logo.logo->height;
+#ifdef CONFIG_FB_LOGO_CENTER
+	height += (yres - fb_logo.logo->height) / 2;
+#endif
+
+	return fb_prepare_extra_logos(info, height, yres);
 }
 
 int fb_show_logo(struct fb_info *info, int rotate)
diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index d1f6196c8b9a..1e972c4e88b1 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -10,6 +10,15 @@ menuconfig LOGO
 
 if LOGO
 
+config FB_LOGO_CENTER
+	bool "Center the logo"
+	depends on FB=y
+	help
+	  When this option is selected, the bootup logo is centered both
+	  horizontally and vertically. If more than one logo is displayed
+	  due to multiple CPUs, the collected line of logos is centered
+	  as a whole.
+
 config FB_LOGO_EXTRA
 	bool
 	depends on FB=y
-- 
2.11.0
