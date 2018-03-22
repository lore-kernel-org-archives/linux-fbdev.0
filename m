From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 22 Mar 2018 20:13:32 +0000
Subject: [PATCH] video: fbdev: aty128fb: use true and false for boolean values
Message-Id: <20180322201332.GA28960@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index db18474..09b0e55 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -1716,7 +1716,7 @@ static int aty128fb_setup(char *options)
 			continue;
 		}
 		if(!strncmp(this_opt, "nomtrr", 6)) {
-			mtrr = 0;
+			mtrr = false;
 			continue;
 		}
 #ifdef CONFIG_PPC_PMAC
-- 
2.7.4

