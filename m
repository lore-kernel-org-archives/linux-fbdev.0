From: Ben Dooks <ben@simtec.co.uk>
Subject: [PATCH 3/4] SM501: Fix use of old <asm/io.h>
	instead of <linux/io.h>
Date: Mon, 23 Nov 2009 16:01:27 +0000
Message-ID: <20091123160145.113400548@fluff.org.uk>
References: <20091123160124.403392586@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ben@fluff.org.uk>) id 1NCbMn-0003JX-Dg
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Nov 2009 16:02:17 +0000
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NCbMh-0003zP-0g
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Nov 2009 16:02:17 +0000
Content-Disposition: inline; filename=simtec/ready/sm501-fix-io-include.patch
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

Fix the old style use of <asm/io.h> by replacing it with <linux/io.h>.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 drivers/video/sm501fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/sm501fb.c
===================================================================
--- a/drivers/video/sm501fb.c	2009-11-10 19:33:55.000000000 +0000
+++ b/drivers/video/sm501fb.c	2009-11-10 19:34:04.000000000 +0000
@@ -29,8 +29,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/console.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
