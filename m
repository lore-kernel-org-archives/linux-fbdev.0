From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 10:22:16 +0200
Message-ID: <20050313082216.GA7362@sci.fi>
References: <1110677744.19810.80.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110677744.19810.80.camel@gaston>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

On Sun, Mar 13, 2005 at 12:35:43PM +1100, Benjamin Herrenschmidt wrote:
> Hi !
>=20
> I'm currently rewriting radeonfb to implement support for dual head, an=
d
> ultimately, to make it more friendly to be hooked on DRM for mesa-solo
> style setups.
>=20
> I have some issues however related to the way memory is mapped and
> dealing with apertures. Here is the story, suggestions welcome:
>=20
> The radeon card exposes to the system 2 separate apertures. That is, th=
e
> PCI region is actually cut by the hardware in two halves, each of them
> beeing an "aperture". Each aperture can have different configuration fo=
r
> the endian swappers (and possibly the surface tiling registers).
>=20
> I can configure the apertures to both map to the same bit of video
> memory (both covering the framebuffer from 0), or to be "split", that i=
s
> aperture 0 covering the framebuffer from 0 to CONFIG_APER_SIZE (size of
> an aperture, that is half of the PCI BAR allocation), and aperture 1
> covering the framebuffer from CONFIG_APER_SIZE to CONFIG_APER_SIZE*2.
>=20
> However, I can't change anything to CONFIG_APER_SIZE itself, it's
> decided by straps, either HW or in the ROM. So we end up with different
> setups depending on how the BIOS has configured things. I know that
> Apple chips are usually wired so that CONFIG_APER_SIZE is half the vide=
o
> memory, so if I use the first mode, I can only access half of the video
> RAM from PCI, if I use the second, each aperture maps a different half
> of video memory with possibly different endian swapping.
>=20
> But I think the setups in real life are more diverse and some BIOSes
> will have CONFIG_APER_SIZE at least as big as the entire video memory,
> thus forcing me to use the "overlapped" setup. In fact, CONFIG_APER_SIZ=
E
> may even be smaller than half of the vram and thus limiting the CPU to
> part of the VRAM anyway.
>=20
> I have toyed with all sort of setups, and I have +/- decided to not
> bother, and always do this, please tell me what you think:
>=20
> Always setup HOST_PATH_CNTL.HDP_APER_CNTL to 0. That is, both apertures
> are always overlapping. On Macs, or other machines that strap
> CONFIG_APER_SIZE to half of VRAM, that means only half of vram can be
> directly accessed by the CPU. I think this is fine because of these:
>=20
>  - We only really need to bother about CPU access for the framebuffer
> itself (and possibly the cursor). That is normal non-accelerated fbdev
> operations an mmap'ing of the framebuffer in user space. This is not
> really a problem if that is limited to some part of vram. It puts a
> small constraint on the allocation of video memory: the framebuffer has
> to be near the beginning.

It will limit DirectFB to access only CONFIG_APER_SIZE. DirectFB needs CP=
U=20
access to offscreen memory for software fallbacks and explicit user=20
access. Any other compositing window system would need to do the same. If=
=20
the video memory manager ever gets done then it shouldn't be a major=20
problem because the kernel could blit the data to/from the inaccesible=20
part without the application even realizing it. Although direct access=20
might be useful in that case also since it could reduce pressure on the=20
GART address space.

> But my opinion is that a mode switch will
> pretty much always invalidate everything that is cached in video memory=
,

I don't see any reason for such a sledgehammer approach. If the new mode=20
doesn't overlap with any offscreen data then there is no need to=20
invalidate anything.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
