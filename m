From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Feb 2015 13:26:02 +0000
Subject: [PATCH] video: fbdev-SIS: Deletion of unnecessary checks before three function calls
Message-Id: <54E8876A.9090108@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thomas Winischhofer <thomas@winischhofer.net>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Feb 2015 14:14:56 +0100

The functions sisfb_search_crt2type(), sisfb_search_specialtiming() and
sisfb_search_tvstd() test whether their argument is NULL and then
return immediately. Thus the test around their calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/sis/sis_main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index fcf610e..20ca80f 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -6605,12 +6605,9 @@ static int __init sisfb_init_module(void)
 		sisfb_scalelcd = scalelcd ^ 1;
 
 	/* Need to check crt2 type first for fstn/dstn */
+	sisfb_search_crt2type(forcecrt2type);
 
-	if(forcecrt2type)
-		sisfb_search_crt2type(forcecrt2type);
-
-	if(tvstandard)
-		sisfb_search_tvstd(tvstandard);
+	sisfb_search_tvstd(tvstandard);
 
 	if(mode)
 		sisfb_search_mode(mode, false);
@@ -6656,9 +6653,7 @@ static int __init sisfb_init_module(void)
 		sisfb_pdca = (pdc1 & 0x1f);
 
 	sisfb_nocrt2rate = nocrt2rate;
-
-	if(specialtiming)
-		sisfb_search_specialtiming(specialtiming);
+	sisfb_search_specialtiming(specialtiming);
 
 	if((lvdshl >= 0) && (lvdshl <= 3))
 		sisfb_lvdshl = lvdshl;
-- 
2.3.0

