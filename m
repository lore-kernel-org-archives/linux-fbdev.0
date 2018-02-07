From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 07 Feb 2018 00:04:24 +0000
Subject: [PATCH] video: fbdev: vermilion: use 64-bit arithmetic instead of 32-bit
Message-Id: <20180207000424.GA32680@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Cast _pitch_ to u64 in order to give the compiler complete information
about the proper arithmetic to use. Notice that this variable is
being used in a context that expects an expression of type u64
(64 bits, unsigned).

The expression pitch * var->yres_virtual is currently being evaluated
using 32-bit arithmetic and the result of the operation is being stored
into variable mem, which is a variable of type u64. Based on that,
chances are there is a potential integer overflow as a result of the
operation.

Addresses-Coverity-ID: 200655 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/vermilion/vermilion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index 6f8d444..5172fa5 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -651,7 +651,7 @@ static int vmlfb_check_var_locked(struct fb_var_screeninfo *var,
 	}
 
 	pitch = ALIGN((var->xres * var->bits_per_pixel) >> 3, 0x40);
-	mem = pitch * var->yres_virtual;
+	mem = (u64)pitch * var->yres_virtual;
 	if (mem > vinfo->vram_contig_size) {
 		return -ENOMEM;
 	}
-- 
2.7.4

