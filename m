From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 15 Nov 2010 10:03:13 +0000
Subject: [PATCH] fbdev: da8xx: punt duplicated FBIO_WAITFORVSYNC define
Message-Id: <1289815393-32429-1-git-send-email-vapier@gentoo.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is already defined by linux/fb.h now, so punt the duplicate
definition from the driver header.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 include/video/da8xx-fb.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index 6316cda..89d43b3 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -99,7 +99,6 @@ struct lcd_sync_arg {
 #define FBIPUT_COLOR		_IOW('F', 6, int)
 #define FBIPUT_HSYNC		_IOW('F', 9, int)
 #define FBIPUT_VSYNC		_IOW('F', 10, int)
-#define FBIO_WAITFORVSYNC	_IOW('F', 0x20, u_int32_t)
 
 #endif  /* ifndef DA8XX_FB_H */
 
-- 
1.7.3.2

