From: David Lechner <david@lechnology.com>
Date: Fri, 28 Jul 2017 20:33:53 +0000
Subject: [PATCH] fbdev: fix 1bpp logo for unusual width
Message-Id: <1501274033-6978-1-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

This check is needed in the case where the width of the framebuffer
is not a multiple of 8 pixels. For example, LEGO MINDSTORMS EV3 has
a 178x128 1bpp display.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 7a42238..805a42c 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -315,7 +315,7 @@ static void fb_set_logo(struct fb_info *info,
 		for (i = 0; i < logo->height; i++) {
 			for (j = 0; j < logo->width; src++) {
 				d = *src ^ xor;
-				for (k = 7; k >= 0; k--) {
+				for (k = 7; k >= 0 && j < logo->width; k--) {
 					*dst++ = ((d >> k) & 1) ? fg : 0;
 					j++;
 				}
-- 
2.7.4

