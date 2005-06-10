From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] radeonfb: don't blow up VGA console on load
Date: Sat, 11 Jun 2005 09:45:30 +1000
Message-ID: <1118447130.5986.69.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgtCG-0006lz-87
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 16:45:56 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DgtCD-0004KZ-R2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 16:45:55 -0700
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>

Hi !

Current radeonfb memset's the framebuffer to 0 when loaded. This removes
occasional artifacts but has the nasty side effect that if you load
radeonfb without framebuffer console, you destroy the VGA text buffer,
font, etc... radeon must not touch the framebuffer content when it
doesn't "own" it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-06-09 16:22:08.000000000 +1000
+++ linux-work/drivers/video/aty/radeon_base.c	2005-06-11 09:42:19.000000000 +1000
@@ -2374,10 +2374,9 @@
 	} while (   rinfo->fb_base == 0 &&
 		  ((rinfo->mapped_vram /=2) >= MIN_MAPPED_VRAM) );
 
-	if (rinfo->fb_base)
-		memset_io(rinfo->fb_base, 0, rinfo->mapped_vram);
-	else {
-		printk (KERN_ERR "radeonfb (%s): cannot map FB\n", pci_name(rinfo->pdev));
+	if (rinfo->fb_base == NULL) {
+		printk (KERN_ERR "radeonfb (%s): cannot map FB\n",
+			pci_name(rinfo->pdev));
 		ret = -EIO;
 		goto err_unmap_rom;
 	}




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
