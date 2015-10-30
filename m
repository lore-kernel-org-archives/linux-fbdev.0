From: Shailendra Verma <shailendra.v@samung.com>
Date: Fri, 30 Oct 2015 11:48:34 +0000
Subject: [PATCH] video:fbdev:core:Calculate the size for colormap only after the validation of length for col
Message-Id: <1446204994-23755-1-git-send-email-shailendra.v@samung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vidushi.koul@samsung.com

From: Shailendra Verma <shailendra.v@samsung.com>

While allocating the memory for color map, the memory size for colors
is being calculated before the validation of length for color map.
Moved the size calculation part after the validation of color map length.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/video/fbdev/core/fbcmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/fbcmap.c
index f89245b..45ad567 100644
--- a/drivers/video/fbdev/core/fbcmap.c
+++ b/drivers/video/fbdev/core/fbcmap.c
@@ -91,7 +91,7 @@ static const struct fb_cmap default_16_colors = {
 
 int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t flags)
 {
-	int size = len * sizeof(u16);
+	int size;
 	int ret = -ENOMEM;
 
 	if (cmap->len != len) {
@@ -99,6 +99,7 @@ int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t flags)
 		if (!len)
 			return 0;
 
+		size = len * sizeof(u16);
 		cmap->red = kmalloc(size, flags);
 		if (!cmap->red)
 			goto fail;
-- 
1.9.1

