From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbcon VT (mode) switching issue
Date: Wed, 28 Apr 2004 10:44:02 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083113041.20092.17.camel@gaston>
References: <10040.159.37.7.44.1083099594.squirrel@www.foogod.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdGp-0000Bb-OC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:49:51 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIdGp-0002NW-9q
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:49:51 -0700
In-Reply-To: <10040.159.37.7.44.1083099594.squirrel@www.foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> This appears to be due to the fact that when changing VTs, set_par (which
> is where neofb changes the hardware video mode) isn't called until
> sometime after the fbcon code uses imageblit to transfer the console text
> to the screen.  The result is that the accelerated imageblit is done with
> the hardware still set to the old screen resolution/depth, and thus the
> neomagic chip writes the data to memory in a form appropriate for the old
> mode, not the new one that we're switching to.

That's weird, we should get a call to fbcon_blank() triggering an
FB_ACTIVATE_FORCE call before anything is drawn (on the switch from
KD_GRAPHICS to KD_TEXT more specifically).

> I've tried to figure out how this whole process works and what the best
> fix for this problem is, but to be honest, trying to follow some of the
> code paths in the framebuffer console system is rather like trying to
> follow Brer Rabbit through the briar patch..  I could use the help of
> somebody a bit more familiar with this part of things, I think.
> 
> I have determined that adding a call to set_par at the beginning of
> fbcon_switch does fix the problem.  Of course it also ends up calling
> set_par twice during the overall switching procedure (with noticeable
> flicker), and I'm not really sure this is the right place to put it
> anyway, so I wanted to get people's opinion as to what the right fix is..

That's not the right fix.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
