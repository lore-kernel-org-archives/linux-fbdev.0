From: ben@fluff.org.uk
Subject: [patch 1/5] FB/SM501: Ensure console suspended
	before saving state
Date: Wed, 30 Jan 2008 01:30:12 +0000
Message-ID: <20080130013105.789166485@fluff.org.uk>
References: <20080130013011.604188602@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JK1na-0007Au-7U for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jan 2008 17:31:34 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JK1nZ-0003Q8-MD
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jan 2008 17:31:34 -0800
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-sm501-suspendbeforecopy.patch
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
To: Linux FB <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vincent Sanders <vince@simtec.co.uk>, Ben Dooks <ben-linux@fluff.org>

Move the console suspend to before we save the state of
the framebuffer to ensure that it does not try and change
the fb state again once we have copied it out.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.22-quilt9/drivers/video/sm501fb.c
===================================================================
--- linux-2.6.22-quilt9.orig/drivers/video/sm501fb.c
+++ linux-2.6.22-quilt9/drivers/video/sm501fb.c
@@ -1681,6 +1681,15 @@ static int sm501fb_suspend_fb(struct sm5
 	if (par->screen.size == 0)
 		return 0;
 
+	/* blank the relevant interface to ensure unit power minimised */
+	(par->ops.fb_blank)(FB_BLANK_POWERDOWN, fbi);
+
+	/* tell console/fb driver we are suspending */
+
+	acquire_console_sem();
+	fb_set_suspend(fbi, 1);
+	release_console_sem();
+
 	/* backup copies in case chip is powered down over suspend */
 
 	par->store_fb = vmalloc(par->screen.size);
@@ -1700,12 +1709,6 @@ static int sm501fb_suspend_fb(struct sm5
 
 	memcpy_fromio(par->store_fb, par->screen.k_addr, par->screen.size);
 	memcpy_fromio(par->store_cursor, par->cursor.k_addr, par->cursor.size);
-	/* blank the relevant interface to ensure unit power minimised */
-	(par->ops.fb_blank)(FB_BLANK_POWERDOWN, fbi);
-
-	acquire_console_sem();
-	fb_set_suspend(fbi, 1);
-	release_console_sem();
 
 	return 0;
 

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
