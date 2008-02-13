From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: [PATCH] vt8623fb: beter resume from STR
Date: Wed, 13 Feb 2008 23:42:13 +0100
Message-ID: <20080213224213.GA7181@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPQJ5-00077G-9B for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 14:42:23 -0800
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JPQJ3-0007L2-E6
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 14:42:22 -0800
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

After resume from STR, image is shifted by 8 pixels to the left.
This patch fixes it.

Patch is against 2.6.24.2

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>

diff -uprN -X linux-2.6.24.2.old/Documentation/dontdiff linux-2.6.24.2.old/drivers/video/vt8623fb.c linux-2.6.24.2.new/drivers/video/vt8623fb.c
--- linux-2.6.24.2.old/drivers/video/vt8623fb.c	2008-02-11 06:51:11.000000000 +0100
+++ linux-2.6.24.2.new/drivers/video/vt8623fb.c	2008-02-11 11:08:51.000000000 +0100
@@ -434,6 +434,10 @@ static int vt8623fb_set_par(struct fb_in
 	svga_wcrt_multi(vt8623_offset_regs, offset_value);
 	svga_wseq_multi(vt8623_fetch_count_regs, fetch_value);
 
+	/* Clear H/V Skew */
+	svga_wcrt_mask(0x03, 0x00, 0x60);
+	svga_wcrt_mask(0x05, 0x00, 0x60);
+
 	if (info->var.vmode & FB_VMODE_DOUBLE)
 		svga_wcrt_mask(0x09, 0x80, 0x80);
 	else


-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
