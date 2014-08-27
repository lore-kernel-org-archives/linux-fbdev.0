From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 27 Aug 2014 06:54:41 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827065440.GG15640@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oOB74oR0WcNeq9Zb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather>
In-Reply-To: <20140826210248.GO15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
> > > > > Any decent enough SoC, with a decent support in the kernel will h=
ave
> > > > > clocks for this, and I really wonder how simplefb will behave onc=
e its
> > > > > clocks will be turned off...
> > > >=20
> > > > There are other devices besides ARM SoCs that may want to use this
> > > > driver and that don't have clock support.
> > >=20
> > > And in this case, with this patch, simplefb will not claim any clock,
> > > nor will fail probing.
> > >=20
> > > > But you're missing my point. What I'm saying is that the simplefb d=
river
> > > > is meant to serve as a way to take over whatever framebuffer a firm=
ware
> > > > set up. Therefore I think it makes the most sense to assume that no=
thing
> > > > needs to be controlled in any way since already been set up by firm=
ware.
> > > > Eventually there should be a driver that takes over from simplefb t=
hat
> > > > knows how to properly handle the device's specifics, but that's not
> > > > simplefb.
> > >=20
> > > I guess such a hand over if it were to happen in the kernel would
> > > involve the second driver claiming the resources before the first one
> > > release them. How is that different in this case?
> >=20
> > It's different in that that driver will be hardware specific and know
> > exactly what clock and other resources are required. It will have a
> > device-specific binding.
>=20
> Except that you made simplefb a generic driver. So we have two choices
> here: either we don't anything but the trivial case, and no one with a
> rather more advanced hardware will be able to use it, or we try to
> grab any resource that might be of use, which means clocks,
> regulators, reserved memory region, or whatever, so that we pretty
> much cover all cases. It really is as simple as that.

No, it should be even simpler. simplefb shouldn't have to know any of
this. It's just taking what firmware has set up and uses that. It's a
stop-gap solution to provide information on the display until a real
driver can be loaded and initializes the display hardware properly.

> > > > The goal of this patch series is to keep clocks from being turned o=
ff.
> > > > But that's not what it does. What it does is turn clocks on to prev=
ent
> > > > them from being turned off. In my opinion that's a workaround for a
> > > > deficiency in the kernel (and the firmware/kernel interface) and I =
think
> > > > it should be fixed at the root. So a much better solution would be =
to
> > > > establish a way for firmware to communicate to the kernel that a gi=
ven
> > > > resource has been enabled by firmware and shouldn't be disabled. Su=
ch a
> > > > solution can be implement for all types of resources and can be reu=
sed
> > > > by all drivers since they don't have to worry about these details.
> > >=20
> > > Mike Turquette repeatedly said that he was against such a DT property:
> > > https://lkml.org/lkml/2014/5/12/693
> >=20
> > Mike says in that email that he's opposing the addition of a property
> > for clocks that is the equivalent of regulator-always-on. That's not
> > what this is about. If at all it'd be a property to mark a clock that
> > should not be disabled by default because it's essential.
>=20
> It's just semantic. How is "a clock that should not be disabled by
> default because it's essential" not a clock that stays always on?

Because a clock that should not be disabled by default can be turned off
when appropriate. A clock that is always on can't be turned off.

> Plus, you should read the mail further. It's clearly said that
> consumer drivers should call clk_prepare_enable themselves, and that
> the only exception to that is the case where we don't have such a
> driver (and only valid as a temporary exception, which I guess you'll
> soon turn into temporary-until-a-drm-kms-driver-is-merged).

Exactly. simplefb is only a temporary measure. It's not meant to be used
as a full-blown framebuffer driver. There are two use-cases where it is
an appropriate solution:

  1) As a stop-gap solution for when the platform doesn't support a full
     display driver yet. In that case you will want simplefb to stay
     around forever.

  2) To get early boot output before a full display driver can be loaded
     in which case simplefb should go away after the display driver has
     taken over.

In case of 2) the most straightforward solution is to not disable any
clocks until all drivers have had a chance to claim them. When the full
driver has been probed it should have claimed the clocks so they would
no longer get disabled.

For 1) I think it's fair to say that it's only a temporary solution to
get something on the screen. There won't be any kind of acceleration at
all, no power saving. Nothing but a dumb framebuffer. In that case it
should be a simple matter of keeping a select number of clocks always on
in the clock driver until support is more complete and it can be
properly handled. It's not like it's going to make a difference anyway
since simplefb won't ever disable them either.

> > Adding Mike on this subthread too.
> >=20
> > Either way, Mark already suggested a different alternative in another
> > subthread, namely to add a new kind of checkpoint at which subsystems
> > can call a "disable unused" function that's called later than a late
> > initcall. This is not going to fix things for you immediately because
> > the clocks will still be switched off (only later) if you don't have
> > a real driver that's claiming the clocks.
>=20
> Great, I'm glad we found a solution for a completely unrelated issue.

It's not at all unrelated. See above.

> > But you can work around that for now by making the relevant clocks
> > always on and remove that workaround once a real driver is loaded
> > that knows how to handle them properly.
>=20
> So, let me get this straight. The clock provider driver should behave
> as a clock consumer because it knows that in some cases, it might not
> have any willingful enough consumer? Doesn't that even ring your
> this-is-a-clear-abstraction-violation-bell just a tiny bit?

No. The clock driver should simply not allow the clocks to be disabled
if it isn't safe to do so.

Thierry

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/YCwAAoJEN0jrNd/PrOhhjIP/ihXprvrbx5whMgI23CQpfv1
WCGDkaN5aDMhskRSszwRUBx1BhCDuR4OeYn8ThWobDLqFew7CL38xs5B7rcvdFtQ
gUYeJgbyEilE0J/mLtsXUGF1KZJW1t8A+c6DiZ0kRm6MXKyrfxN6zbMpcMh/9KeK
a8xse9L89gEYM6yQy2vYVP+qQIexh3yoXld4324W4ZDFz3apTq+jnwPhGhNHIniq
UZYZ2WqjtckX73W5V/bF82UxJPSNN2BYGbeXtk1+7ATKzXnKqG1ziA/TFGOQR+bF
B/+mx1GjzQKX8lNSaUOxTmNejLzYO94Z6CuwhapgyjJnfuBVhCwiGCpUH1Oiwgv0
yObsgy+G8knuqUvws6zQ/053kL6p6efnW+SJimoK8K4PSr8S6bpk6klDDiAi6o95
nyM92iR0TGyUKLaPizRxMet69En/NiXLBalxWkt3pc4QjidvbSSWLHzy/e3AnMjl
licux1HHhKPTDR0+DzfZ9wbEx66GlnDITpZBcaYI0Knn8ggX3Y/DSGFpNnV1Cd72
iEPW/syBe2HgXFl1K4h9x8yDs8ZSYqCCOVU6rHYl0xs4ASbABL4+lKfAS2ama9Fk
GoH8gRocKr81YBUJZrLZkiYVDBpo9hUcF1ZKJs88Ev4nKlk6kgjpvlDzy9Ap7e5Y
K8/TQVaX7A2OU+4GKJED
=ZDzZ
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
