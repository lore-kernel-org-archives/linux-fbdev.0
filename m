From: Fuqian Huang <huangfq.daxian@gmail.com>
Date: Thu, 27 Jun 2019 17:41:09 +0000
Subject: [PATCH 45/87] fbdev: mmp: remove memset after dma_alloc_coherent in mmpfb.c
Message-Id: <20190627174110.4345-1-huangfq.daxian@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Jilayne Lovejoy <opensource@jilayne.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/video/fbdev/mmp/fb/mmpfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
index e5b56f2199df..47bc7c59bbd8 100644
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -612,7 +612,6 @@ static int mmpfb_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto failed_destroy_mutex;
 	}
-	memset(fbi->fb_start, 0, fbi->fb_size);
 	dev_info(fbi->dev, "fb %dk allocated\n", fbi->fb_size/1024);
 
 	/* fb power on */
-- 
2.11.0
