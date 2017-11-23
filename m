From: Colin King <colin.king@canonical.com>
Date: Thu, 23 Nov 2017 10:55:53 +0000
Subject: [PATCH] video: fbdev: remove redundant self assignment of 'height'
Message-Id: <20171123105553.18969-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment of height to itself is redundant and can be removed.
Detected with Coccinelle.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/vga16fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 5f0690c8fc93..2c6a576ed84c 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1055,7 +1055,6 @@ static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *are
 	case FB_TYPE_VGA_PLANES:
 		if (info->fix.type_aux = FB_AUX_VGA_PLANES_VGA4) {
 			width = width/8;
-			height = height;
 			line_ofs = info->fix.line_length - width;
 
 			setmode(1);
-- 
2.14.1

