From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Error in fbcon_switch ?
Date: Tue, 20 May 2008 23:11:21 +0200
Message-ID: <20080520231121.a8fbecc1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyZ60-0001PZ-Kl for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 14:10:08 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JyZ60-0005G1-4v
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 14:10:08 -0700
Received: from poczta.interia.pl (mi05.te.interia.pl [10.217.12.5])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 1FEE9664DA7
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 May 2008 23:09:50 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 6825ABE189C
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 May 2008 23:09:45 +0200 (CEST)
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I run into issue when two virtual consoles (tty1 and tty2) are set to different
display modes: one with interlace and one without. When console is switched,
the setting of the interlaced mode is not honoured, ie. 

tty1 (lace) -> tty2 (non-lace) -> tty1 (lace) -> tty2 (non-lace)

gives

tty1 (lace) -> tty2 (lace) -> tty1 (lace) -> tty2 (lace)

Of course, the refresh rate (and other timings) are not correct on the tty2 as
the resolution and pixclock are preserved.

I found that root of the problem is that fbcon_switch copies the var.vmode 
field from the previous console. If this copy is removed everything is alright, ie.

tty1 (lace) -> tty2 (non-lace) -> tty1 (lace) -> tty2 (non-lace)

Is this a correct solution to the problem? What is a purpose of copying vmode field?

The vmode field contains following settings:

#define FB_VMODE_INTERLACED     1       /* interlaced   */
#define FB_VMODE_DOUBLE         2       /* double scan */
#define FB_VMODE_ODD_FLD_FIRST  4       /* interlaced: top line first */
#define FB_VMODE_MASK           255

#define FB_VMODE_YWRAP          256     /* ywrap instead of panning     */
#define FB_VMODE_SMOOTH_XPAN    512     /* smooth xpan possible (internally used) */
#define FB_VMODE_CONUPDATE      512     /* don't update x/yoffset       */

IMO, at least the first three should not be copied. I am not sure about YWRAP and 
CONUPDATE/SMOOTH_XPAN.

Regards,
Krzysztof
PS. The patch below is my fix:

diff -urp linux-old/drivers/video/console/fbcon.c linux-new/drivers/video/console/fbcon.c
--- linux-old/drivers/video/console/fbcon.c	2008-05-12 19:27:04.305519626 +0200
+++ linux-new/drivers/video/console/fbcon.c	2008-05-20 23:06:44.235878754 +0200
@@ -2266,7 +2266,6 @@ static int fbcon_switch(struct vc_data *
 	info->var.activate = var.activate;
 	var.yoffset = info->var.yoffset;
 	var.xoffset = info->var.xoffset;
-	var.vmode = info->var.vmode;
 	fb_set_var(info, &var);
 	ops->var = info->var;
 


---------------------------------------------------------------------- 	 
4 wolne dni przed Toba!!!
Sprawdz pogode na dlugi weekend >> http://link.interia.pl/f1e02




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
