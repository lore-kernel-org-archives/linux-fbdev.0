From: Timur Tabi <timur@freescale.com>
Date: Tue, 16 Oct 2012 22:33:43 +0000
Subject: [PATCH 2/9] drivers/video: fsl-diu-fb: simplify platforms that have only one port
Message-Id: <1350426830-12140-2-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Allow the platform code not to define a value for diu_ops.set_monitor_port.
This would be for platforms that only have one monitor port.
set_monitor_port() will never be called with an unsupported port anyway.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index ede9e55..5b12e17 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -792,7 +792,8 @@ static void update_lcdc(struct fb_info *info)
 
 	hw = data->diu_reg;
 
-	diu_ops.set_monitor_port(data->monitor_port);
+	if (diu_ops.set_monitor_port)
+		diu_ops.set_monitor_port(data->monitor_port);
 	gamma_table_base = data->gamma;
 
 	/* Prep for DIU init  - gamma table, cursor table */
-- 
1.7.3.4


