From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 26 Aug 2014 21:02:48 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826210248.GO15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1R3djOICCIfo/gUr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
In-Reply-To: <20140826143550.GB3027@ulmo>
To: linux-arm-kernel@lists.infradead.org


--1R3djOICCIfo/gUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
> > > > Any decent enough SoC, with a decent support in the kernel will have
> > > > clocks for this, and I really wonder how simplefb will behave once =
its
> > > > clocks will be turned off...
> > >=20
> > > There are other devices besides ARM SoCs that may want to use this
> > > driver and that don't have clock support.
> >=20
> > And in this case, with this patch, simplefb will not claim any clock,
> > nor will fail probing.
> >=20
> > > But you're missing my point. What I'm saying is that the simplefb dri=
ver
> > > is meant to serve as a way to take over whatever framebuffer a firmwa=
re
> > > set up. Therefore I think it makes the most sense to assume that noth=
ing
> > > needs to be controlled in any way since already been set up by firmwa=
re.
> > > Eventually there should be a driver that takes over from simplefb that
> > > knows how to properly handle the device's specifics, but that's not
> > > simplefb.
> >=20
> > I guess such a hand over if it were to happen in the kernel would
> > involve the second driver claiming the resources before the first one
> > release them. How is that different in this case?
>=20
> It's different in that that driver will be hardware specific and know
> exactly what clock and other resources are required. It will have a
> device-specific binding.

Except that you made simplefb a generic driver. So we have two choices
here: either we don't anything but the trivial case, and no one with a
rather more advanced hardware will be able to use it, or we try to
grab any resource that might be of use, which means clocks,
regulators, reserved memory region, or whatever, so that we pretty
much cover all cases. It really is as simple as that.

> > > The goal of this patch series is to keep clocks from being turned off.
> > > But that's not what it does. What it does is turn clocks on to prevent
> > > them from being turned off. In my opinion that's a workaround for a
> > > deficiency in the kernel (and the firmware/kernel interface) and I th=
ink
> > > it should be fixed at the root. So a much better solution would be to
> > > establish a way for firmware to communicate to the kernel that a given
> > > resource has been enabled by firmware and shouldn't be disabled. Such=
 a
> > > solution can be implement for all types of resources and can be reused
> > > by all drivers since they don't have to worry about these details.
> >=20
> > Mike Turquette repeatedly said that he was against such a DT property:
> > https://lkml.org/lkml/2014/5/12/693
>=20
> Mike says in that email that he's opposing the addition of a property
> for clocks that is the equivalent of regulator-always-on. That's not
> what this is about. If at all it'd be a property to mark a clock that
> should not be disabled by default because it's essential.

It's just semantic. How is "a clock that should not be disabled by
default because it's essential" not a clock that stays always on?

Plus, you should read the mail further. It's clearly said that
consumer drivers should call clk_prepare_enable themselves, and that
the only exception to that is the case where we don't have such a
driver (and only valid as a temporary exception, which I guess you'll
soon turn into temporary-until-a-drm-kms-driver-is-merged).

> Adding Mike on this subthread too.
>=20
> Either way, Mark already suggested a different alternative in another
> subthread, namely to add a new kind of checkpoint at which subsystems
> can call a "disable unused" function that's called later than a late
> initcall. This is not going to fix things for you immediately because
> the clocks will still be switched off (only later) if you don't have
> a real driver that's claiming the clocks.

Great, I'm glad we found a solution for a completely unrelated issue.

> But you can work around that for now by making the relevant clocks
> always on and remove that workaround once a real driver is loaded
> that knows how to handle them properly.

So, let me get this straight. The clock provider driver should behave
as a clock consumer because it knows that in some cases, it might not
have any willingful enough consumer? Doesn't that even ring your
this-is-a-clear-abstraction-violation-bell just a tiny bit?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--1R3djOICCIfo/gUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/PX4AAoJEBx+YmzsjxAgx/kP/RaoiiaYGRWhqw9PyY1KlAjG
DNWhpp8/VC/0A3VcOsxh+ZkfvUCEcZFDEtQgtfglPyAU3v6vIKJKkDgflfoOfkh8
qpf0YGio5wb1qSGDFddj15jNzJNZlqjOphn3s36/2ATyKGcUSVg+ormK39czPlHd
qr09iwNjD/wMzKXzMAF8ERRaAuE1EIkTHMWJ8C2i+zSOxemRMG/cvwlU37G76CvX
KxTpvKDXuXN1lpA0bXDkjiGoMAjlb6Z0zoSi7ozsx9I9RBNSIofw0QiHMERH29de
ztzim+DgLt9ZKK7nvowAaj1S7hlR6baJzsAIyCWlc3VEBekflkj5/kPZuaGogSuL
5FzCZDm9SYJSmr15/K3OeoHduisDDpKuUvkZtxRPdivTLJJvifomGkgs5MC7f74O
I7NtkpYMIi7z1LkrTWyLcUtvLcPacEEQsqCOv/PflZ5wTCq8U5hvb5z5tG2hEYyU
2NLRErw9346Vxkc2vqLptlWLjo1jrqdW+zpoTrVFxPt1JOXhzkZXvnCKUvCya3Zq
OlzYzBZtFe3pLwG+VoCWu3onC+rq/1niBGm2EuoeiAkmmAH6vKi0A7NFi36nPnjM
4cVMAOQAkamdEf4ok7jWBnvkFsmU2aHFzTNDpo3cZIrZE4vGTx5oXLgJy++mgQWx
oOt2BbMcRurddLBjunn3
=iTRy
-----END PGP SIGNATURE-----

--1R3djOICCIfo/gUr--
