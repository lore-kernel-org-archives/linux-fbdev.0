From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 16 Jan 2020 14:56:50 +0000
Subject: [PATCH 1/2] video: fbdev: wm8505fb: fix sparse warnings about using incorrect types
Message-Id: <567cba81-5fec-4d91-f711-c0bdbfe5b513@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116145653eucas1p2222fb48dd6fe1023a4152e687ec577d5@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Prisk <linux@prisktech.co.nz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Use ->screen_buffer instead of ->screen_base to fix sparse warnings.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Resend with Tony & linux-arm ML added to Cc:.

 drivers/video/fbdev/wm8505fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/wm8505fb.c
=================================--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -339,7 +339,7 @@ static int wm8505fb_probe(struct platfor
 
 	fbi->fb.fix.smem_start		= fb_mem_phys;
 	fbi->fb.fix.smem_len		= fb_mem_len;
-	fbi->fb.screen_base		= fb_mem_virt;
+	fbi->fb.screen_buffer		= fb_mem_virt;
 	fbi->fb.screen_size		= fb_mem_len;
 
 	fbi->contrast = 0x10;
