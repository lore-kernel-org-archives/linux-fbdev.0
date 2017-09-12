From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue, 12 Sep 2017 05:39:30 +0000
Subject: [PATCH] video: fbdev: Fix an errro handling path in 'au1200fb_drv_probe()'
Message-Id: <20170912053930.18931-1-christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org, viro@zeniv.linux.org.uk
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If 'dmam_alloc_attrs()' fails, we must go through the error handling code,
as done elsewhere in this function. Otherwise, there is a resource leak.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I'm also puzzled by the 'framebuffer_alloc()' call a few lines above.
'ret' is known to be 0 at this point. I guess that -ENOMEM should also be
returned.
---
 drivers/video/fbdev/au1200fb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 5f04b4096c42..99d6cfb168b5 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1701,7 +1701,8 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 		if (!fbdev->fb_mem) {
 			print_err("fail to allocate frambuffer (size: %dK))",
 				  fbdev->fb_len / 1024);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto failed;
 		}
 
 		/*
-- 
2.11.0

