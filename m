From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 10:19:27 +0000
Subject: [PATCH 3/4] video: sm501fb: Combine substrings for four messages
Message-Id: <cf2aeddc-0644-f2cb-09fb-594ca9737739@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
In-Reply-To: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 10:43:36 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix four source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/sm501fb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 80bda5a655c0..f38e3773ccc0 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -510,10 +510,10 @@ static int sm501fb_set_par_common(struct fb_info *info,
 	/* update fb layer with actual clock used */
 	var->pixclock = sm501fb_hz_to_ps(sm501pixclock);
 
-	dev_dbg(fbi->dev, "%s: pixclock(ps) = %u, pixclock(Hz)  = %lu, "
-	       "sm501pixclock = %lu,  error = %ld%%\n",
-	       __func__, var->pixclock, pixclock, sm501pixclock,
-	       ((pixclock - sm501pixclock)*100)/pixclock);
+	dev_dbg(fbi->dev,
+		"%s: pixclock(ps) = %u, pixclock(Hz)  = %lu, sm501pixclock = %lu,  error = %ld%%\n",
+		__func__, var->pixclock, pixclock, sm501pixclock,
+		((pixclock - sm501pixclock) * 100) / pixclock);
 
 	return 0;
 }
@@ -1789,16 +1789,16 @@ static int sm501fb_init_fb(struct fb_info *fb, enum sm501_controller head,
 
 			switch (ret) {
 			case 1:
-				dev_info(info->dev, "using mode specified in "
-						"@mode\n");
+				dev_info(info->dev,
+					 "using mode specified in @mode\n");
 				break;
 			case 2:
-				dev_info(info->dev, "using mode specified in "
-					"@mode with ignored refresh rate\n");
+				dev_info(info->dev,
+					 "using mode specified in @mode with ignored refresh rate\n");
 				break;
 			case 3:
-				dev_info(info->dev, "using mode default "
-					"mode\n");
+				dev_info(info->dev,
+					 "using mode default mode\n");
 				break;
 			case 4:
 				dev_info(info->dev, "using mode from list\n");
-- 
2.15.0

