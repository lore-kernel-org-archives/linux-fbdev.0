From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Mon, 06 Nov 2017 22:45:50 +0000
Subject: [PATCH] video: fbdev: cirrusfb: mark expected switch fall-throughs
Message-Id: <20171106224550.GA2583@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case I placed the "fall through" comment
on its own line, which is what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/video/fbdev/cirrusfb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index d992aa5..b3be06d 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -1477,10 +1477,12 @@ static void init_vgachip(struct fb_info *info)
 		mdelay(100);
 		/* mode */
 		vga_wgfx(cinfo->regbase, CL_GR31, 0x00);
-	case BT_GD5480:  /* fall through */
+		/* fall through */
+	case BT_GD5480:
 		/* from Klaus' NetBSD driver: */
 		vga_wgfx(cinfo->regbase, CL_GR2F, 0x00);
-	case BT_ALPINE:  /* fall through */
+		/* fall through */
+	case BT_ALPINE:
 		/* put blitter into 542x compat */
 		vga_wgfx(cinfo->regbase, CL_GR33, 0x00);
 		break;
-- 
2.7.4

