From: Alex Stewart <alex@foogod.com>
Subject: Re: [PATCH] neofb patches
Date: Thu, 22 Apr 2004 21:03:13 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040423040313.GA4403@foogod.com>
References: <20040422031855.GA19220@foogod.com> <Pine.LNX.4.44.0404222152260.25952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGruR-0002bw-D9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 21:03:27 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGruR-00074Y-0d
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 21:03:27 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404222152260.25952-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Well, I downloaded your diff for the neofb driver and tried it out.  I did
notice there appears to be a slight bug in it.  Whenever anything (such as
fbset) closes /dev/fb0, the driver clobbers the device registers (resulting in
a blank screen).

I'm assuming the attached correction is more what was intended..

I'm currently merging our two sets of patches into one driver.  I do note that
patch gets a little confused when trying to do it itself and places a couple of
bits of code in really odd places, which might have been part of why it didn't
work for you.  I think I should have an updated patchset ready to post later
tonight..

-alex

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb-js.1.releasebug.patch"

--- drivers/video/neofb.c.jsimmons	2004-04-22 18:32:19.000000000 -0700
+++ drivers/video/neofb.c	2004-04-22 21:21:02.000000000 -0700
@@ -562,7 +562,7 @@
 	struct neofb_par *par = (struct neofb_par *) info->par;
 	int cnt = atomic_read(&par->ref_count);
 
-	if (cnt) {
+	if (!cnt) {
 		memset(&par->state, 0, sizeof(struct vgastate));
 		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS;
 		save_vga(&par->state);

--yrj/dFKFPuw6o+aM--


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
