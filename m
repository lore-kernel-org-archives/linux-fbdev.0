From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 09 Jul 2018 21:36:08 +0000
Subject: [PATCH] fbdev: fbmem: mark expected switch fall-through
Message-Id: <20180709213608.GA7584@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/core/fbmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 609438d..5f3133b 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1347,6 +1347,7 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 	case FBIOGET_CON2FBMAP:
 	case FBIOPUT_CON2FBMAP:
 		arg = (unsigned long) compat_ptr(arg);
+		/* fall through */
 	case FBIOBLANK:
 		ret = do_fb_ioctl(info, cmd, arg);
 		break;
-- 
2.7.4

