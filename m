From: Jakub Bogusz <qboosh@pld.org.pl>
Subject: fix for fbcon margins colour in 2.6 (question, not sure)
Date: Mon, 4 Aug 2003 23:58:08 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030804215808.GA11157@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from px230.warszawa.cvx.ppp.tpnet.pl ([217.99.7.230] helo=satan.blackhosts)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19jnPk-0000VZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 04 Aug 2003 15:02:49 -0700
Received: from satan.blackhosts (localhost [127.0.0.1])
	by satan.blackhosts (8.12.9/8.12.9) with ESMTP id h74M4ekk011775
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 5 Aug 2003 00:04:41 +0200
Received: (from qboosh@localhost)
	by satan.blackhosts (8.12.9/8.12.9/Submit) id h74Lw89r011350
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 4 Aug 2003 23:58:08 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

As I already mentioned in my last post about tdfxfb fix, I have a fix
for margins colour in 2.6 (tested on tdfxfb, but this issue is probably
general, not card-specific, as this code exists in fbcon.c), but I'm not
sure if it's 100% correct.

Up to 2.6.0-test2 (on tdfxfb after applying other needed patches, like
Richard Drummond's patch for image blits and my patch for clear colour)
sometimes (usually after vt switch) margins (e.g. half of line at the
bottom of screen when using 100x37 text mode on 800x600 physical mode)
change colour to the colour of some other regions of screen. It's
because margins are filled with attr_bgcol_ec(bgshift, vc) colour, not
black (or, more generally, text background, i.e. colour 0 of pseudo
palette).

Shouldn't text colour 0 always be used to clear margins?
I think it should...
Attached patch changes margins colour to 0, thus fixing issue mentioned
above. I haven't seen any side-effects.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-fbcon-margins.patch"

Shouldn't margins always have text colour 0?
Background of last erase character is definitely not what we want...

--- linux-2.6.0-test2/drivers/video/console/fbcon.c.orig	2003-07-14 05:36:32.000000000 +0200
+++ linux-2.6.0-test2/drivers/video/console/fbcon.c	2003-07-31 00:53:26.000000000 +0200
@@ -502,7 +502,7 @@
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
-	region.color = attr_bgcol_ec(bgshift, vc);
+	region.color = 0;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {

--pWyiEgJYm5f9v55/--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
