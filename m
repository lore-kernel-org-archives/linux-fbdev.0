From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Wed, 28 Apr 2004 09:14:03 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083107642.16476.46.camel@gaston>
References: <Pine.LNX.4.44.0404272330480.23153-100000@phoenix.infradead.org>
	 <408EE5EB.6080705@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIbrj-0008Mv-Fq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:19:51 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIbrj-0001vj-2k
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:19:51 -0700
In-Reply-To: <408EE5EB.6080705@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: James Simmons <jsimmons@infradead.org>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> So if a fb program restores the mode properly then we should do nothing 
> but if it doesn't either because of a bad programming or an unexpected 
> termination then we should reset the mode to what the user has selected 
> for their console.

Which is why I've been adding calls from the VT subsystem to the console
when a program enter/leaves KD_GRAPHICS (via the blank() callback to which
I added a parameter) so fbcon can reprogram the mode & the engine. That
fixed various problems with XFree not cleaning things properly.

The proper policy here is simple. Whoever gets control of a console is
responsible for setting it up the way he needs. When leaving, it is not
requires to restore the mode it got on entry, but it should try at least
to leave the card in a sane state (accel engine not running). Though we
should probably add more security there to the fbdev's so they actually
make sure of that since it's always possible to kill a userland program
without letting it cleanup.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
