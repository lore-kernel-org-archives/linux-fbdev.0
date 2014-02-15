From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 15 Feb 2014 05:56:22 +0000
Subject: [PATCH 1/5] video: imxfb: Remove dead declaration of set_imx_fb_info()
Message-Id: <1392443786-30527-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Function set_imx_fb_info() is missing in the kernel code,
so remove the dead declaration.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 include/linux/platform_data/video-imxfb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/platform_data/video-imxfb.h b/include/linux/platform_data/video-imxfb.h
index 8902706..dd1bed9 100644
--- a/include/linux/platform_data/video-imxfb.h
+++ b/include/linux/platform_data/video-imxfb.h
@@ -79,5 +79,4 @@ struct imx_fb_platform_data {
 	void (*backlight_power)(int);
 };
 
-void set_imx_fb_info(struct imx_fb_platform_data *);
 #endif /* ifndef __MACH_IMXFB_H__ */
-- 
1.8.3.2

