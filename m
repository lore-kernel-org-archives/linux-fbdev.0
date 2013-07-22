From: Chen Gang <gang.chen@asianux.com>
Date: Mon, 22 Jul 2013 08:07:45 +0000
Subject: [PATCH] drivers: video: fbmem: add signed type cast for comparation.
Message-Id: <51ECE851.4030002@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

For 'con2fb.framebuffer', it can be '-1' as an invalid value, so it
need related type cast for its comparing.

The related warning:

  drivers/video/fbmem.c:1169:3: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/video/fbmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 36e1fe2..8e8225c 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1166,7 +1166,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			return -EFAULT;
 		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
 			return -EINVAL;
-		if (con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX)
+		if ((int)con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX)
 			return -EINVAL;
 		if (!registered_fb[con2fb.framebuffer])
 			request_module("fb%d", con2fb.framebuffer);
-- 
1.7.7.6
