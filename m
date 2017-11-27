From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 09:00:47 +0000
Subject: [PATCH] video: fsl-diu-fb: Delete an error message for a failed memory allocation in fsl_diu_init()
Message-Id: <39d05a48-e649-fb88-0e86-4f7528fd67f8@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Timur Tabi <timur@tabi.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 09:56:09 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/fsl-diu-fb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 25abbcf38913..1bfd13cbd4e3 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1960,12 +1960,8 @@ static int __init fsl_diu_init(void)
 
 	of_node_put(np);
 	coherence_data = vmalloc(coherence_data_size);
-	if (!coherence_data) {
-		pr_err("fsl-diu-fb: could not allocate coherence data "
-		       "(size=%zu)\n", coherence_data_size);
+	if (!coherence_data)
 		return -ENOMEM;
-	}
-
 #endif
 
 	ret = platform_driver_register(&fsl_diu_driver);
-- 
2.15.0

