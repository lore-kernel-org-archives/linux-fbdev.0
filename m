From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] tgafb: Remove a redundant non-mono test
	in mono imageblit
Date: Mon, 15 Oct 2007 18:42:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0710151836490.16262@blysk.ds.pg.gda.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IhTy6-0002xQ-TG for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Oct 2007 10:43:07 -0700
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IhTy6-0005Rv-D9
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Oct 2007 10:43:06 -0700
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
To: Andrew Morton <akpm@linux-foundation.org>, Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-mips@linux-mips.org, Jay Estabrook <Jay.Estabrook@hp.com>, linux-kernel@vger.kernel.org

 There is a test in tgafb_mono_imageblit() for a colour image with a 
fall-back to cfb_imageblit().  The test is not necessary as the only 
caller, which is tgafb_imageblit(), checks it too and only invokes this 
function for monochrome images.  It looks like a left-over from before 
some changes to tgafb_imageblit().

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Checked with checkpatch.pl and at the run time with an 8-bit TC frame
buffer on a MIPS host.

 Please apply.

  Maciej

patch-mips-2.6.23-rc5-20070904-tgafb-mono_imageblit-depth-0
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/video/tgafb.c linux-mips-2.6.23-rc5-20070904/drivers/video/tgafb.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/video/tgafb.c	2007-09-04 04:55:46.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/video/tgafb.c	2007-10-14 20:32:13.000000000 +0000
@@ -636,15 +636,6 @@ tgafb_mono_imageblit(struct fb_info *inf
 
 	is8bpp = info->var.bits_per_pixel == 8;
 
-	/* For copies that aren't pixel expansion, there's little we
-	   can do better than the generic code.  */
-	/* ??? There is a DMA write mode; I wonder if that could be
-	   made to pull the data from the image buffer...  */
-	if (image->depth > 1) {
-		cfb_imageblit(info, image);
-		return;
-	}
-
 	dx = image->dx;
 	dy = image->dy;
 	width = image->width;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
