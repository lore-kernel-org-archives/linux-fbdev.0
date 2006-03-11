From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/18] s1d13xxxfb: Fix resource leak
Date: Sat, 11 Mar 2006 09:50:07 +0800
Message-ID: <44122CCF.6080500@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtNP-0002WS-Ui
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:58:39 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtNP-0003lQ-Q0
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:58:40 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:58:37 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Thibaut VARENE <varenet@parisc-linux.org>

struct info may not be released in the driver's error path.

Coverity Bug 672

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/s1d13xxxfb.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index e5d0f92..feec47b 100644
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -588,6 +588,7 @@ s1d13xxxfb_probe(struct platform_device 
 		goto bail;
 	}
 
+	platform_set_drvdata(pdev, info);
 	default_par = info->par;
 	default_par->regs = ioremap_nocache(pdev->resource[1].start,
 			pdev->resource[1].end - pdev->resource[1].start +1);
@@ -638,8 +639,6 @@ s1d13xxxfb_probe(struct platform_device 
 		goto bail;
 	}
 
-	platform_set_drvdata(pdev, info);
-
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
 	       info->node, info->fix.id);
 




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
