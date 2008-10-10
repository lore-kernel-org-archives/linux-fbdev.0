From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH v2] framebuffer: fix carminefb section
	mismatch
Date: Fri, 10 Oct 2008 13:25:18 -0700
Message-ID: <20081010132518.c6615b54.randy.dunlap@oracle.com>
References: <48ED2431.40609@oracle.com>
	<Pine.LNX.4.64.0810090927350.6769@anakin>
	<48EE1ECF.6040707@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <randy.dunlap@oracle.com>) id 1KoOb1-0005GG-C2
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Oct 2008 20:28:23 +0000
Received: from rgminet01.oracle.com ([148.87.113.118])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KoOav-00029c-Vt
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Oct 2008 20:28:23 +0000
In-Reply-To: <48EE1ECF.6040707@oracle.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Sebastian Siewior <bigeasy@linutronix.de>

From: Randy Dunlap <randy.dunlap@oracle.com>

Make alloc_carmine_fb() __devinit.

WARNING: drivers/video/carminefb.o(.text+0x81b): Section mismatch in reference from the function alloc_carmine_fb() to the variable .devinit.data:carminefb_fix
The function alloc_carmine_fb() references
the variable __devinitdata carminefb_fix.
This is often because alloc_carmine_fb lacks a __devinitdata 
annotation or the annotation of carminefb_fix is wrong.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
cc: Sebastian Siewior <bigeasy@linutronix.de>
---
 drivers/video/carminefb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lin2627-r9g1-sections.orig/drivers/video/carminefb.c
+++ lin2627-r9g1-sections/drivers/video/carminefb.c
@@ -535,7 +535,7 @@ static struct fb_ops carminefb_ops = {
 	.fb_setcolreg	= carmine_setcolreg,
 };
 
-static int alloc_carmine_fb(void __iomem *regs, void __iomem *smem_base,
+static int __devinit alloc_carmine_fb(void __iomem *regs, void __iomem *smem_base,
 		int smem_offset, struct device *device, struct fb_info **rinfo)
 {
 	int ret;

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
