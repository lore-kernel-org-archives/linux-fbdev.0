From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: FB model basic issues (WAS: radeon,
	apertures & memory mapping)
Date: Wed, 16 Mar 2005 10:33:02 +1100
Message-ID: <1110929582.25201.34.camel__26263.5802421302$1110929893$gmane$org@gaston>
References: <1110696189.5787.100.camel@gaston>
	 <1110774523.4003.511.camel@localhost> <1110784327.5787.288.camel@gaston>
	 <1110817205.4004.527.camel@localhost> <1110837171.5863.16.camel@gaston>
	 <1110838356.4003.548.camel@localhost> <1110839873.5673.41.camel@gaston>
	 <1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	 <Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be>
	 <20050315133628.GA16051@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050315133628.GA16051@sci.fi>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>


> > I once did a similar thing for an embedded prototype: take a fixed amount of
> > memory for both frame buffers (this was a UMA system), fb0 starts from the top,
> > fb1 starts from the bottom. You can enlarge each frame buffer, until you read
> > the memory of the other. Each fix.smem_{start,len} corresponds exactly to the
> > memory allocated to each frame buffer.
> > 
> > Of course, if you also want off-screen memory (i.e. memory beyond
> > xres_virtual*yres_virtual*bpp/8), things get more complicated, since currently
> > there's no way for the application to ask for a minimum amount of off-screen
> > memory. Perhaps a new field in fb_var_screeninfo (and zero means `I don't
> > care', for backwards compatibility).
> 
> Offscreen memory is pretty much essential for DirectFB.

I still tend to think that offscreen memory is busted on mode
switches...

Now, I agree that cutting the vram in half, and reserving  both halves
to the "offscreen" needs to each head may help avoiding mode switch on
one head busting things used by whoever works on the second head, but
I'm not sure that fits the DRM needs very well..


Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
