From: Colin King <colin.king@canonical.com>
Date: Mon, 12 Sep 2016 12:14:12 +0000
Subject: [PATCH] video: fbdev: i810: add in missing white space in error message text
Message-Id: <20160912121412.31730-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A printk message spans two lines and the literal string is missing
a white space between words. Add the white space.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/i810/i810_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index 025b882..30f6a74 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -1691,7 +1691,7 @@ static int i810_alloc_agp_mem(struct fb_info *info)
 	if (!(par->i810_gtt.i810_cursor_memory = 
 	      agp_allocate_memory(bridge, par->cursor_heap.size >> 12,
 				  AGP_PHYSICAL_MEMORY))) {
-		printk("i810fb_alloc_cursormem:  can't allocate" 
+		printk("i810fb_alloc_cursormem:  can't allocate "
 		       "cursor memory\n");
 		agp_backend_release(bridge);
 		return -ENOMEM;
-- 
2.9.3

