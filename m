From: Aymen Qader <qader.aymen@gmail.com>
Date: Thu, 20 Sep 2018 22:53:21 +0000
Subject: [PATCH] staging: sm750fb: Fix typo frambuffer->framebuffer
Message-Id: <20180920225321.18180-1-qader.aymen@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Aymen Qader <qader.aymen@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch corrects a typo (frambuffer->framebuffer) in the
sm750fb_fram(e)buffer_release and sm750fb_fram(e)buffer_alloc function
names.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 846d7d243994..e9f10c2669ea 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1007,7 +1007,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	}
 }
 
-static void sm750fb_frambuffer_release(struct sm750_dev *sm750_dev)
+static void sm750fb_framebuffer_release(struct sm750_dev *sm750_dev)
 {
 	struct fb_info *fb_info;
 
@@ -1019,7 +1019,7 @@ static void sm750fb_frambuffer_release(struct sm750_dev *sm750_dev)
 	}
 }
 
-static int sm750fb_frambuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
+static int sm750fb_framebuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
 {
 	struct fb_info *fb_info;
 	struct lynxfb_par *par;
@@ -1137,7 +1137,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	/* allocate frame buffer info structures according to g_dualview */
 	max_fb = g_dualview ? 2 : 1;
 	for (fbidx = 0; fbidx < max_fb; fbidx++) {
-		err = sm750fb_frambuffer_alloc(sm750_dev, fbidx);
+		err = sm750fb_framebuffer_alloc(sm750_dev, fbidx);
 		if (err)
 			goto release_fb;
 	}
@@ -1145,7 +1145,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 release_fb:
-	sm750fb_frambuffer_release(sm750_dev);
+	sm750fb_framebuffer_release(sm750_dev);
 	return err;
 }
 
@@ -1155,7 +1155,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 
 	sm750_dev = pci_get_drvdata(pdev);
 
-	sm750fb_frambuffer_release(sm750_dev);
+	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
 	iounmap(sm750_dev->pvReg);
-- 
2.17.1
