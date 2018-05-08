From: Colin King <colin.king@canonical.com>
Date: Tue, 08 May 2018 22:36:19 +0000
Subject: [PATCH] video: fbdev: nvidia: fix spelling mistake: "scaleing" -> "scaling"
Message-Id: <20180508223619.25557-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in module parameter description text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/nvidia/nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 418a2d0d06a9..34521f52aa3b 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1548,7 +1548,7 @@ MODULE_PARM_DESC(noaccel,
 		 "(default=0)");
 module_param(noscale, int, 0);
 MODULE_PARM_DESC(noscale,
-		 "Disables screen scaleing. (0 or 1=disable) "
+		 "Disables screen scaling. (0 or 1=disable) "
 		 "(default=0, do scaling)");
 module_param(paneltweak, int, 0);
 MODULE_PARM_DESC(paneltweak,
-- 
2.17.0

