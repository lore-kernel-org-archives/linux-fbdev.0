From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 20:20:45 +1100
Message-ID: <1110705646.14684.126.camel@gaston>
References: <1110677744.19810.80.camel@gaston> <20050313082216.GA7362@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050313082216.GA7362@sci.fi>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Sun, 2005-03-13 at 10:22 +0200, Ville Syrj=E4l=E4 wrote:

> >=20
> >  - We only really need to bother about CPU access for the framebuffer
> > itself (and possibly the cursor). That is normal non-accelerated fbde=
v
> > operations an mmap'ing of the framebuffer in user space. This is not
> > really a problem if that is limited to some part of vram. It puts a
> > small constraint on the allocation of video memory: the framebuffer h=
as
> > to be near the beginning.
>=20
> It will limit DirectFB to access only CONFIG_APER_SIZE. DirectFB needs =
CPU=20
> access to offscreen memory for software fallbacks and explicit user=20
> access. Any other compositing window system would need to do the same. =
If=20
> the video memory manager ever gets done then it shouldn't be a major=20
> problem because the kernel could blit the data to/from the inaccesible=20
> part without the application even realizing it. Although direct access=20
> might be useful in that case also since it could reduce pressure on the=
=20
> GART address space.

Yes, that means direct access will be limited to half of the vram on
some setups and not on others, depending on how the BIOS sets up the
card. Is this a real issue ? I don't think so personally. Especially
since directfb could make use of DRM to do DMA blits either from main
memory or from AGP space... Or things can be put in accessible space,
and blitted elsewhere using the accelerator.

That "half" of vram is plenty enough for a framebuffer (and more). it's
only an issue when you start doing very large offscreen surfaces. Do you
have much usage of those without DMA ?
=20
> > But my opinion is that a mode switch will
> > pretty much always invalidate everything that is cached in video memo=
ry,
>=20
> I don't see any reason for such a sledgehammer approach. If the new mod=
e=20
> doesn't overlap with any offscreen data then there is no need to=20
> invalidate anything.

Depends how smart the memory manager is.

Ben.
