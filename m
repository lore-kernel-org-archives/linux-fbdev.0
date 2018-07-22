From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 22 Jul 2018 03:16:09 +0000
Subject: [PATCH] fbdev: fix omap2/omapfb/dss/ indentation warning
Message-Id: <6a9560cc-1abc-f329-d82e-0a128d29c9fe@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix indentation warning (from gcc 8.1.0) in omap2/omapfb:

../drivers/video/fbdev/omap2/omapfb/dss/dispc.c: In function 'pixinc':
../drivers/video/fbdev/omap2/omapfb/dss/dispc.c:1859:2: warning: this 'else' clause does not guard... [-Wmisleading-indentation]
  else
  ^~~~
../drivers/video/fbdev/omap2/omapfb/dss/dispc.c:1861:3: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'else'
   return 0;
   ^~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180717.orig/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ linux-next-20180717/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -1858,7 +1858,7 @@ static s32 pixinc(int pixels, u8 ps)
 		return 1 - (-pixels + 1) * ps;
 	else
 		BUG();
-		return 0;
+	return 0;
 }
 
 static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,


