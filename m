From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 10 Aug 2017 09:28:45 +0000
Subject: [PATCH 2/2] fbdev: i810: make fb_ops const
Message-Id: <1502356605-20801-3-git-send-email-bhumirks@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1502356605-20801-1-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502356605-20801-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, adaplas@gmail.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make the structure const as it is only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/video/fbdev/i810/i810_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index f0a758a..d18f7b3 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -1542,7 +1542,7 @@ static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	return 0;
 }
 
-static struct fb_ops i810fb_ops = {
+static const struct fb_ops i810fb_ops = {
 	.owner =             THIS_MODULE,
 	.fb_open =           i810fb_open,
 	.fb_release =        i810fb_release,
-- 
1.9.1

