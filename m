From: "Alex Stewart" <alex@foogod.com>
Subject: fbcon VT (mode) switching issue
Date: Tue, 27 Apr 2004 13:59:54 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <10040.159.37.7.44.1083099594.squirrel@www.foogod.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIZgS-0003UL-8Z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 14:00:04 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIZgR-0008RN-58
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 14:00:03 -0700
Received: from firestar.foogod.com (firestar [127.0.0.1])
	by firestar.foogod.com (8.12.8/8.12.5) with ESMTP id i3RKxslu026280
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 Apr 2004 13:59:54 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net

I'm still trying to sort out a few of the little "annoyance" issues still
present in the neofb driver.  One of these is the following:

If I change VT from XFree86 (using its own neomagic driver, not through
fb) to a framebuffer console, and the resolution/bitdepth of the console
screen is different from what the X server was using, the screen is not
initially repainted correctly.

This appears to be due to the fact that when changing VTs, set_par (which
is where neofb changes the hardware video mode) isn't called until
sometime after the fbcon code uses imageblit to transfer the console text
to the screen.  The result is that the accelerated imageblit is done with
the hardware still set to the old screen resolution/depth, and thus the
neomagic chip writes the data to memory in a form appropriate for the old
mode, not the new one that we're switching to.

I've tried to figure out how this whole process works and what the best
fix for this problem is, but to be honest, trying to follow some of the
code paths in the framebuffer console system is rather like trying to
follow Brer Rabbit through the briar patch..  I could use the help of
somebody a bit more familiar with this part of things, I think.

I have determined that adding a call to set_par at the beginning of
fbcon_switch does fix the problem.  Of course it also ends up calling
set_par twice during the overall switching procedure (with noticeable
flicker), and I'm not really sure this is the right place to put it
anyway, so I wanted to get people's opinion as to what the right fix is..

-alex




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
