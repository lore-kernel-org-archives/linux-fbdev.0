From: Jakub Bogusz <qboosh@pld-linux.org>
Subject: [PATCH] don't use floating point in tdfxfb
Date: Wed, 25 Feb 2004 12:55:31 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040225115530.GF16814@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvxmS-0007It-7I
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 04:04:48 -0800
Received: from gruby.cs.net.pl ([62.233.142.99] ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AvxQm-0006Ib-2r
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Feb 2004 03:42:24 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch removes using of floating point operations in tdfxfb - they
are really not needed here (these consts are used only in substitutions
and comparisons with integers) are cause unresolved symbols on some
archs - e.g. on alpha:

*** Warning: "__ltdf2" [drivers/video/tdfxfb.ko] undefined!
*** Warning: "__adddf3" [drivers/video/tdfxfb.ko] undefined!
*** Warning: "__floatsidf" [drivers/video/tdfxfb.ko] undefined!


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-nofloat.patch"

--- linux-2.6.3/drivers/video/tdfxfb.c.orig	2004-02-24 11:08:06.000000000 +0100
+++ linux-2.6.3/drivers/video/tdfxfb.c	2004-02-25 12:33:09.000000000 +0100
@@ -86,9 +86,9 @@
 #define DPRINTK(a,b...)
 #endif 
 
-#define BANSHEE_MAX_PIXCLOCK 270000.0
-#define VOODOO3_MAX_PIXCLOCK 300000.0
-#define VOODOO5_MAX_PIXCLOCK 350000.0
+#define BANSHEE_MAX_PIXCLOCK 270000
+#define VOODOO3_MAX_PIXCLOCK 300000
+#define VOODOO5_MAX_PIXCLOCK 350000
 
 static struct fb_fix_screeninfo tdfx_fix __initdata = {
 	.id =		"3Dfx",

--vtzGhvizbBRQ85DL--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
