From: Colin King <colin.king@canonical.com>
Date: Tue, 01 May 2018 08:37:42 +0000
Subject: [PATCH] video: fbdev: fix spelling mistake: "frambuffer" -> "framebuffer"
Message-Id: <20180501083742.22565-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Markus Elfring <elfring@users.sourceforge.net>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in error messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/au1100fb.c | 2 +-
 drivers/video/fbdev/au1200fb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 7c9a672e9811..5e0491861439 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -464,7 +464,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 					    PAGE_ALIGN(fbdev->fb_len),
 					    &fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
-		print_err("fail to allocate frambuffer (size: %dK))",
+		print_err("fail to allocate framebuffer (size: %dK))",
 			  fbdev->fb_len / 1024);
 		return -ENOMEM;
 	}
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 87d5a62bf6ca..3872ccef4cb2 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1696,7 +1696,7 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 				&fbdev->fb_phys, GFP_KERNEL,
 				DMA_ATTR_NON_CONSISTENT);
 		if (!fbdev->fb_mem) {
-			print_err("fail to allocate frambuffer (size: %dK))",
+			print_err("fail to allocate framebuffer (size: %dK))",
 				  fbdev->fb_len / 1024);
 			ret = -ENOMEM;
 			goto failed;
-- 
2.17.0

