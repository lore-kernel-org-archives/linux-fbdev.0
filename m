From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 29 Aug 2014 07:08:43 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140829070842.GD13106@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GyRA7555PLgSTuth"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <20140827084526.GR15297@lukather> <20140827095241.GC23186@ulmo>
 <20140827154221.GX15297@lukather>
 <CAOMqctSY7AJKHthe+aG8--Ok6JiY1g2zM_tN10S2nELOSe=qMw@mail.gmail.com>
 <20140828100834.GA14388@ulmo>
 <CAOMqctSwhQHJynn=tW==uuznJW+0CrivNP=os+xem1MAuDP7ZQ@mail.gmail.com>
 <20140829061910.GA13106@ulmo>
 <CAOMqctTUZA-Fx1pOaqxvC9W0G5BGNFYq-gh1019pqXZ1mNynJA@mail.gmail.com>
In-Reply-To: <CAOMqctTUZA-Fx1pOaqxvC9W0G5BGNFYq-gh1019pqXZ1mNynJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 08:48:42AM +0200, Michal Suchanek wrote:
> On 29 August 2014 08:19, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Fri, Aug 29, 2014 at 07:13:22AM +0200, Michal Suchanek wrote:
> >> On 28 August 2014 12:08, Thierry Reding <thierry.reding@gmail.com> wro=
te:
> >> > On Wed, Aug 27, 2014 at 10:57:29PM +0200, Michal Suchanek wrote:
> >> >> Hello,
> >> >>
> >> >> On 27 August 2014 17:42, Maxime Ripard <maxime.ripard@free-electron=
s.com> wrote:
> >> >> > On Wed, Aug 27, 2014 at 11:52:48AM +0200, Thierry Reding wrote:
> >> >> >> On Wed, Aug 27, 2014 at 10:45:26AM +0200, Maxime Ripard wrote:
> >> >> >> > On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
> >> >> >> > > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrot=
e:
> >> >> >> > > > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding w=
rote:
> >> >> >> [...]
> >> >> >> > > > > > Mike Turquette repeatedly said that he was against suc=
h a DT property:
> >> >> >> > > > > > https://lkml.org/lkml/2014/5/12/693
> >> >> >> > > > >
> >> >> >> > > > > Mike says in that email that he's opposing the addition =
of a property
> >> >> >> > > > > for clocks that is the equivalent of regulator-always-on=
=2E That's not
> >> >> >> > > > > what this is about. If at all it'd be a property to mark=
 a clock that
> >> >> >> > > > > should not be disabled by default because it's essential.
> >> >> >> > > >
> >> >> >> > > > It's just semantic. How is "a clock that should not be dis=
abled by
> >> >> >> > > > default because it's essential" not a clock that stays alw=
ays on?
> >> >> >> > >
> >> >> >> > > Because a clock that should not be disabled by default can b=
e turned off
> >> >> >> > > when appropriate. A clock that is always on can't be turned =
off.
> >> >> >> >
> >> >> >> > If a clock is essential, then it should never be disabled. Or =
we don't
> >> >> >> > share the same meaning of essential.
> >> >> >>
> >> >> >> Essential for the particular use-case.
> >> >> >
> >> >> > So, how would the clock driver would know about which use case we=
're
> >> >> > in? How would it know about which display engine is currently run=
ning?
> >> >> > How would it know about which video output is being set?
> >> >> >
> >> >> > Currently, we have two separate display engines, which can each o=
utput
> >> >> > either to 4 different outputs (HDMI, RGB/LVDS, 2 DSI). Each and e=
very
> >> >> > one of these combinations would require different clocks. What cl=
ocks
> >> >> > will we put in the driver? All of them?
> >> >> >
> >> >>
> >> >> since simplefb cannot be extended how about adding, say, dtfb which
> >> >> claims the resources from dt and then instantiates a simplefb once =
the
> >> >> resources are claimed? That is have a dtfb which has the clocks
> >> >> assigned and has simplefb as child dt node.
> >> >
> >> > I don't see how that changes anything. All you do is add another lay=
er
> >> > of indirection. The fundamental problem remains the same and isn't
> >> > solved.
> >>
> >> It keeps clock code out of simplefb and provides driver for the kind
> >> of framebuffer set up by firmware that exists on sunxi, exynos, and
> >> probably many other SoCs. That is a framebuffer that needs some clocks
> >> and possibly regulators enabled to keep running because the reality of
> >> the platform is that it has clocks and regulators unlike some other
> >> platforms that do not.
> >>
> >> These clocks and regulators are used but not configured by the
> >> framebuffer and should be reclaimed when firmware framebuffer is
> >> disabled. This is the same as the chunk of  memory used by simplefb
> >> which is currently lost but should be reclaimed when simplefb is
> >> disabled.
> >>
> >> This memory is not 'reserved for firmware' and unusable but reserved
> >> for framebuffer and the regulators are not 'always on' or 'should
> >> never be disabled' but should be enabled while framebuffer is used.
> >>
> >> As far as I can tell in DT this is expressed by creating a DT node
> >> associated with the framebuffer driver that tells the kernel that this
> >> memory, clocks and regulators are associated with the framebuffer
> >> driver and can be reclaimed if this driver is stopped or not enabled
> >> in the kernel at all. If you are going to be asinine about simplefb
> >> not getting support for managing any resource other than the memory
> >> chunk then another layer of indirection is required for platforms that
> >> have more resources to manage.
> >>
> >> If there is another way to associate resources with a driver in DT
> >> then please enlighten me.
> >>
> >> AFAICT simplefb is the framebuffer driver already in kernel closest to
> >> the driver that is required for sunxi - simplefb also relies on
> >> firmware to set up the framebuffer but unlike vesafb or efifb it
> >> already has DT integration. So the most efficient way to implement
> >> framebuffer for sunxi is to extend simplefb or if necessary add
> >> another layer of indirection under simplefb. If there is a better
> >> fitting driver in the kernel then please enlighten me and the
> >> developer that wrote this patch what driver it would be.
> >
> > I think simplefb is exactly the right driver to use for this case. But I
> > don't think making it manage all the resources is the right thing to do.
>=20
> And what is supposed to manage resources used by simplefb when not simple=
fb?

Nothing should be managing them. There's no need to manage them at all.
The issue that this patch works around is that the clock framework is
trying to be smart and turning all unused clocks off and making
incomplete assumptions about what "all unused clocks" means.

> > While it's fairly easy to do it, it's also something that needs to be
> > done for every other driver with similar requirements.
>=20
> Other drivers that require clocks do manage them, yes. And some
> drivers that did not do that in the past were extended for that.

Not generic drivers. Not drivers that take over something that firmware
has set up.

> > Consider for
> > example what happens if you want to play some welcome sound in the
> > bootloader and keep it playing while the kernel is booting. You'd need
> > to repeat exactly what this driver does to keep clocks for audio
> > hardware running. And there are possibly other similar use-cases as
> > well.
>=20
> Why would you want to do that? If the kernel boots fast the welcome
> sound can be played from userspace when all drivers all in place.

In that case you don't need simplefb either. Just use a real driver.

> If it boots slow you can just play the sound and let the kernel boot.

And have audio interrupted by the kernel booting and disabling the
clocks?

> > One other issue with simplefb is that it isn't a real device to begin
> > with. It's completely virtual, so in the same way that it doesn't
> > program any device-specific registers I don't think it should claim any
> > resources.
>=20
> OK, so the framebuffer memory that simplefb uses for scanout should
> not be claimed by it ever, either?

No. simplefb needs to manage the framebuffer memory because it needs
explicit access to it. The contents of that memory need to be modified.
The frequency of the clocks don't need to be modified. They don't need
to be enabled or disabled either.

Thierry

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUACb6AAoJEN0jrNd/PrOhD5oP/39NVZgl92KuEc8JpBZTvAt2
+kqbpdThKYBIm4r1YyFIkcXDYA0u87KYYhp3HLJ0HPq2jfbHnZjQqLEPoSXR9MPF
o1OH/KbJtGh71CN7qilzrxEqWBvjO0NxOm8MXqjqOEeUSF27slsIQNqMMuRkH/LH
CwUn9zcvSsJtvGBVUaz/txzYnTQcSptbeZ8CdH4TE67N6ukzRL82NKVcutP6Oef2
MX6lO3l2hvCVJcTiUbZzIJPdRqHjAAIH4Byur5VBlbDfN1zYOGqJaNJ0yaPAfKj4
BauAqu/OVN7dW+4mwWY90VBSmjk3UyDRSMwP4I4N+kB13ACgNWiDCfbJBe0Do1jS
2vFMx7rt9GhIrnyutIi1taE0DGSQ6ik9jDUfyKGgks8uLtriWI0U2CMi3GJz0ZEu
QeyDC3VPbsq1xw25PYvLR+bhWl+i9gKZsQe7EclyVJscVF8US4CEBBRQ1vRlnmRQ
pYvRQeGvsRD5ePAk5sjyPqnRdXt/jH2WdmmaSYygpFkVLrrKd7grc8885KZ3swoU
HDSC5UnNbkpdcoGjfMhRglEqwmSdE8HW+mEahzR3QTtK2HMedG4N9doShG/GX5vk
EV8lFAk+Fe//11yWkdnWh+XRD7WvGWpZuJk3MQ1iWLtAMn91txZ2rL9wjUW132np
aG2zxlw6M6dYwKhRSurT
=LGhm
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
