From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 09:25:59 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083108358.16544.58.camel@gaston>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIc3L-0002dp-2z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:31:51 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIc3K-00044j-Lc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:31:50 -0700
In-Reply-To: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
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
Cc: John Zielinski <grim@undead.cc>, Geert Uytterhoeven <geert@linux-m68k.org>, Alex Stewart <alex@foogod.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-04-28 at 09:21, James Simmons wrote:
> > > I can see how vgacon and fbcon would walk all over each other but how 
> > > would a serial console
> > > mess things up?
> > 
> > Same question... Where is the problem ?
> 
> Say two people are logged in. One on a serial console and another on the 
> framebuffer console. The person starts X fbdev from the serial console. 
> Ooops the fbcon user lost his console.

And ? Where is the problem ? I can do that today with ssh ... That's
normal console switch. X will trigger a console switch to a new VT,
it will not just tap on the current console "as is".

> > We need several level of arbitration, I'm not sure hwo to do that at
> > this point and I don't have time to dive into the DRI side of things.
> > 
> > Jon Smirl has been working on embedded mesa & moving DRI outside of
> > X. Unfortunately, last I heard, he was still on his trip of re-inventing
> > everything including replacing the fbdev's with his own stuff instead
> > of moving from what we have ...
> 
> Ug. This is sad :-(
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE. 
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
