From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] pm3fb: fix section mismatch warnings
Date: Fri, 11 Jan 2008 17:04:01 -0800
Message-ID: <20080111170401.694b066f.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JDUnG-0001qw-L3 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 17:04:14 -0800
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JDUnG-00075K-9p
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 17:04:14 -0800
Received: from midway.site ([71.245.106.199]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 11 Jan 2008 17:04:01 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, romain@dolbeau.org, krzysztof.h1@wp.pl
Cc: akpm <akpm@linux-foundation.org>, samr <sam@ravnborg.org>, adaplas@gmail.com

From: Randy Dunlap <randy.dunlap@oracle.com>

Add __devinit to one function to clean up section mismatch warnings:

WARNING: vmlinux.o(.text+0x47c176): Section mismatch: reference to .init.data: (between 'pm3fb_size_memory' and 'update_crtc2')
WARNING: vmlinux.o(.text+0x47c188): Section mismatch: reference to .init.data: (between 'pm3fb_size_memory' and 'update_crtc2')
WARNING: vmlinux.o(.text+0x47c1ba): Section mismatch: reference to .init.data: (between 'pm3fb_size_memory' and 'update_crtc2')
WARNING: vmlinux.o(.text+0x47c1c1): Section mismatch: reference to .init.data: (between 'pm3fb_size_memory' and 'update_crtc2')
WARNING: vmlinux.o(.text+0x47c1e2): Section mismatch: reference to .init.data: (between 'pm3fb_size_memory' and 'update_crtc2')
WARNING: vmlinux.o(.text+0x47c1e9): Section mismatch: reference to .init.data: (between 'pm3fb_size_memory' and 'update_crtc2')
WARNING: vmlinux.o(.text+0x47c2f0): Section mismatch: reference to .init.data: (between 'pm3fb_size_memory' and 'update_crtc2')
WARNING: vmlinux.o(.text+0x47c2f7): Section mismatch: reference to .init.data: (between 'pm3fb_size_memory' and 'update_crtc2')

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/pm3fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.24-rc7-git1.orig/drivers/video/pm3fb.c
+++ linux-2.6.24-rc7-git1/drivers/video/pm3fb.c
@@ -1227,7 +1227,7 @@ static struct fb_ops pm3fb_ops = {
 
 /* mmio register are already mapped when this function is called */
 /* the pm3fb_fix.smem_start is also set */
-static unsigned long pm3fb_size_memory(struct pm3_par *par)
+static unsigned long __devinit pm3fb_size_memory(struct pm3_par *par)
 {
 	unsigned long	memsize = 0;
 	unsigned long	tempBypass, i, temp1, temp2;
---
~Randy

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
