From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OMAP: div reaches max_clk_div.
Date: Wed, 11 Feb 2009 21:21:45 +0100
Message-ID: <49933359.4070206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LXLaZ-0007Wb-4I
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Feb 2009 20:21:43 +0000
Received: from nf-out-0910.google.com ([64.233.182.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LXLaW-0001K0-3D for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Feb 2009 20:21:43 +0000
Received: by nf-out-0910.google.com with SMTP id k4so58647nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 11 Feb 2009 12:21:39 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

With for(div = 0; div < max_clk_div; div++) { ... } div reaches max_clk_div.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index f24df0b..8aa6e47 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -742,7 +742,7 @@ static int calc_extif_timings(unsigned long sysclk, int *extif_mem_div)
 		if (calc_reg_timing(sysclk, div) == 0)
 			break;
 	}
-	if (div > max_clk_div)
+	if (div >= max_clk_div)
 		goto err;
 
 	*extif_mem_div = div;
@@ -752,7 +752,7 @@ static int calc_extif_timings(unsigned long sysclk, int *extif_mem_div)
 			break;
 	}
 
-	if (div > max_clk_div)
+	if (div >= max_clk_div)
 		goto err;
 
 	return 0;

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
