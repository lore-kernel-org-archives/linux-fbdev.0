From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sun, 13 Mar 2005 12:37:56 +1100
Message-ID: <1110677876.19810.83.camel@gaston>
References: <20050313012923.60373.qmail@web14926.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAI3v-00082T-GQ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 17:38:35 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DAI3u-0004iF-Vb
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 17:38:35 -0800
In-Reply-To: <20050313012923.60373.qmail@web14926.mail.yahoo.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2005-03-12 at 17:29 -0800, Jon Smirl wrote:
> --- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > When we get merged my thought was to let fbdev catch the vsync IRQ
> > and
> > > then chain into DRM. In that model fbdev becomes the mini-driver.
> > > Right now I don't think there is any other solution than merging
> > > fbdev/DRM that doesn't result in some kind of dead on VT switch
> > > scenario.
> > 
> > A VT switch should stop all asynchronous activity (interrupt, DRM,
> > etc...). X already stops the DRM on switch-out, this could be
> > enforced
> > by the kernel.
> 
> The stopping interrupts on VT switch doesn't really work in a multiuser
> system. That's what burnt me with radeonfb and X. My radeonfb was
> essentially running a different user. X caught a VT switch from the
> first user and stomped on the second.
> 
> fbdev doesn't know about VT switch and shouldn't. It's fbcon that knows
> about it.

Currently, we still need a few hacks to make things work, including that
sort of thing. In fact, the problem at this point is that once the VT
subsystem has lost ownership of the console (because X switch it to
KD_GRAPHICS), we should assume that all video cards, including the ones
not used by fbcon or whatever, have lost ownership.

That sucks, but we don't have a choice until we have proper arbitration.

> Why don't we just make X/DRM/fbdev all play nice with each other, then
> nothing has to be stopped on VT switch.

We do and are working toward that goal, remember ? 

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
