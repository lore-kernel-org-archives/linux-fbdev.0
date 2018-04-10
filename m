From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Tue, 10 Apr 2018 01:05:59 +0000
Subject: [PATCH] video: fbdev: savage: Replace mdelay with usleep_range in savage_init_hw
Message-Id: <1523322359-27598-1-git-send-email-baijiaju1990@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@gmail.com, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>

savage_init_hw() is never called in atomic context.

The call chains ending up at savage_init_hw() are:
[1] savage_init_hw() <- savagefb_probe()
[2] savage_init_hw() <- savagefb_resume()

savagefb_probe() is only set as ".probe" in struct pci_driver.
savagefb_resume) is only set as ".resume" in struct pci_driver.
These functions are not called in atomic context.

Despite never getting called from atomic context, savage_init_hw()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index c204683..c09d742 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -1892,11 +1892,11 @@ static int savage_init_hw(struct savagefb_par *par)
 	vga_out8(0x3d4, 0x66, par);
 	cr66 = vga_in8(0x3d5, par);
 	vga_out8(0x3d5, cr66 | 0x02, par);
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	vga_out8(0x3d4, 0x66, par);
 	vga_out8(0x3d5, cr66 & ~0x02, par);	/* clear reset flag */
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 
 	/*
@@ -1906,11 +1906,11 @@ static int savage_init_hw(struct savagefb_par *par)
 	vga_out8(0x3d4, 0x3f, par);
 	cr3f = vga_in8(0x3d5, par);
 	vga_out8(0x3d5, cr3f | 0x08, par);
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	vga_out8(0x3d4, 0x3f, par);
 	vga_out8(0x3d5, cr3f & ~0x08, par);	/* clear reset flags */
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	/* Savage ramdac speeds */
 	par->numClocks = 4;
-- 
1.9.1

