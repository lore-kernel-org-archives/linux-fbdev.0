From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 22 Jul 2019 20:33:58 +0000
Subject: [PATCH] video: fbdev: pvr2fb: remove unnecessary comparison of unsigned integer with < 0
Message-Id: <20190722203358.GA29111@embeddedor>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

There is no need to compare *var->xoffset* or *var->yoffset* with < 0
because such variables are of type unsigned, making it impossible to
hold a negative value.

Fix this by removing such comparisons.

Addresses-Coverity-ID: 1451964 ("Unsigned compared against 0")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/pvr2fb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 7ff4b6b84282..0a3b2b7c7891 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -458,13 +458,11 @@ static int pvr2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	set_color_bitfields(var);
 
 	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->xoffset || var->yoffset < 0 ||
-		    var->yoffset >= var->yres_virtual) {
+		if (var->xoffset || var->yoffset >= var->yres_virtual) {
 			var->xoffset = var->yoffset = 0;
 		} else {
 			if (var->xoffset > var->xres_virtual - var->xres ||
-			    var->yoffset > var->yres_virtual - var->yres ||
-			    var->xoffset < 0 || var->yoffset < 0)
+			    var->yoffset > var->yres_virtual - var->yres)
 				var->xoffset = var->yoffset = 0;
 		}
 	} else {
-- 
2.22.0
