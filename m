From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 11:56:45 +0000
Subject: [PATCH v2 1/2] video/fbdev/stifb: Return -ENOMEM after a failed kzalloc() in stifb_init_fb()
Message-Id: <6341951e-df28-0b40-974e-dedd890b5228@users.sourceforge.net>
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
Date: Sun, 7 Jan 2018 11:33:59 +0100

Replace an error code for the indication of a memory allocation failure
in this function.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac ("Linux-2.6.12-rc2: Initial git repository build")
Suggested-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/stifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index 6ded5c198998..511a594889af 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1128,7 +1128,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	fb = kzalloc(sizeof(*fb), GFP_ATOMIC);
 	if (!fb) {
 		printk(KERN_ERR "stifb: Could not allocate stifb structure\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
 	
 	info = &fb->info;
-- 
2.15.1

