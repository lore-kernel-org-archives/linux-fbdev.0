From: jon@ringle.org
Date: Tue, 01 Apr 2014 12:33:05 +0000
Subject: [PATCH v2 2/2] video: da8xx-fb: Fix casting of info->pseudo_palette
Message-Id: <1396355585-458-2-git-send-email-jon@ringle.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396355585-458-1-git-send-email-jon@ringle.org>
In-Reply-To: <1396355585-458-1-git-send-email-jon@ringle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, Jon Ringle <jringle@gridpoint.com>

From: Jon Ringle <jringle@gridpoint.com>

The casting to (u16 *) on info->pseudo_palette is wrong and causes the
display to show a blue (garbage) vertical line on every other pixel column

Signed-off-by: Jon Ringle <jringle@gridpoint.com>
---
 drivers/video/da8xx-fb.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index d042624..83c43b2 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -678,15 +678,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			(green << info->var.green.offset) |
 			(blue << info->var.blue.offset);
 
-		switch (info->var.bits_per_pixel) {
-		case 16:
-			((u16 *) (info->pseudo_palette))[regno] = v;
-			break;
-		case 24:
-		case 32:
-			((u32 *) (info->pseudo_palette))[regno] = v;
-			break;
-		}
+		((u32 *) (info->pseudo_palette))[regno] = v;
 		if (palette[0] != 0x4000) {
 			update_hw = 1;
 			palette[0] = 0x4000;
-- 
1.8.5.4

