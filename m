From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Tue, 15 Mar 2005 08:51:52 +1100
Message-ID: <1110837112.5673.14.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<20050314161630.GA21086@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050314161630.GA21086@sci.fi>
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


> 
> Ok so the problem is byte swapping. Looking at atyfb for example it uses 
> the "big-endian" aperture on big-endian systems and selects the byte 
> swapping method according to the bit depth. If that really means that all 
> host access to the aperture gets byte swapped then I don't see how the 
> current situation can work correctly for DirectFB. Offscreen surfaces can 
> use any bit depth and so their bytes could be swapped incorrectly. Makes 
> me wish I had a PPC box alongside the x86 one.

Possibly yes. In X, when blitting to an overlay surface, we
save/clear/restore the swapper indeed.

I would really like to keep the swappers independant though. Take things
like MOL (MacOnLinux). I maps the framebuffer and passes it to MacOS,
which expects proper swapping and doesn't (for a basic non-accelerated
framebuffer, which is what MOL implements) provide an easy way to
set/restore the swapper.

Also, doing so would require arbitration between clients using both
heads, while 2 independant swappers mean that even if the client wants
to temporarily disable it (for uploading an offscreen surface for
example), it has it's own swapper and won't conflict with whoever is
using the other framebuffer.

That means some knowledge about those swappers of course.

Note that almost all fbdev's on big endian platforms have some kind of
swapping mecanism on accesses, so that's something you'll have to deal
with anyway.

Ben.
