From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Wed, 28 Apr 2004 09:02:47 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083106967.16473.33.camel@gaston>
References: <Pine.LNX.4.44.0404272330480.23153-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIbgq-000645-Jc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:08:36 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIbgq-0006Yz-7s
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:08:36 -0700
In-Reply-To: <Pine.LNX.4.44.0404272330480.23153-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-04-28 at 08:33, James Simmons wrote:
> > >The whole var thing is too messy right now. Especially, the lack of a
> > >per-VT var right now makes things even more difficult
> > >  
> > >
> > I'm currently in the middle of adding a per-VT var to my kernel.  
> > They'll be in addition to the fb's current var so that when a fb using 
> > program releases the frame buffer I can restore the VT's var instead of 
> > depending on the app to do it right.  I'll post some patches when I get 
> > things working properly. 
> 
> This breaks the way linux works. It is up to the program to restore the 
> console. The same case for vgacon. The X server is the one that restores 
> the graphics hardware back to the VGA text mode. This patch would not ne 
> accepted for a stable release. 

I don't agree. While it's true that we shouldn't bother saving/restoring
the var for a KD_GRAPHICS VT which is under app control, we should do it
for fbcon controlled consoles.

Right now, it just doesn't work properly and you know it. It's actually
a regression from 2.4 and I don't think his patch will be more invasive
than the rest of the changes you have been doing lately ;)

Face it, the current fbcon resize mecanism is just broken. It cannot
work properly without full mode management in all drivers. A per-VT var
along with fbcon properly adapting it's size to the VT's var would bring
us back to 2.4 level of functionality at least, which is a good thing.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
