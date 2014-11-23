From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 23 Nov 2014 15:00:06 +0000
Subject: [PATCH 1/1] video: fbdev-MMP: Deletion of an unnecessary check before the function call "mmp_unregis
Message-Id: <5471F676.9070501@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 23 Nov 2014 15:45:03 +0100

The mmp_unregister_path() function tests whether its argument is NULL
and then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 8621a9f..3c12bd8 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -441,8 +441,7 @@ static void path_deinit(struct mmphw_path_plat *path_plat)
 	if (!path_plat)
 		return;
 
-	if (path_plat->path)
-		mmp_unregister_path(path_plat->path);
+	mmp_unregister_path(path_plat->path);
 }
 
 static int mmphw_probe(struct platform_device *pdev)
-- 
2.1.3

