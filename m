From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 23:04:59 +1100
Message-ID: <1110715499.14684.132.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050313103936.GA11002@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org


> AGP as it's currently used is pretty much pointless for software fallbacks 
> since reading from AGP memory is nearly as slow as reading from video 
> memory.

Hrm.. I wouldn't expect _that_ slow. It's uncacheable, right, but still
on a faster bus. Especially if we use it the way we do on ppc where we
actually map the RAM pages directly instead of having processes go
through the GART.

> > Or things can be put in accessible space,
> > and blitted elsewhere using the accelerator.
> 
> This could work (and it would avoid DRM which in my book is a plus) but 
> it's not very nice to have to copy the data twice.
> 
> > That "half" of vram is plenty enough for a framebuffer (and more). it's
> > only an issue when you start doing very large offscreen surfaces. Do you
> > have much usage of those without DMA ?
> 
> I have about 26MB of video memory used when running XDirectFB with GNOME, 
> epiphany and 4 gnome-terminals, and I also have some videos playing on the 
> TV at the same time. That's on a 32MB G400 BTW.
> 
> I must be missing something something obvious because I don't quite 
> understand what major drawbacks there are with the non-overlapping mode. 
> As I see it you get at least the same amount of CPU accessible memory as 
> you get in the overlapping mode.

Yes, you do, but that means that if the apertures are configured such
that the entire VRAM fits in a single aperture, then you just can't use
the second aperture at all. Which means you can't have separate swapper
setting for both apertures, and thus, can't let two independant
processes access the video memory with different bit depth, at least on
big endian machines unless you do trickery, and play with the swapper
before each access.

Ben.
