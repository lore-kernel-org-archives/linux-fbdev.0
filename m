From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 27 Aug 2014 08:45:26 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827084526.GR15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PoN2v/rqUbt6cKLt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
In-Reply-To: <20140827065440.GG15640@ulmo>
To: linux-arm-kernel@lists.infradead.org


--PoN2v/rqUbt6cKLt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
> On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
> > > > > > Any decent enough SoC, with a decent support in the kernel will=
 have
> > > > > > clocks for this, and I really wonder how simplefb will behave o=
nce its
> > > > > > clocks will be turned off...
> > > > >=20
> > > > > There are other devices besides ARM SoCs that may want to use this
> > > > > driver and that don't have clock support.
> > > >=20
> > > > And in this case, with this patch, simplefb will not claim any cloc=
k,
> > > > nor will fail probing.
> > > >=20
> > > > > But you're missing my point. What I'm saying is that the simplefb=
 driver
> > > > > is meant to serve as a way to take over whatever framebuffer a fi=
rmware
> > > > > set up. Therefore I think it makes the most sense to assume that =
nothing
> > > > > needs to be controlled in any way since already been set up by fi=
rmware.
> > > > > Eventually there should be a driver that takes over from simplefb=
 that
> > > > > knows how to properly handle the device's specifics, but that's n=
ot
> > > > > simplefb.
> > > >=20
> > > > I guess such a hand over if it were to happen in the kernel would
> > > > involve the second driver claiming the resources before the first o=
ne
> > > > release them. How is that different in this case?
> > >=20
> > > It's different in that that driver will be hardware specific and know
> > > exactly what clock and other resources are required. It will have a
> > > device-specific binding.
> >=20
> > Except that you made simplefb a generic driver. So we have two choices
> > here: either we don't anything but the trivial case, and no one with a
> > rather more advanced hardware will be able to use it, or we try to
> > grab any resource that might be of use, which means clocks,
> > regulators, reserved memory region, or whatever, so that we pretty
> > much cover all cases. It really is as simple as that.
>=20
> No, it should be even simpler. simplefb shouldn't have to know any of
> this. It's just taking what firmware has set up and uses that. It's a
> stop-gap solution to provide information on the display until a real
> driver can be loaded and initializes the display hardware properly.

That was not the original intention of this driver then. Stephen's
commit log (commit 26549c8d36a6) was even mentionning some use cases:

"
    Examples use-cases include:

    * The built-in LCD panels on the Samsung ARM chromebook, and Tegra
      devices, and likely many other ARM or embedded systems.  These cannot
      yet be supported using a full graphics driver, since the panel control
      should be provided by the CDF (Common Display Framework), which has b=
een
      stuck in design/review for quite some time.  One could support these
      panels using custom SoC-specific code, but there is a desire to use
      common infra-structure rather than having each SoC vendor invent their
      own code, hence the desire to wait for CDF.

    * Hardware for which a full graphics driver is not yet available, and
      the path to obtain one upstream isn't yet clear.  For example, the
      Raspberry Pi.
   =20
    * Any hardware in early stages of upstreaming, before a full graphics
      driver has been tackled.  This driver can provide a graphical boot
      console (even full X support) much earlier in the upstreaming process,
      thus making new SoC or board support more generally useful earlier.
"

We're clearly in the use cases 2 and 3.

I understand that you're suggesting a 4th use-case, which seems
totally valid, but let's not forget the reasons why it has been merged
in the first place.

> > > > > The goal of this patch series is to keep clocks from being turned=
 off.
> > > > > But that's not what it does. What it does is turn clocks on to pr=
event
> > > > > them from being turned off. In my opinion that's a workaround for=
 a
> > > > > deficiency in the kernel (and the firmware/kernel interface) and =
I think
> > > > > it should be fixed at the root. So a much better solution would b=
e to
> > > > > establish a way for firmware to communicate to the kernel that a =
given
> > > > > resource has been enabled by firmware and shouldn't be disabled. =
Such a
> > > > > solution can be implement for all types of resources and can be r=
eused
> > > > > by all drivers since they don't have to worry about these details.
> > > >=20
> > > > Mike Turquette repeatedly said that he was against such a DT proper=
ty:
> > > > https://lkml.org/lkml/2014/5/12/693
> > >=20
> > > Mike says in that email that he's opposing the addition of a property
> > > for clocks that is the equivalent of regulator-always-on. That's not
> > > what this is about. If at all it'd be a property to mark a clock that
> > > should not be disabled by default because it's essential.
> >=20
> > It's just semantic. How is "a clock that should not be disabled by
> > default because it's essential" not a clock that stays always on?
>=20
> Because a clock that should not be disabled by default can be turned off
> when appropriate. A clock that is always on can't be turned off.

If a clock is essential, then it should never be disabled. Or we don't
share the same meaning of essential.

> > Plus, you should read the mail further. It's clearly said that
> > consumer drivers should call clk_prepare_enable themselves, and that
> > the only exception to that is the case where we don't have such a
> > driver (and only valid as a temporary exception, which I guess you'll
> > soon turn into temporary-until-a-drm-kms-driver-is-merged).
>=20
> Exactly. simplefb is only a temporary measure. It's not meant to be used
> as a full-blown framebuffer driver. There are two use-cases where it is
> an appropriate solution:
>=20
>   1) As a stop-gap solution for when the platform doesn't support a full
>      display driver yet. In that case you will want simplefb to stay
>      around forever.
>=20
>   2) To get early boot output before a full display driver can be loaded
>      in which case simplefb should go away after the display driver has
>      taken over.
>
> In case of 2) the most straightforward solution is to not disable any
> clocks until all drivers have had a chance to claim them. When the full
> driver has been probed it should have claimed the clocks so they would
> no longer get disabled.
>=20
> For 1) I think it's fair to say that it's only a temporary solution to
> get something on the screen. There won't be any kind of acceleration at
> all, no power saving. Nothing but a dumb framebuffer. In that case it
> should be a simple matter of keeping a select number of clocks always on
> in the clock driver until support is more complete and it can be
> properly handled. It's not like it's going to make a difference anyway
> since simplefb won't ever disable them either.

We do agree on that. The only thing we seem to disagree on is how to
keep these clocks running.

> > > Adding Mike on this subthread too.
> > >=20
> > > Either way, Mark already suggested a different alternative in another
> > > subthread, namely to add a new kind of checkpoint at which subsystems
> > > can call a "disable unused" function that's called later than a late
> > > initcall. This is not going to fix things for you immediately because
> > > the clocks will still be switched off (only later) if you don't have
> > > a real driver that's claiming the clocks.
> >=20
> > Great, I'm glad we found a solution for a completely unrelated issue.
>=20
> It's not at all unrelated. See above.

Kind of, these patches were about the first use case you mentionned,
and your solution tackles the second one.

> > > But you can work around that for now by making the relevant clocks
> > > always on and remove that workaround once a real driver is loaded
> > > that knows how to handle them properly.
> >=20
> > So, let me get this straight. The clock provider driver should behave
> > as a clock consumer because it knows that in some cases, it might not
> > have any willingful enough consumer? Doesn't that even ring your
> > this-is-a-clear-abstraction-violation-bell just a tiny bit?
>=20
> No. The clock driver should simply not allow the clocks to be disabled
> if it isn't safe to do so.

Again, we do seem to differ on our interpretation of an essential
clock. To me, it is perfectly safe to disable the clocks. The system
will still be responding, the memory will be there, the CPU will keep
running, and we do have a way to recover from that disabled to clock
(for example to enable it back).

Plus, again, in Mike's mail, it's clearly said that adding hacks like
this to the clock driver should only be considered in the case where
we don't have a consuming driver, which is not our case here.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--PoN2v/rqUbt6cKLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/ZqmAAoJEBx+YmzsjxAgT64P/RrZZjXzo7Pu10E6OJq9g7xI
1dXqDUdMTt4P9WJqQBh4Z8wK/8mRqT9F0pqUQlmJQEJoWdWxfPs4HcFUMd9NkxM9
GXjc7LEqhrGRvHX/p1evUcWhm07C+Wj/A4sbYZJU1yFUnRmbGcVRpGQZGrhI4hvP
Bcqc0c/OXSdC9g5+uhXbHRk4pVN1/oPKnHpc4GX6b0h29TBGY1ChgBlEWpKi966D
yGgkSZfeCTJR8t30BBDZWsFyf/TCwtsriFT6c6XJaP7yfAdGsaRN7y1tpdFqVyKR
lmTlo7kmwz3XAWTLtqQDsJUqrmFzE3FRBQJjNJUhRpIRJyHVueiS7WXKcdOG4tUt
rVicjFzeAXFTIKtOFKhy/pac6doYJxLsytIPNlXzL7fL++iluJrUO6MGK8mlgHEN
ivOp2oGakkSzrV8F/hct34W3/iiP9+tjZ9xT+HrkK81d1E2Q6Lc+a1Ef03GywjLd
sm+mHBkkmpAHTi4OjD2EcUh9xe1aPbagg3O11ldzgGZlm2JKHicNo1yfHvmzolHu
QhTsT6QkFz1dIGJGQuhTu9GHSnLiuUeoHV0gVot9ymiuldfh9mznklfulBk4NRd1
JAP+C7K2bpjMeU/2sOLkYmN5DOL0Jl2Z05hOy5LjwtvVW6HBwthRX57AK2uArt7+
AYttZwnYZW/RkqSQIePl
=HtPC
-----END PGP SIGNATURE-----

--PoN2v/rqUbt6cKLt--
