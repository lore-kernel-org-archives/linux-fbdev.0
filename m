From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 16 Oct 2017 19:04:49 +0000
Subject: [PATCH 3/8] video: fbdev: au1200fb: Release some resources if a memory allocation fails
Message-Id: <dcbd4ba45087e3cb22bc35ee11db5eb3016573b7.1508179264.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

We should go through the error handling code instead of returning -ENOMEM
directly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/au1200fb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 7fa41026984d..cf54168d44dc 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1702,7 +1702,8 @@ static int au1200fb_drv_probe(struct platform_device *dev)
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

