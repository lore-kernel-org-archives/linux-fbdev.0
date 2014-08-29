From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 29 Aug 2014 06:19:12 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140829061910.GA13106@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <20140827084526.GR15297@lukather> <20140827095241.GC23186@ulmo>
 <20140827154221.GX15297@lukather>
 <CAOMqctSY7AJKHthe+aG8--Ok6JiY1g2zM_tN10S2nELOSe=qMw@mail.gmail.com>
 <20140828100834.GA14388@ulmo>
 <CAOMqctSwhQHJynn=tW==uuznJW+0CrivNP=os+xem1MAuDP7ZQ@mail.gmail.com>
In-Reply-To: <CAOMqctSwhQHJynn=tW==uuznJW+0CrivNP=os+xem1MAuDP7ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 07:13:22AM +0200, Michal Suchanek wrote:
> On 28 August 2014 12:08, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Wed, Aug 27, 2014 at 10:57:29PM +0200, Michal Suchanek wrote:
> >> Hello,
> >>
> >> On 27 August 2014 17:42, Maxime Ripard <maxime.ripard@free-electrons.c=
om> wrote:
> >> > On Wed, Aug 27, 2014 at 11:52:48AM +0200, Thierry Reding wrote:
> >> >> On Wed, Aug 27, 2014 at 10:45:26AM +0200, Maxime Ripard wrote:
> >> >> > On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
> >> >> > > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> >> >> > > > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrot=
e:
> >> >> [...]
> >> >> > > > > > Mike Turquette repeatedly said that he was against such a=
 DT property:
> >> >> > > > > > https://lkml.org/lkml/2014/5/12/693
> >> >> > > > >
> >> >> > > > > Mike says in that email that he's opposing the addition of =
a property
> >> >> > > > > for clocks that is the equivalent of regulator-always-on. T=
hat's not
> >> >> > > > > what this is about. If at all it'd be a property to mark a =
clock that
> >> >> > > > > should not be disabled by default because it's essential.
> >> >> > > >
> >> >> > > > It's just semantic. How is "a clock that should not be disabl=
ed by
> >> >> > > > default because it's essential" not a clock that stays always=
 on?
> >> >> > >
> >> >> > > Because a clock that should not be disabled by default can be t=
urned off
> >> >> > > when appropriate. A clock that is always on can't be turned off.
> >> >> >
> >> >> > If a clock is essential, then it should never be disabled. Or we =
don't
> >> >> > share the same meaning of essential.
> >> >>
> >> >> Essential for the particular use-case.
> >> >
> >> > So, how would the clock driver would know about which use case we're
> >> > in? How would it know about which display engine is currently runnin=
g?
> >> > How would it know about which video output is being set?
> >> >
> >> > Currently, we have two separate display engines, which can each outp=
ut
> >> > either to 4 different outputs (HDMI, RGB/LVDS, 2 DSI). Each and every
> >> > one of these combinations would require different clocks. What clocks
> >> > will we put in the driver? All of them?
> >> >
> >>
> >> since simplefb cannot be extended how about adding, say, dtfb which
> >> claims the resources from dt and then instantiates a simplefb once the
> >> resources are claimed? That is have a dtfb which has the clocks
> >> assigned and has simplefb as child dt node.
> >
> > I don't see how that changes anything. All you do is add another layer
> > of indirection. The fundamental problem remains the same and isn't
> > solved.
>=20
> It keeps clock code out of simplefb and provides driver for the kind
> of framebuffer set up by firmware that exists on sunxi, exynos, and
> probably many other SoCs. That is a framebuffer that needs some clocks
> and possibly regulators enabled to keep running because the reality of
> the platform is that it has clocks and regulators unlike some other
> platforms that do not.
>=20
> These clocks and regulators are used but not configured by the
> framebuffer and should be reclaimed when firmware framebuffer is
> disabled. This is the same as the chunk of  memory used by simplefb
> which is currently lost but should be reclaimed when simplefb is
> disabled.
>=20
> This memory is not 'reserved for firmware' and unusable but reserved
> for framebuffer and the regulators are not 'always on' or 'should
> never be disabled' but should be enabled while framebuffer is used.
>=20
> As far as I can tell in DT this is expressed by creating a DT node
> associated with the framebuffer driver that tells the kernel that this
> memory, clocks and regulators are associated with the framebuffer
> driver and can be reclaimed if this driver is stopped or not enabled
> in the kernel at all. If you are going to be asinine about simplefb
> not getting support for managing any resource other than the memory
> chunk then another layer of indirection is required for platforms that
> have more resources to manage.
>=20
> If there is another way to associate resources with a driver in DT
> then please enlighten me.
>=20
> AFAICT simplefb is the framebuffer driver already in kernel closest to
> the driver that is required for sunxi - simplefb also relies on
> firmware to set up the framebuffer but unlike vesafb or efifb it
> already has DT integration. So the most efficient way to implement
> framebuffer for sunxi is to extend simplefb or if necessary add
> another layer of indirection under simplefb. If there is a better
> fitting driver in the kernel then please enlighten me and the
> developer that wrote this patch what driver it would be.

I think simplefb is exactly the right driver to use for this case. But I
don't think making it manage all the resources is the right thing to do.
While it's fairly easy to do it, it's also something that needs to be
done for every other driver with similar requirements. Consider for
example what happens if you want to play some welcome sound in the
bootloader and keep it playing while the kernel is booting. You'd need
to repeat exactly what this driver does to keep clocks for audio
hardware running. And there are possibly other similar use-cases as
well.

One other issue with simplefb is that it isn't a real device to begin
with. It's completely virtual, so in the same way that it doesn't
program any device-specific registers I don't think it should claim any
resources.

Thierry

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUABteAAoJEN0jrNd/PrOhfM4P/RZMC1rtKyzL+KnUxeDGi42G
k18/XiU426fZmwIsimwiM+pzKbwnUwCBv8yj5VK2bkWVVCp8rECSqXTTy8/79y1V
MzasTvzWLXsdlKAtXszY6UVrsV/tq2Ae5MaIVv/RF9XzrMCLjxtMah2QguqNPbc0
nDf+hJiHmzgonZ27xK3KEY2A3/hDexqjHojqOrThgmXQ2ZZeXKimqMFqCLDOq0Hh
11cZJReMD98/70axsMRBZgK2cD5h5TyJnXU4ALND+bYInHWluClRWu35zTDHnmC6
t0fK1Q9zXCEDJAbSuzniqtJ46OubrCeexsfbXynHihda+scs3089EM7x4C/kwOVr
u4G/lXWlYIQ6y8GnNYm72ZUlTStQBm2vbgSXgUUV0/GVcLrgwxlPCLWZyiwP0qA8
0VfBbjSe998N3H3lsm7/vvs35C3/kzZ15rpH3EYc2gBxk9IX6QIUiLX2O6kn0V0K
sloJgcE97gGDTJokymwJVvf9QwhM6g+VYnyaZ82ScckQ2iaETTtUuiS/fKylrxzq
9CkqGtL5/PAiqpXAf18eEaW3XtMqkBJybO1gE21na473vdzDhYBVXv2c47h/6iS+
KV5ZMWUnhiW7s0JkpjiUI+0XoI/fUkebcQbi49X591SMIIvKgGE2NOyJ3zGf4wh9
HwU9dWOLKEEQFIy+mteL
=FsN3
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
