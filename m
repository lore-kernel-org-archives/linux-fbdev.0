From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 28 Apr 2004 18:54:51 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404281851060.1187-100000@phoenix.infradead.org>
References: <53204.64.139.3.221.1083127431.squirrel@www.foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BItGs-00035e-BI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:54:58 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BItGr-0000AA-MY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:54:58 -0700
In-Reply-To: <53204.64.139.3.221.1083127431.squirrel@www.foogod.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Stewart <alex@foogod.com>
Cc: benh@kernel.crashing.org, grim@undead.cc, eger-dated-1083663529.7e8c27@theboonies.us, geert@linux-m68k.org, adaplas@hotpop.com, eger-dated-1082943669.d79d33@theboonies.us, linux-fbdev-devel@lists.sourceforge.net


> >> > 1) Color depth.
> >> > 2) Frequency.
> >> > 3) Over scan color.
> >>
> >> No, no, no ... We don't need those, we need a var structure, that's
> >> all.
> 
> I agree, a var structure is how video modes are represented, and should be
> the way they're always represented.  Anything else will either be
> inadequate or horribly duplicative.  I also think that storing pixel
> resolutions and depths (let alone frequencies, etc) in a layer that
> shouldn't even know what a framebuffer is generally a poor way to do
> things.

The tty layer alreasy stores the resolution. See asm/termios.h. What it 
lacks is depth and frequency. I have to do some digging to see if the 
VT220 dealt with that data. I bet it did.

> Heh, well, I hope I'm not stirring things up too much here if I say I
> think both of those paths are wrong :)

I have to look over what you said in detail. I have to get to coding a fix 
for the fbcon resize issue.





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
