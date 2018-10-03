From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 03 Oct 2018 11:50:44 +0000
Subject: [PATCH] video: fbdev: arcfb: mark expected switch fall-through
Message-Id: <20181003115044.GA10786@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaya Kumar <jayalk@intworks.biz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115017 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/arcfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 7e87d0d..a48741a 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -419,6 +419,8 @@ static int arcfb_ioctl(struct fb_info *info,
 			schedule();
 			finish_wait(&arcfb_waitq, &wait);
 		}
+		/* fall through */
+
 		case FBIO_GETCONTROL2:
 		{
 			unsigned char ctl2;
-- 
2.7.4
