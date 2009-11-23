From: Ben Dooks <ben@simtec.co.uk>
Subject: [PATCH 2/4] SM501: Fix missing uses of
	resource_size()
Date: Mon, 23 Nov 2009 16:01:26 +0000
Message-ID: <20091123160144.936773910@fluff.org.uk>
References: <20091123160124.403392586@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ben@fluff.org.uk>) id 1NCbMp-0000x8-67
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Nov 2009 16:02:19 +0000
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NCbMh-0006jy-Cw
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Nov 2009 16:02:19 +0000
Content-Disposition: inline;
	filename=simtec/ready/sm501-use-resource-size.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: krzysztof.h1@wp.p, akpm@linux-foundation.org
Cc: lethal@linux-sh.org, dilinger@debian.org, linux-fbdev-devel@lists.sourceforge.net, Simtec Linux Team <linux@simtec.co.uk>

There are several places in the SM501 fb driver that could do with using
resource_size() to calculate the size of a resource.

Also fix a bug where request_mem_region() is being passed one too few
bytes when requesting the register memory region, which was causing
the following in /proc/iomem:

 13e80000-13e8ffff : sm501-fb.0
   13e80000-13e8fffe : sm501-fb

fixed, this reads:

 13e80000-13e8ffff : sm501-fb.0
   13e80000-13e8ffff : sm501-fb

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 drivers/video/sm501fb.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: b/drivers/video/sm501fb.c
===================================================================
--- a/drivers/video/sm501fb.c	2009-09-09 23:13:59.000000000 +0100
+++ b/drivers/video/sm501fb.c	2009-11-10 19:31:25.000000000 +0000
@@ -1338,7 +1338,7 @@ static int sm501fb_start(struct sm501fb_
 	}
 
 	info->regs_res = request_mem_region(res->start,
-					    res->end - res->start,
+					    resource_size(res),
 					    pdev->name);
 
 	if (info->regs_res == NULL) {
@@ -1347,7 +1347,7 @@ static int sm501fb_start(struct sm501fb_
 		goto err_release;
 	}
 
-	info->regs = ioremap(res->start, (res->end - res->start)+1);
+	info->regs = ioremap(res->start, resource_size(res));
 	if (info->regs == NULL) {
 		dev_err(dev, "cannot remap registers\n");
 		ret = -ENXIO;
@@ -1363,7 +1363,7 @@ static int sm501fb_start(struct sm501fb_
 	}
 
 	info->fbmem_res = request_mem_region(res->start,
-					     (res->end - res->start)+1,
+					     resource_size(res),
 					     pdev->name);
 	if (info->fbmem_res == NULL) {
 		dev_err(dev, "cannot claim framebuffer\n");
@@ -1371,13 +1371,13 @@ static int sm501fb_start(struct sm501fb_
 		goto err_regs_map;
 	}
 
-	info->fbmem = ioremap(res->start, (res->end - res->start)+1);
+	info->fbmem = ioremap(res->start, resource_size(res));
 	if (info->fbmem == NULL) {
 		dev_err(dev, "cannot remap framebuffer\n");
 		goto err_mem_res;
 	}
 
-	info->fbmem_len = (res->end - res->start)+1;
+	info->fbmem_len = resource_size(res);
 
 	/* clear framebuffer memory - avoids garbage data on unused fb */
 	memset(info->fbmem, 0, info->fbmem_len);


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
