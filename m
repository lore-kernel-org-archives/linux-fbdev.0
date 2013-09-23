From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Mon, 23 Sep 2013 15:00:34 +0000
Subject: [PATCH] neofb: fix error return code in neofb_probe()
Message-Id: <CAPgLHd8sm1rhuuG7TJqAfWesiSDf6MaM4E4VCrrWXGziLEiYVA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/neofb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 891b0bf..2a3e5bd 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -2075,6 +2075,7 @@ static int neofb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!fb_find_mode(&info->var, info, mode_option, NULL, 0,
 			info->monspecs.modedb, 16)) {
 		printk(KERN_ERR "neofb: Unable to find usable video mode.\n");
+		err = -EINVAL;
 		goto err_map_video;
 	}
 
@@ -2097,7 +2098,8 @@ static int neofb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	       info->fix.smem_len >> 10, info->var.xres,
 	       info->var.yres, h_sync / 1000, h_sync % 1000, v_sync);
 
-	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+	err = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (err < 0)
 		goto err_map_video;
 
 	err = register_framebuffer(info);

