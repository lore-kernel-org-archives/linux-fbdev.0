From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 20:52:19 +0000
Subject: [PATCH 3/4] video: udlfb: Improve a size determination in dlfb_alloc_urb_list()
Message-Id: <d55401c9-1fbb-93b9-40de-2b93396e8def@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
In-Reply-To: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 21:30:37 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/udlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index cb2d59ca67a4..059883962698 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1867,7 +1867,7 @@ static int dlfb_alloc_urb_list(struct dlfb_data *dev, int count, size_t size)
 	INIT_LIST_HEAD(&dev->urbs.list);
 
 	while (i < count) {
-		unode = kzalloc(sizeof(struct urb_node), GFP_KERNEL);
+		unode = kzalloc(sizeof(*unode), GFP_KERNEL);
 		if (!unode)
 			break;
 		unode->dev = dev;
-- 
2.15.0

