From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 27 Aug 2014 12:56:14 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827125613.GF23186@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gdTfX7fkYsEEjebm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com>
In-Reply-To: <53FDB46C.5010609@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 12:35:24PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 08/27/2014 11:31 AM, Thierry Reding wrote:
> > Can you please fix you mail setup. You're addressing me directly in this
> > email, yet I'm neither in To: nor Cc: headers. That's really annoying.
>=20
> Sorry, I'll pay closer attention that you're in the To when I'm directly
> addressing you next time.
>=20
> > On Tue, Aug 26, 2014 at 09:59:00PM +0200, Hans de Goede wrote:
>=20
> <snip>
>=20
> >>> Either way, Mark already suggested a different alternative in another
> >>> subthread, namely to add a new kind of checkpoint at which subsystems
> >>> can call a "disable unused" function that's called later than a late
> >>> initcall. This is not going to fix things for you immediately because
> >>> the clocks will still be switched off (only later) if you don't have
> >>> a real driver that's claiming the clocks. But you can work around that
> >>> for now by making the relevant clocks always on and remove that
> >>> workaround once a real driver is loaded that knows how to handle them
> >>> properly.
> >>
> >> This will simply not work, and is a ton more complicated then
> >> simply teaching simplefb about a clocks property, which is a really si=
mple
> >> and clean patch.
> >>
> >> First of all let me explain why this won't work. When should those
> >> subsystems call this "later then a late initcall" call ? the kms driver
> >> may very well be a kernel module, which will be loaded by userspace,
> >> so we would need this to be triggered by userspace, but when ?
> >>
> >> When the initrd is done? What then if the kms driver is not in the ini=
trd,
> >> so maybe when udev is done enumerating devices, but what then if the k=
ernel
> >> is still enumerating hardware at this time?
> >=20
> > Usually an initrd knows how to wait for all or a given set of devices to
> > be probed. udev is pretty good for that.
>=20
> udev does not have a clue how to wait for all devices, it can be used to
> wait for a specific device to show up, that is true, but this requires
> adding specific logic for this (class of) device to the initrd init proce=
ss,
> which is really sub-optimal.

I thought pretty much every distribution that did anything remotely
related to early DRM/KMS like plymouth and whatnot already had this
specific logic. It's been a while since I dealt with all that, but
something roughly like this used to be present in pretty much all
distributions:

	udevadm trigger --subsystem-match=3Dgraphics \
		--subsystem-match=3Ddrm \
		--subsystem-match=3Dtty
	udevadm settle

The effect of that being that udevadm settle would block as long as
devices were still being probed. Admittedly this was all long before
deferred probing was introduced, so I have no idea how well it plays
with it. But optimizing deferred probing is an entirely different topic
currently under discussion that should help sorting this out, too.

> >> Will we just put a sleep 30
> >> in our initscripts to make sure the kernel is done scanning all busses,
> >> will that be long enough? Maybe we need to re-introduce the scsi_wait_=
done
> >> kernel module which was added as an ugly hack to allow userspace to wa=
it
> >> for the kernel to have finished scanning scsi (and ata / sata) busses,
> >> for controllers found at the time the module was load. Which never wor=
ked
> >> reliable, because it would be possible that the controller itself still
> >> needed to be discovered. We've spend years cleaning up userspace enough
> >> to be able to kill scsi_wait_done. We've already been down this road of
> >> waiting for hw enumeration to be done, and the problem is that on
> >> modern systems *it is never done*.
> >=20
> > Those are mostly integration issues. If you don't load the driver from
> > initrd then I don't think anybody will complain when there's flicker
> > when it finally gets loaded. The whole point of this is to have early
> > access to the framebuffer and get display and graphics going as soon as
> > possible, so please don't pull in hypothetical scenarios where people
> > manually load drivers half an hour after the system has booted.
>=20
> In another mail in this thread you've mentioned 2 uses for simplefb:
>=20
> 1) Serving as *the* fb until a kms driver is present
> 2) Allowing for output of early kernel boot messages.
>=20
> I agree that those are the 2 use-cases we're dealing with here.
>=20
> Note that the whole discussion we're having hear about disabling the cloc=
ks
> once hardware probing is "done", is moot for 1. One possible way mentioned
> of dealing with 1. is to mark these clocks as always on for now, and then=
 we
> need to drop this hack (I cannot call this anything else then a hack), on=
ce
> we get kms, meaning interdependencies between the dropping patch and the =
kms
> adding patches, etc. All not very pretty.

I don't think it's that bad. When your real driver is merged you can
still keep the clocks always on for a release cycle if you worry about
any fallout. It's unlikely to going to be your last driver that you
merge and people aren't immediately going to build products based on it,
so it's unlikely that anyone will notice the wasted power.

> For 2. We have what you call "mostly integration issues". Allow me to copy
> and paste in another bit of this thread here:
>=20
> >> I've been doing low level Linux development for 10 years now and I've
> >> worked a lot on storage (raid, iscsi, fcoe support, etc.) in the past.
> >
> > Ah, so this is now officially a pissing contest, is it?
>=20
> No I'm merely trying to explain that I've a ton of experience with what
> you seem to think of as merely integration issues, and they are a royal P=
ITA,
> and thus to be avoided at all costs. Really, please just trust me on this
> one, doing the whole add some later then late init call type is a bad ide=
a.

Well, you could equally just trust me on this one when I say adding
clock support for this driver is bad. Stalemate.

> >> So second of all, Thierry, what exactly is the technical argument agai=
nst
> >> adding support for dealing with clocks to simplefb ?
> >=20
> > I've already stated technical arguments against it. You could just go
> > back and read the thread again, or would you rather want me to repeat
> > them for your convenience?
>=20
> It is a long thread, IIRC your main arguments against this are:
>=20
> 1) You don't want this kind of platform-specific knowledge in simplefb
> 2) That simplefb is supposed to be simple, and this is not simple
>=20
> As for 1. several people have already argued that clocks as such are
> an abstract concept, found one many platforms and as such are not
> platform specific.

That alone doesn't justify this patch. SoCs often have a requirement to
enable clocks in a specific order, for example. Other systems may need
to coordinate clocks with resets in a specific order or enable power
domains and such. All that is very SoC specific and if we don't make it
very clear what this driver assumes about the state of the system, then
we can't object to anybody adding support for those later on either. The
result of that is going to be a driver that needs to handle all kinds of
combinations of resources.

So while clocks themselves are fairly generic the way in which they need
to be used is highly platform-specific.

Let me also reiterate what I've said a couple of times already. The
issue here isn't that simplefb needs to manage these clocks in any way.
Firmware has already set them up so that display works. The reason why
you need this patch is so that the clock framework doesn't automatically
turn them off. With the proposed patch the driver enables these clocks,
but that's not what it needs to do, they are already on. It's a work
around to prevent the clock framework into not disabling them.

So as far as I'm concerned this points to a fundamental issue with how
the clock framework handles unused clocks. Therefore that is the problem
that should be solved, not worked around.

> Any generic hw driver dealing with embedded platforms, be it ahci, ohci,
> ehci, etc. has ended up adding abstract support for things like clocks
> (and other resources). I say abstract support here, since to all these
> drivers the support was added in a way that no platform specific knowledge
> is necessary, they just deal with clocks not caring about the specific
> underlying clock implementation, clock names, etc.

Yes, I know that. You and I both had a very similar discussion not so
long ago. But the above aren't quite the same as simplefb. The devices
follow at least a well-known standard (EHCI, OHCI, AHCI), so there's
bound to be more commonalities between them than between the various
display devices that simplefb potentially can support.

Interestingly though, if you look at what hardware really is supported
by the generic drivers that deal with embedded platforms, there isn't
all that much diversity (I've manually stripped out non-DTS occurrences
since they aren't relevant for this discussion):

	$ git grep -n generic-ohci
	arch/arm/boot/dts/sun4i-a10.dtsi:451:           compatible =3D "allwinner,=
sun4i-a10-ohci", "generic-ohci";
	arch/arm/boot/dts/sun4i-a10.dtsi:492:           compatible =3D "allwinner,=
sun4i-a10-ohci", "generic-ohci";
	arch/arm/boot/dts/sun5i-a10s.dtsi:403:          compatible =3D "allwinner,=
sun5i-a10s-ohci", "generic-ohci";
	arch/arm/boot/dts/sun5i-a13.dtsi:376:           compatible =3D "allwinner,=
sun5i-a13-ohci", "generic-ohci";
	arch/arm/boot/dts/sun6i-a31.dtsi:410:           compatible =3D "allwinner,=
sun6i-a31-ohci", "generic-ohci";
	arch/arm/boot/dts/sun6i-a31.dtsi:432:           compatible =3D "allwinner,=
sun6i-a31-ohci", "generic-ohci";
	arch/arm/boot/dts/sun6i-a31.dtsi:443:           compatible =3D "allwinner,=
sun6i-a31-ohci", "generic-ohci";
	arch/arm/boot/dts/sun7i-a20.dtsi:535:           compatible =3D "allwinner,=
sun7i-a20-ohci", "generic-ohci";
	arch/arm/boot/dts/sun7i-a20.dtsi:576:           compatible =3D "allwinner,=
sun7i-a20-ohci", "generic-ohci";
	arch/powerpc/boot/dts/akebono.dts:144:          compatible =3D "ibm,476gtr=
-ohci", "generic-ohci";
	arch/powerpc/boot/dts/akebono.dts:151:          compatible =3D "ibm,476gtr=
-ohci", "generic-ohci";

	$ git grep -n generic-ehci
	arch/arm/boot/dts/rk3288.dtsi:199:              compatible =3D "generic-eh=
ci";
	arch/arm/boot/dts/rk3288.dtsi:210:              compatible =3D "generic-eh=
ci";
	arch/arm/boot/dts/sun4i-a10.dtsi:441:           compatible =3D "allwinner,=
sun4i-a10-ehci", "generic-ehci";
	arch/arm/boot/dts/sun4i-a10.dtsi:482:           compatible =3D "allwinner,=
sun4i-a10-ehci", "generic-ehci";
	arch/arm/boot/dts/sun5i-a10s.dtsi:393:          compatible =3D "allwinner,=
sun5i-a10s-ehci", "generic-ehci";
	arch/arm/boot/dts/sun5i-a13.dtsi:366:           compatible =3D "allwinner,=
sun5i-a13-ehci", "generic-ehci";
	arch/arm/boot/dts/sun6i-a31.dtsi:399:           compatible =3D "allwinner,=
sun6i-a31-ehci", "generic-ehci";
	arch/arm/boot/dts/sun6i-a31.dtsi:421:           compatible =3D "allwinner,=
sun6i-a31-ehci", "generic-ehci";
	arch/arm/boot/dts/sun7i-a20.dtsi:525:           compatible =3D "allwinner,=
sun7i-a20-ehci", "generic-ehci";
	arch/arm/boot/dts/sun7i-a20.dtsi:566:           compatible =3D "allwinner,=
sun7i-a20-ehci", "generic-ehci";
	arch/powerpc/boot/dts/akebono.dts:130:          compatible =3D "ibm,476gtr=
-ehci", "generic-ehci";

For generic-ahci there aren't any matches, but here are a few that are
marked compatible with it using different compatible strings:

	$ git grep -n snps,spear-ahci
	arch/arm/boot/dts/spear1310.dtsi:60:            compatible =3D "snps,spear=
-ahci";
	arch/arm/boot/dts/spear1310.dtsi:69:            compatible =3D "snps,spear=
-ahci";
	arch/arm/boot/dts/spear1310.dtsi:78:            compatible =3D "snps,spear=
-ahci";
	arch/arm/boot/dts/spear1340.dtsi:43:            compatible =3D "snps,spear=
-ahci";

	$ git grep -n snps,exynos5440-ahci
	arch/arm/boot/dts/exynos5440.dtsi:241:          compatible =3D "snps,exyno=
s5440-ahci";

	$ git grep -n 'ibm,476gtr-ahci'
	arch/powerpc/boot/dts/akebono.dts:123:          compatible =3D "ibm,476gtr=
-ahci";

	$ git grep -n 'snps,dwc-ahci'
	arch/arm/boot/dts/dra7.dtsi:1049:               compatible =3D "snps,dwc-a=
hci";
	arch/arm/boot/dts/exynos5250.dtsi:265:          compatible =3D "snps,dwc-a=
hci";
	arch/arm/boot/dts/omap5.dtsi:919:               compatible =3D "snps,dwc-a=
hci";

That looks fairly homogenous to me. There are also things like this
(from the ahci_platform.c driver):

	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
		hpriv->flags |=3D AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;

With more supported hardware there's bound to be more quirks like that.

So there's a couple of SoCs and boards that actually are generic enough
to work with a generic driver. And then there's a whole bunch of other
drivers for hardware that's compliant with the same standard yet needs
different drivers. To me that's a clear indication that there isn't
enough genericity to warrant a generic driver in the first place.

The commonality is in the functionality and defined by the standard
registers. But there's little to no commonality in how that interface is
glued into the SoC. Luckily the above subsystems implement the standard
hardware programming in a library, so that non-generic drivers can still
make use of most of the generic code.

> This really is unavoidable. The framebuffer memory needed was mentioned
> as another example of a resource in this thread. You suggested using the
> new mem-reserve framework for this. I agree that that is the right thing
> to do, but even then we still need a way to tie this reserved mem to
> the simplefb, so that the kernel can know when it is no longer used
> and can be added to the general memory pool.

Yes, memory handling seems like it isn't handled optimally by simplefb.
To be fair the simplefb driver predates the reserved-memory bindings. I
think it might be worthwhile to investigate on how to extend the binding
to make use of that, though. I think the assumption currently is that
the framebuffer memory will be lost forever (it needs to be carved out
of the physical memory that the kernel gets to see). I couldn't find any
code that returned reserved-memory to the kernel, but it's certainly a
feature that I think we want. Especially if the firmware framebuffer is
large (as in 1080p).

> If you look at how almost all dt bindings work, then the dt node for
> a device specifies the resources needed, I don't see why simplefb would
> be so special that it should be different here. I agree that it is
> important to get the abstractions right here, but to me it seems that
> the right abstraction is to be consistent with how all other devices
> are abstracted and to add needed resources to the dt node for the
> simplefb.

But simplefb is fundamentally different from other devices. It isn't a
physical device at all. It's a virtual device that reuses resources as
set up by some other piece of code (firmware). It implies that there's
nothing that needs to be managed. It should only create a framebuffer
with the given parameters and allow the kernel (and userspace) to render
into it.

The only way you can deal with such virtual, completely generic devices
is by being very explicit about the requirements. For simplefb the
assumptions are that firmware set everything up and passes information
about what it set up to the kernel so that it can be reused. None of the
resources need to be explicitly managed because they have all been
properly configured. For that reason, again, I think the right way is
for the kernel not to switch off any of the used resources.

If you want to equate simplefb to other drivers then it is fundamentally
broken anyway. Given only what's in the DTB the simplefb driver won't be
able to do anything useful. Consider what would happen if the firmware
didn't set up all the resources. Then the DT is missing resets, power
supplies and all that to make it work.

> As for 2. Yes this will add some more code to simplefb, more code but
> code which is not complicated in anyway, so the simplefb code would
> become larger but still stay simple. Were as all the suggested
> alternatives sofar are at least an order of magnitude more complicated,
> crossing many subsystems, demanding coordination with userspace, etc.

I'm not objecting to this patch because of the complexity, but because
it is an illusion that the code is in any way generic.

> > so I think we should keep the discussion going for a bit and
> > see if we really can't come up with something that will fix this for a
> > more general case rather than just your particular use-case. It's
> > evidently a recurring problem that others suffer from, too.
>=20
> Yes needing resources despite the device being behind some generic
> interface where the main driver code for that interface has no knowledge
> about such resources sofar, because e.g. on PC-s this was not necessary
> is a recurring problem, which has been solved already 3 times at least,
> see the ohci-, ehci- and ahci-platform drivers, and for all 3 the conclus=
ion
> was that the best solution was to simple add the resources to the dt-node,
> and add code to claim and enable them.

And as I pointed out above in all three cases the generic platform
driver is only marginally useful because many SoCs have specific
requirements that make them incompatible with the generic driver.

Thierry

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/dVtAAoJEN0jrNd/PrOhVCYQAKHHgMNC8GyWCpYzdeck6CzU
6cZjq7j8gyopyJ33aIN1gemmY5nWpYSP2RuA/Y7D293iz8KmIeeu3pVyhs+0011R
3151UpwVT7PDCjW/HN0gxIum9igT8PWwOUb/JHv75HZWVheyjsDHs0rCQVXJB+NG
NxnIMaVGH1WfKHttuNj+XnPNjx82l10j+8ZH38dPwo7CG/QZqKlSraHveIVBQaOd
vVkcFVVgB5zDngBgRXDjVHLs2FlqVKaYu4CCe35/oGAajfq6DXlwXODFiEU1zHtN
9zZxGOVT8MsnDRASzUgCqdDBX9Dx9JXpaRmwzDnv7dwtF6FzfvhhDLt95+giPFw/
1+sKccb6308uaD+VWk59dM5xOCHAGMaRRCSrAIX7ahjXDoDQKg5W90Eua8q7N5dU
z9thXvKTKBSZxw9Pi7GJy7VHxL/pWtxPg63Mx6Ncsr+D6bHAYj/nKdcakHBIulNO
JenCuMA3LpnVmYNIu+TqAWH+mfFE2bFFm6otyAacJC62InHaWAllhVvX9UFK5H5c
BZ7G2ldnvSQIN7k0cH3DOtx+qBOj8iLm65jb/8IMatE8bZYQWV5Bc5nkfNZmwvwu
p/cwU3fWWgd1e7KSUz8ytTQ5wKZIObkR/rmjdiJaicIxfxPT16Lnr3q2PZlxdbSr
o52qU15Bs3wdUExSZhqq
=ksOJ
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
