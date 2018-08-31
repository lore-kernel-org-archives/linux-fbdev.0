From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 31 Aug 2018 08:09:43 +0000
Subject: [PATCH 2/2] fbdev: sbuslib: integer overflow in sbusfb_ioctl_helper()
Message-Id: <20180831080943.ldzpzha5suktn4ln@kili.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Peter Malone <peter.malone@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, Philippe Ombredanne <pombredanne@nexb.com>

The "index + count" addition can overflow.  Both come directly from the
user.  This bug leads to an information leak.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Btw, commit 250c6c49e3b6 ("fbdev: Fixing arbitrary kernel leak in case
FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().") doesn't do anything so
far as I can see.  The "cmap->len" variable is type u32, so the
comparison was already unsigned in the original code because of type
promotion.  But the commit was also harmless and nice cleanup.

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index 90c51330969c..01a7110e61a7 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -171,7 +171,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		    get_user(ublue, &c->blue))
 			return -EFAULT;
 
-		if (index + count > cmap->len)
+		if (index > cmap->len || count > cmap->len - index)
 			return -EINVAL;
 
 		for (i = 0; i < count; i++) {
