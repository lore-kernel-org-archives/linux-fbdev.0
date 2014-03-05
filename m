From: Wang YanQing <udknight@gmail.com>
Date: Wed, 05 Mar 2014 15:54:18 +0000
Subject: [PATCH] video: fbdev: uvesafb: Remove redundant NULL check in uvesafb_remove
Message-Id: <20140305155418.GA32106@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, fengguang.wu@intel.com

Because uvesafb_par is allocated as part of fb_info in uvesafb_probe,
so we don't need to do NULL check for both fb_info and uvesafb_par in
uvesafb_remove.

[ This patch also fix a warning report by fengguang.wu@intel.com
  "drivers/video/fbdev/uvesafb.c:1815 uvesafb_remove()
   warn: variable dereferenced before check 'par'" ]

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 drivers/video/fbdev/uvesafb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 1f38445..18352b2 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1812,11 +1812,9 @@ static int uvesafb_remove(struct platform_device *dev)
 		fb_destroy_modedb(info->monspecs.modedb);
 		fb_dealloc_cmap(&info->cmap);
 
-		if (par) {
-			kfree(par->vbe_modes);
-			kfree(par->vbe_state_orig);
-			kfree(par->vbe_state_saved);
-		}
+		kfree(par->vbe_modes);
+		kfree(par->vbe_state_orig);
+		kfree(par->vbe_state_saved);
 
 		framebuffer_release(info);
 	}
-- 
1.8.3.4.8.g69490f3.dirty
