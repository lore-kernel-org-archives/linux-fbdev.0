From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 12:05:57 +0000
Subject: [PATCH 2/6] FBDEV: JZ4740: Initialize jzfb->fb earlier
Message-Id: <80cfeb81c3b4bae96f8ade317a08566c87493578.1298980528.git.mcuelenaere@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

There's no reason to not do this, and this is needed in the upcoming SLCD
support patches.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/video/jz4740_fb.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 65741d0..cea7b7e 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -654,6 +654,7 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
 	fb->flags = FBINFO_DEFAULT;
 
 	jzfb = fb->par;
+	jzfb->fb = fb;
 	jzfb->pdev = pdev;
 	jzfb->pdata = pdata;
 	jzfb->mem = mem;
@@ -722,8 +723,6 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
 		goto err_free_devmem;
 	}
 
-	jzfb->fb = fb;
-
 	return 0;
 
 err_free_devmem:
-- 
1.7.4

