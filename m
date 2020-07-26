From: Gaurav Singh <gaurav1086@gmail.com>
Date: Sun, 26 Jul 2020 05:07:00 +0000
Subject: [PATCH] [video/fbdev] fb_flashcursor: Remove redundant null check
Message-Id: <20200726050713.9461-1-gaurav1086@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gaurav1086@gmail.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Qiujun Huang <hqjagain@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Rosin <peda@axentia.se>, Nathan Chancellor <natechancellor@gmail.com>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

ops cannot be NULL as its being accessed later without
checks. Remove the redundant NULL check. 

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index e2a490c5ae08..9551f40c6d14 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -401,7 +401,7 @@ static void fb_flashcursor(struct work_struct *work)
 	if (ret = 0)
 		return;
 
-	if (ops && ops->currcon != -1)
+	if (ops->currcon != -1)
 		vc = vc_cons[ops->currcon].d;
 
 	if (!vc || !con_is_visible(vc) ||
-- 
2.17.1
