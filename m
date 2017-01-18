From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 18 Jan 2017 10:33:51 +0000
Subject: [PATCH v1] video : fbdev : stifb :- Handle return NULL error from ioremap_nocache.
Message-Id: <1484734911-5299-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jejb@parisc-linux.org, deller@gmx.de, b.zolnierkie@samsung.com
Cc: linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Here, If ioremap_nocache will fail. It will return NULL.
Kernel can run into a NULL-pointer dereference.
This error check will avoid NULL pointer dereference.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/stifb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index accfef7..d5deab3 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1294,6 +1294,10 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	strcpy(fix->id, "stifb");
 	info->fbops = &stifb_ops;
 	info->screen_base = ioremap_nocache(REGION_BASE(fb,1), fix->smem_len);
+	if (!info->screen_base) {
+		printk(KERN_ERR "stifb: Failed to Map memory\n");
+		goto out_err0;
+	}
 	info->screen_size = fix->smem_len;
 	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA;
 	info->pseudo_palette = &fb->pseudo_palette;
-- 
1.9.1

