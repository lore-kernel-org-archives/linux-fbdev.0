From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 23 Nov 2014 11:33:40 +0000
Subject: [PATCH 1/1] video: smscufx: Deletion of unnecessary checks before the function call "vfree"
Message-Id: <5471C614.2030806@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Steve Glendinning <steve.glendinning@shawell.net>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 23 Nov 2014 12:30:33 +0100

The vfree() function performs also input parameter validation. Thus the test
around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/smscufx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index d513ed6..9279e5f 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1142,8 +1142,7 @@ static void ufx_free_framebuffer_work(struct work_struct *work)
 		fb_dealloc_cmap(&info->cmap);
 	if (info->monspecs.modedb)
 		fb_destroy_modedb(info->monspecs.modedb);
-	if (info->screen_base)
-		vfree(info->screen_base);
+	vfree(info->screen_base);
 
 	fb_destroy_modelist(&info->modelist);
 
@@ -1743,8 +1742,7 @@ error:
 				fb_dealloc_cmap(&info->cmap);
 			if (info->monspecs.modedb)
 				fb_destroy_modedb(info->monspecs.modedb);
-			if (info->screen_base)
-				vfree(info->screen_base);
+			vfree(info->screen_base);
 
 			fb_destroy_modelist(&info->modelist);
 
-- 
2.1.3

