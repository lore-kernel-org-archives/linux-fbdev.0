From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] fbdev: workaround for broken X servers
Date: Wed, 03 Nov 2004 13:13:39 +1100
Message-ID: <1099448020.900.25.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPAmB-0001h6-V5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 18:21:31 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CPAmA-0007Iv-G1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 18:21:31 -0800
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
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

XFree (and X.org) has both always been broken in their conversion of the DPMS
blanking mode when passing to the kernel ioctl FBIOBLANK (in fbdev mode).

This patch makes sure that at least the value passed by userland stays in the
legal range, which has the side effect that an X DPMS POWERDOWN request will
result as an fbdev VESA_POWERDOWN request at the fbdev level now, instead of
an out-of-range value.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/fbmem.c
===================================================================
--- linux-work.orig/drivers/video/fbmem.c	2004-10-26 13:15:55.000000000 +1000
+++ linux-work/drivers/video/fbmem.c	2004-11-03 13:10:41.324932256 +1100
@@ -748,6 +748,10 @@
 	u16 *black = NULL;
 	int err = 0;
 	
+	/* Workaround for broken X servers */
+	if (blank > VESA_POWERDOWN)
+		blank = VESA_POWERDOWN;
+
 	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
 		return 0;
 




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
