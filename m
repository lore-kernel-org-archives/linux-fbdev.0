From: akpm@linux-foundation.org
Date: Fri, 07 Dec 2012 20:30:39 +0000
Subject: [patch 2/2] drivers/video/console/softcursor.c: remove redundant NULL check before kfree()
Message-Id: <20121207203040.BC222200057@hpza10.eem.corp.google.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: drivers/video/console/softcursor.c: remove redundant NULL check before kfree()

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/video/console/softcursor.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/video/console/softcursor.c~drivers-video-console-softcursorc-remove-redundant-null-check-before-kfree drivers/video/console/softcursor.c
--- a/drivers/video/console/softcursor.c~drivers-video-console-softcursorc-remove-redundant-null-check-before-kfree
+++ a/drivers/video/console/softcursor.c
@@ -35,8 +35,7 @@ int soft_cursor(struct fb_info *info, st
 	dsize = s_pitch * cursor->image.height;
 
 	if (dsize + sizeof(struct fb_image) != ops->cursor_size) {
-		if (ops->cursor_src != NULL)
-			kfree(ops->cursor_src);
+		kfree(ops->cursor_src);
 		ops->cursor_size = dsize + sizeof(struct fb_image);
 
 		ops->cursor_src = kmalloc(ops->cursor_size, GFP_ATOMIC);
_
