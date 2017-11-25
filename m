From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 20:47:46 +0000
Subject: [PATCH 4/5] video: smscufx: Improve a size determination in two functions
Message-Id: <0c32185c-afe2-5667-2455-6aa7e48e70c0@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
In-Reply-To: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 21:10:22 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/smscufx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index c77fc45a76fc..03d35429e1b9 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1086,8 +1086,7 @@ static int ufx_ops_open(struct fb_info *info, int user)
 
 		struct fb_deferred_io *fbdefio;
 
-		fbdefio = kzalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
-
+		fbdefio = kzalloc(sizeof(*fbdefio), GFP_KERNEL);
 		if (fbdefio) {
 			fbdefio->delay = UFX_DEFIO_WRITE_DELAY;
 			fbdefio->deferred_io = ufx_dpy_deferred_io;
@@ -1857,7 +1856,7 @@ static int ufx_alloc_urb_list(struct ufx_data *dev, int count, size_t size)
 	INIT_LIST_HEAD(&dev->urbs.list);
 
 	while (i < count) {
-		unode = kzalloc(sizeof(struct urb_node), GFP_KERNEL);
+		unode = kzalloc(sizeof(*unode), GFP_KERNEL);
 		if (!unode)
 			break;
 		unode->dev = dev;
-- 
2.15.0

