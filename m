From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 11:58:47 +0000
Subject: [PATCH v2 2/2] video/fbdev/stifb: Delete an error message for a failed memory allocation in stifb_in
Message-Id: <f92f41b1-d4fa-4ffa-8c19-af4eb0d2d8cf@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7dcd32b6-9691-14a1-29cf-3a746ef5adfc@users.sourceforge.net>
 <CGME20171124213055epcas4p45c641222185056871b97f4e7bc235d2e@epcas4p4.samsung.com>
 <25624997.nONnEdNj0s@daneel.sf-tec.de> <1680261.Msdj7gi9fB@amdc3058>
 <889131fe-199c-3bef-0781-00761b807426@users.sourceforge.net>
In-Reply-To: <889131fe-199c-3bef-0781-00761b807426@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Helge Deller <deller@gmx.de>, "James E. J. Bottomley" <jejb@parisc-linux.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 12:34:22 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
This update suggestion was rebased on source files from the software
"Linux next-20180105" together with a change for an error code.

 drivers/video/fbdev/stifb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index 511a594889af..dec8efb4f256 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1126,10 +1126,8 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	int bpp, xres, yres;
 
 	fb = kzalloc(sizeof(*fb), GFP_ATOMIC);
-	if (!fb) {
-		printk(KERN_ERR "stifb: Could not allocate stifb structure\n");
+	if (!fb)
 		return -ENOMEM;
-	}
 	
 	info = &fb->info;
 
-- 
2.15.1

