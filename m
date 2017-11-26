From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 10:18:26 +0000
Subject: [PATCH 2/4] video: sm501fb: Improve a size determination in sm501fb_probe()
Message-Id: <08ed1e90-5714-04b7-b3dc-067a3d9bc38b@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
In-Reply-To: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 10:22:37 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/sm501fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index e8301c4e7d44..80bda5a655c0 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1932,8 +1932,7 @@ static int sm501fb_probe(struct platform_device *pdev)
 	int ret;
 
 	/* allocate our framebuffers */
-
-	info = kzalloc(sizeof(struct sm501fb_info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-- 
2.15.0

