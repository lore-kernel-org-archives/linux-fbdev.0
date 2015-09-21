From: Andrzej Hajda <a.hajda@samsung.com>
Date: Mon, 21 Sep 2015 13:34:00 +0000
Subject: [PATCH 28/38] video/omap: remove invalid check
Message-Id: <1442842450-29769-29-git-send-email-a.hajda@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

regno is unsigned so it cannot be negative.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 1fb3ea3..393ae1b 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -276,11 +276,6 @@ static int _setcolreg(struct fb_info *info, u_int regno, u_int red, u_int green,
 		if (r != 0)
 			break;
 
-		if (regno < 0) {
-			r = -EINVAL;
-			break;
-		}
-
 		if (regno < 16) {
 			u16 pal;
 			pal = ((red >> (16 - var->red.length)) <<
-- 
1.9.1

