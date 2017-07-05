From: Joe Perches <joe@perches.com>
Date: Wed, 05 Jul 2017 20:02:24 +0000
Subject: [PATCH 15/18] video: fbdev: intelfb: Move inline before return type
Message-Id: <8ba151a1fdc84e42cbf4aafc798513c0158edee1.1499284835.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1499284835.git.joe@perches.com>
In-Reply-To: <cover.1499284835.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Maik Broemme <mbroemme@libmpq.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Make the code like the rest of the kernel.

But there is an oddity here because the inline should probably be removed.

It's an extern function in intelfb.h and it is used in intelfbdrv.c and
intelfbhw.c.

The inline is kept here as I suppose it's possible for some compiler to
make the uses inline in intelfbdrv and and also create an external function
for intelfbhw.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/intelfb/intelfbdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index 6b444400a86c..ffc391208b27 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -907,7 +907,7 @@ static void intelfb_pci_unregister(struct pci_dev *pdev)
  *                       helper functions                      *
  ***************************************************************/
 
-int __inline__ intelfb_var_to_depth(const struct fb_var_screeninfo *var)
+__inline__ int intelfb_var_to_depth(const struct fb_var_screeninfo *var)
 {
 	DBG_MSG("intelfb_var_to_depth: bpp: %d, green.length is %d\n",
 		var->bits_per_pixel, var->green.length);
-- 
2.10.0.rc2.1.g053435c

