From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Tue, 17 Nov 2015 01:38:15 +0000
Subject: [PATCH] video: fbdev: rivafb: unlock chip before probiding EDID
Message-Id: <1447724295-1954-1-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

At least NV3 requires for chip to be unlocked before it is possible to
access I2C registers. Without it, it is not possible to read EDID.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/video/fbdev/riva/fbdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index f1ad274..2ef26ad 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -1765,6 +1765,7 @@ static int riva_get_EDID_i2c(struct fb_info *info)
 	int i;
 
 	NVTRACE_ENTER();
+	par->riva.LockUnlock(&par->riva, 0);
 	riva_create_i2c_busses(par);
 	for (i = 0; i < 3; i++) {
 		if (!par->chan[i].par)
-- 
2.6.2

