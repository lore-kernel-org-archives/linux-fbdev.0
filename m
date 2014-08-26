From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 26 Aug 2014 10:55:06 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826105451.GD31124@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Oiv9uiLrevHtW1RS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
In-Reply-To: <20140826100612.GH17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 11:06:12AM +0100, Mark Brown wrote:
> On Tue, Aug 26, 2014 at 11:18:54AM +0200, Thierry Reding wrote:
> > On Tue, Aug 26, 2014 at 10:00:35AM +0100, Mark Brown wrote:
>=20
> > > > I find that rather odd since I always assumed that a regulator mark=
ed
> > > > boot-on would not be touched by the core at all, assuming that firm=
ware
> > > > set it up properly and that it would be required (even if not expli=
citly
> > > > claimed).
>=20
> > > No, there's a separate always-on property if we don't want to disable.
>=20
> > But always-on means that it can't ever be disabled. In this case what
> > we'd need is a "don't disable automatically because it's needed, but we
> > may want to switch it off at a later point to save power."
>=20
> Such a property wouldn't make much sense, it should also apply to the
> driver at which point it's just the same as always-on.
>=20
> > > We can't assume that the "proper" setup is that the supply should be
> > > left on.
>=20
> > Right, we can't assume it, but if we're given appropriate hints I think
> > it's fair to keep resources set up by firmware untouched.
>=20
> I really can't see any sensible way to do that in an OS neutral thing
> like DT.

It should be possible to simply define a property for this that the
firmware can add to the device tree.

There are other subsystems for example where we don't touch resources
unless they are explicitly accessed. GPIO and pinmux are two examples of
those. The reason is precisely so that we don't undo anything that the
firmware already set up and that may be needed during boot.

> > > > have run and generic low-level drivers that take over firmware devi=
ces
> > > > (simplefb in this case) that don't know anything about the resource=
 that
> > > > the devices need.
>=20
> > > I don't understand this use case, sorry - it sounds like a buggy syst=
em
> > > design and/or integration.  If the firmware is managing the resource
> > > then Linux really shouldn't be talking to it at all without coordinat=
ing
> > > with firmware.  How can such a system work otherwise?
>=20
> > The firmware isn't really managing resources. It's setting up state that
> > the kernel shouldn't be modifying. Currently the kernel assumes that no
> > firmware exists and just disables everything that's not being used. That
> > is a reasonable default, but it also limits what we can do. I think if
> > we provided a good interface to communicate state between firmware and
> > kernel then we could easily do this kind of hand-off.
>=20
> I'm afraid that's confusing me even further.  If the "firmware devices"
> don't know anything about the resources as you say then presumably they
> need to be always on since they obviously won't be able to control them
> and there is going to be no handoff?

How this works with simplefb is that the firmware (U-Boot for example)
sets up everything needed to scan out a framebuffer. The firmware will
typically use this for a boot splash or a console. It's akin to the
standard VGA console on x86.

Before booting the kernel it will modify the DTB and insert a node that
contains information about the framebuffer that was set up. The node
contains properties that define the resolution, the format and the
physical address of the framebuffer memory. An in-kernel driver will
then be able to use that information very early in the boot process to
show the console (to replace the serial console that's usually not
available on consumer devices). Later on when a real driver can be
loaded it should take over the resources from simplefb and remove it.

So the firmware does control the resources to a point where the display
hardware is initialized and then it will happily forget about them. The
device will keep scanning out the framebuffer and simplefb can update it
with boot messages. To prevent the console from suddenly disappearing
the kernel needs to make sure that the resources aren't inadvertently
turned off at some more or less random point in time.

The resources don't need to be always on, only as long as there isn't a
proper driver to manage them. Once that driver has requested the
resources it will likely want to control them to save power. Therefore I
think the most straightforward way would be for the kernel not to touch
any of these resources until they've been explicitly requested. Even if
we don't want to rely on firmware doing the right thing by default, I
think it's still valuable to take hints from firmware when it provides
them so rather than defaulting to not touching any resources what I
proposed is to mark resources that shouldn't be touched.

Thierry

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/GeCAAoJEN0jrNd/PrOhIN8P/2ctvHoP+OZkHKP3S8DMvs8A
EdYLgbFk7uD+7TYDDAiDRCbrcJIahdD4efG8lCgAbAkqh35To/JIgj63Jx7lVYOI
g9hpmUtKPRsGh+HJRh6RWuRd9GnHrQQDcJylF2keMmPG0N5p/a0v8UQtyfCmJqYd
qgGZjIGMSF8f1ex3Al/9laiIlFsmWRQPMZy47eQ5HkBYMmK0kay09SYj2XdER0tz
J6aVPqG43aTaWYYDDKg1bcWrQk49rC1/vSPmIOmvTtSvVnPnXy+RfQEx8wc4NXxK
k+gGTIx9lpdI9ptm1iSm5urgsnsCA7OK4UzYgto2goZiSrpLFk/FoWRGKjUPgqSN
nuxPkzzPvkdYfur+3Ii8fUBIBPlPXrRw9HtTyct8GgGxRXCqjDrRSy3TubFF76kC
Wqh2ZhnDprL5uxCR5RH6/cr6501WqatGRb4uabgosWDnuxtIroP06UjcePYhsXX7
xlXBZe2IbVMIZ4r2bL1/9+9PY7fIIf1AWkhiKmBULi2VPGUnHm+PoGOjYBXGh7+f
qJ97iy0TNUbDpvBNxVYoWNpJswquCDboeHNLfE6dpTD9qmc8gNUyLwLyZ/oyliPC
ziFBBfWcWrcJEHIaXWPKpkTZ6UCUhe2TQ5mEk4qaBRTOTYEzSUNUqsFHsbM6FyVu
mSqN6PmxJ5aqfTw5Cwo0
=Iohy
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
