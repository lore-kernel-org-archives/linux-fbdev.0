From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 12:39:36 +0200
Message-ID: <20050313103936.GA11002@sci.fi>
References: <1110677744.19810.80.camel@gaston> <20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110705646.14684.126.camel@gaston>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

On Sun, Mar 13, 2005 at 08:20:45PM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2005-03-13 at 10:22 +0200, Ville Syrj=E4l=E4 wrote:
>=20
> > >=20
> > >  - We only really need to bother about CPU access for the framebuff=
er
> > > itself (and possibly the cursor). That is normal non-accelerated fb=
dev
> > > operations an mmap'ing of the framebuffer in user space. This is no=
t
> > > really a problem if that is limited to some part of vram. It puts a
> > > small constraint on the allocation of video memory: the framebuffer=
 has
> > > to be near the beginning.
> >=20
> > It will limit DirectFB to access only CONFIG_APER_SIZE. DirectFB need=
s CPU=20
> > access to offscreen memory for software fallbacks and explicit user=20
> > access. Any other compositing window system would need to do the same=
. If=20
> > the video memory manager ever gets done then it shouldn't be a major=20
> > problem because the kernel could blit the data to/from the inaccesibl=
e=20
> > part without the application even realizing it. Although direct acces=
s=20
> > might be useful in that case also since it could reduce pressure on t=
he=20
> > GART address space.
>=20
> Yes, that means direct access will be limited to half of the vram on
> some setups and not on others, depending on how the BIOS sets up the
> card. Is this a real issue ? I don't think so personally. Especially
> since directfb could make use of DRM to do DMA blits either from main
> memory or from AGP space...

AGP as it's currently used is pretty much pointless for software fallback=
s=20
since reading from AGP memory is nearly as slow as reading from video=20
memory.

> Or things can be put in accessible space,
> and blitted elsewhere using the accelerator.

This could work (and it would avoid DRM which in my book is a plus) but=20
it's not very nice to have to copy the data twice.

> That "half" of vram is plenty enough for a framebuffer (and more). it's
> only an issue when you start doing very large offscreen surfaces. Do yo=
u
> have much usage of those without DMA ?

I have about 26MB of video memory used when running XDirectFB with GNOME,=
=20
epiphany and 4 gnome-terminals, and I also have some videos playing on th=
e=20
TV at the same time. That's on a 32MB G400 BTW.


I must be missing something something obvious because I don't quite=20
understand what major drawbacks there are with the non-overlapping mode.=20
As I see it you get at least the same amount of CPU accessible memory as=20
you get in the overlapping mode.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
