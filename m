From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 27 Feb 2019 20:53:04 +0000
Subject: [PATCH] xen, fbfront: mark expected switch fall-through
Message-Id: <20190227205303.GA1231@embeddedor>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/video/fbdev/xen-fbfront.c: In function ‘xenfb_backend_changed’:
drivers/video/fbdev/xen-fbfront.c:678:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (dev->state = XenbusStateClosed)
      ^
drivers/video/fbdev/xen-fbfront.c:681:2: note: here
  case XenbusStateClosing:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/xen-fbfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 6a4bbc9e1fb0..a3d6b6db221b 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -677,7 +677,7 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
 	case XenbusStateClosed:
 		if (dev->state = XenbusStateClosed)
 			break;
-		/* Missed the backend's CLOSING state -- fallthrough */
+		/* fall through - Missed the backend's CLOSING state. */
 	case XenbusStateClosing:
 		xenbus_frontend_closed(dev);
 		break;
-- 
2.21.0
