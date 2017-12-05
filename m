From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 05 Dec 2017 18:00:22 +0000
Subject: [PATCH] video/console/sticore: Delete an error message for a failed memory allocation in sti_try_rom
Message-Id: <6b8dde60-0550-5fb3-c7a5-5f6282259186@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Helge Deller <deller@gmx.de>, "James E. J. Bottomley" <jejb@parisc-linux.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 5 Dec 2017 18:45:42 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/console/sticore.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index d1d3796773aa..08b822656846 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -827,10 +827,8 @@ static struct sti_struct *sti_try_rom_generic(unsigned long address,
 	}
 	
 	sti = kzalloc(sizeof(*sti), GFP_KERNEL);
-	if (!sti) {
-		printk(KERN_ERR "Not enough memory !\n");
+	if (!sti)
 		return NULL;
-	}
 
 	spin_lock_init(&sti->lock);
 
-- 
2.15.1

