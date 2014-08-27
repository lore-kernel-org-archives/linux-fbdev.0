From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 27 Aug 2014 13:56:09 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827135609.GW15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SJBlQl/PP8ECuS+e"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
In-Reply-To: <20140827125613.GF23186@ulmo>
To: linux-arm-kernel@lists.infradead.org


--SJBlQl/PP8ECuS+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 02:56:14PM +0200, Thierry Reding wrote:
> > >> So second of all, Thierry, what exactly is the technical argument ag=
ainst
> > >> adding support for dealing with clocks to simplefb ?
> > >=20
> > > I've already stated technical arguments against it. You could just go
> > > back and read the thread again, or would you rather want me to repeat
> > > them for your convenience?
> >=20
> > It is a long thread, IIRC your main arguments against this are:
> >=20
> > 1) You don't want this kind of platform-specific knowledge in simplefb
> > 2) That simplefb is supposed to be simple, and this is not simple
> >=20
> > As for 1. several people have already argued that clocks as such are
> > an abstract concept, found one many platforms and as such are not
> > platform specific.
>=20
> That alone doesn't justify this patch. SoCs often have a requirement to
> enable clocks in a specific order, for example. Other systems may need
> to coordinate clocks with resets in a specific order or enable power
> domains and such. All that is very SoC specific and if we don't make it
> very clear what this driver assumes about the state of the system, then
> we can't object to anybody adding support for those later on either. The
> result of that is going to be a driver that needs to handle all kinds of
> combinations of resources.

Which is not an issue in our case, since the firmware enabled them
already.

> So while clocks themselves are fairly generic the way in which they need
> to be used is highly platform-specific.
>=20
> Let me also reiterate what I've said a couple of times already. The
> issue here isn't that simplefb needs to manage these clocks in any way.
> Firmware has already set them up so that display works. The reason why
> you need this patch is so that the clock framework doesn't automatically
> turn them off. With the proposed patch the driver enables these clocks,
> but that's not what it needs to do, they are already on. It's a work
> around to prevent the clock framework into not disabling them.
>=20
> So as far as I'm concerned this points to a fundamental issue with how
> the clock framework handles unused clocks. Therefore that is the problem
> that should be solved, not worked around.

Well, this is again a philosophical difference them. I find like the
right thing to do for the clock framework to disable the clocks that
are enabled if no one reports them as used. That also comes down to
all the drivers that require a clock to stay enabled should report to
the clock framework to tell that it uses this clock. Fortunately, we
have everything in place to do so.

> > Any generic hw driver dealing with embedded platforms, be it ahci, ohci,
> > ehci, etc. has ended up adding abstract support for things like clocks
> > (and other resources). I say abstract support here, since to all these
> > drivers the support was added in a way that no platform specific knowle=
dge
> > is necessary, they just deal with clocks not caring about the specific
> > underlying clock implementation, clock names, etc.
>=20
> Yes, I know that. You and I both had a very similar discussion not so
> long ago. But the above aren't quite the same as simplefb. The devices
> follow at least a well-known standard (EHCI, OHCI, AHCI), so there's
> bound to be more commonalities between them than between the various
> display devices that simplefb potentially can support.
>=20
> Interestingly though, if you look at what hardware really is supported
> by the generic drivers that deal with embedded platforms, there isn't
> all that much diversity (I've manually stripped out non-DTS occurrences
> since they aren't relevant for this discussion):
>=20
> 	$ git grep -n generic-ohci
> 	arch/arm/boot/dts/sun4i-a10.dtsi:451:           compatible =3D "allwinne=
r,sun4i-a10-ohci", "generic-ohci";
> 	arch/arm/boot/dts/sun4i-a10.dtsi:492:           compatible =3D "allwinne=
r,sun4i-a10-ohci", "generic-ohci";
> 	arch/arm/boot/dts/sun5i-a10s.dtsi:403:          compatible =3D "allwinne=
r,sun5i-a10s-ohci", "generic-ohci";
> 	arch/arm/boot/dts/sun5i-a13.dtsi:376:           compatible =3D "allwinne=
r,sun5i-a13-ohci", "generic-ohci";
> 	arch/arm/boot/dts/sun6i-a31.dtsi:410:           compatible =3D "allwinne=
r,sun6i-a31-ohci", "generic-ohci";
> 	arch/arm/boot/dts/sun6i-a31.dtsi:432:           compatible =3D "allwinne=
r,sun6i-a31-ohci", "generic-ohci";
> 	arch/arm/boot/dts/sun6i-a31.dtsi:443:           compatible =3D "allwinne=
r,sun6i-a31-ohci", "generic-ohci";
> 	arch/arm/boot/dts/sun7i-a20.dtsi:535:           compatible =3D "allwinne=
r,sun7i-a20-ohci", "generic-ohci";
> 	arch/arm/boot/dts/sun7i-a20.dtsi:576:           compatible =3D "allwinne=
r,sun7i-a20-ohci", "generic-ohci";
> 	arch/powerpc/boot/dts/akebono.dts:144:          compatible =3D "ibm,476g=
tr-ohci", "generic-ohci";
> 	arch/powerpc/boot/dts/akebono.dts:151:          compatible =3D "ibm,476g=
tr-ohci", "generic-ohci";
>=20
> 	$ git grep -n generic-ehci
> 	arch/arm/boot/dts/rk3288.dtsi:199:              compatible =3D "generic-=
ehci";
> 	arch/arm/boot/dts/rk3288.dtsi:210:              compatible =3D "generic-=
ehci";
> 	arch/arm/boot/dts/sun4i-a10.dtsi:441:           compatible =3D "allwinne=
r,sun4i-a10-ehci", "generic-ehci";
> 	arch/arm/boot/dts/sun4i-a10.dtsi:482:           compatible =3D "allwinne=
r,sun4i-a10-ehci", "generic-ehci";
> 	arch/arm/boot/dts/sun5i-a10s.dtsi:393:          compatible =3D "allwinne=
r,sun5i-a10s-ehci", "generic-ehci";
> 	arch/arm/boot/dts/sun5i-a13.dtsi:366:           compatible =3D "allwinne=
r,sun5i-a13-ehci", "generic-ehci";
> 	arch/arm/boot/dts/sun6i-a31.dtsi:399:           compatible =3D "allwinne=
r,sun6i-a31-ehci", "generic-ehci";
> 	arch/arm/boot/dts/sun6i-a31.dtsi:421:           compatible =3D "allwinne=
r,sun6i-a31-ehci", "generic-ehci";
> 	arch/arm/boot/dts/sun7i-a20.dtsi:525:           compatible =3D "allwinne=
r,sun7i-a20-ehci", "generic-ehci";
> 	arch/arm/boot/dts/sun7i-a20.dtsi:566:           compatible =3D "allwinne=
r,sun7i-a20-ehci", "generic-ehci";
> 	arch/powerpc/boot/dts/akebono.dts:130:          compatible =3D "ibm,476g=
tr-ehci", "generic-ehci";
>=20
> For generic-ahci there aren't any matches, but here are a few that are
> marked compatible with it using different compatible strings:
>=20
> 	$ git grep -n snps,spear-ahci
> 	arch/arm/boot/dts/spear1310.dtsi:60:            compatible =3D "snps,spe=
ar-ahci";
> 	arch/arm/boot/dts/spear1310.dtsi:69:            compatible =3D "snps,spe=
ar-ahci";
> 	arch/arm/boot/dts/spear1310.dtsi:78:            compatible =3D "snps,spe=
ar-ahci";
> 	arch/arm/boot/dts/spear1340.dtsi:43:            compatible =3D "snps,spe=
ar-ahci";
>=20
> 	$ git grep -n snps,exynos5440-ahci
> 	arch/arm/boot/dts/exynos5440.dtsi:241:          compatible =3D "snps,exy=
nos5440-ahci";
>=20
> 	$ git grep -n 'ibm,476gtr-ahci'
> 	arch/powerpc/boot/dts/akebono.dts:123:          compatible =3D "ibm,476g=
tr-ahci";
>=20
> 	$ git grep -n 'snps,dwc-ahci'
> 	arch/arm/boot/dts/dra7.dtsi:1049:               compatible =3D "snps,dwc=
-ahci";
> 	arch/arm/boot/dts/exynos5250.dtsi:265:          compatible =3D "snps,dwc=
-ahci";
> 	arch/arm/boot/dts/omap5.dtsi:919:               compatible =3D "snps,dwc=
-ahci";
>=20
> That looks fairly homogenous to me. There are also things like this
> (from the ahci_platform.c driver):
>=20
> 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> 		hpriv->flags |=3D AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>=20
> With more supported hardware there's bound to be more quirks like that.
>=20
> So there's a couple of SoCs and boards that actually are generic enough
> to work with a generic driver. And then there's a whole bunch of other
> drivers for hardware that's compliant with the same standard yet needs
> different drivers. To me that's a clear indication that there isn't
> enough genericity to warrant a generic driver in the first place.
>=20
> The commonality is in the functionality and defined by the standard
> registers. But there's little to no commonality in how that interface is
> glued into the SoC. Luckily the above subsystems implement the standard
> hardware programming in a library, so that non-generic drivers can still
> make use of most of the generic code.


To be fair, these additions are a couple of release old, and are quite
recent. You can't really make any judgement based on barely 2 releases
of history.

> > If you look at how almost all dt bindings work, then the dt node for
> > a device specifies the resources needed, I don't see why simplefb would
> > be so special that it should be different here. I agree that it is
> > important to get the abstractions right here, but to me it seems that
> > the right abstraction is to be consistent with how all other devices
> > are abstracted and to add needed resources to the dt node for the
> > simplefb.
>=20
> But simplefb is fundamentally different from other devices. It isn't a
> physical device at all. It's a virtual device that reuses resources as
> set up by some other piece of code (firmware). It implies that there's
> nothing that needs to be managed. It should only create a framebuffer
> with the given parameters and allow the kernel (and userspace) to render
> into it.

Nothing should be managed, but everything should stay as is. Again,
this is something that we all seem to agree on, yet differ completely
on how to implement that.

> The only way you can deal with such virtual, completely generic devices
> is by being very explicit about the requirements. For simplefb the
> assumptions are that firmware set everything up and passes information
> about what it set up to the kernel so that it can be reused. None of the
> resources need to be explicitly managed because they have all been
> properly configured. For that reason, again, I think the right way is
> for the kernel not to switch off any of the used resources.

So, you're saying that the firmware should inform the kernel about
what clocks it has set up?

I do agree on that too.

And it looks like we reached an agreement then, since it's exactly
what this patch is relying on.

> If you want to equate simplefb to other drivers then it is fundamentally
> broken anyway. Given only what's in the DTB the simplefb driver won't be
> able to do anything useful. Consider what would happen if the firmware
> didn't set up all the resources. Then the DT is missing resets, power
> supplies and all that to make it work.

That would mean that the framebuffer wasn't working in the first
place, which breaks the initial assumption, doesn't it?

> > > so I think we should keep the discussion going for a bit and
> > > see if we really can't come up with something that will fix this for a
> > > more general case rather than just your particular use-case. It's
> > > evidently a recurring problem that others suffer from, too.
> >=20
> > Yes needing resources despite the device being behind some generic
> > interface where the main driver code for that interface has no knowledge
> > about such resources sofar, because e.g. on PC-s this was not necessary
> > is a recurring problem, which has been solved already 3 times at least,
> > see the ohci-, ehci- and ahci-platform drivers, and for all 3 the concl=
usion
> > was that the best solution was to simple add the resources to the dt-no=
de,
> > and add code to claim and enable them.
>=20
> And as I pointed out above in all three cases the generic platform
> driver is only marginally useful because many SoCs have specific
> requirements that make them incompatible with the generic driver.

s/marginally useful/marginally used/

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--SJBlQl/PP8ECuS+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/eN5AAoJEBx+YmzsjxAgnEUP/0VLce+vIzzfnKOF9Noz5AUf
bHAddFq+NOaiJ/0m7/2szjpoYj66Ck2LyQH+QVxu9d3KVUCmR4t9ncApAk+6iJyI
RRGQAwLCa0x15yMI6ShndagkvpRwZm41Dd0DcHFVy8dMrXFqOQzM7IooUFJhz/t5
53Squ4S9VR6zLaC8VsFtLh294tk1aKRXyUDdvX0y97tmNopqd4AimzLdr0EW4qxs
HBhVvB4da00S51R7Z6sHJy0s1zQQHckch6+3GqAbjYDySHYiYSCIFt3O4XFh4MWE
blYb9PWHRuTAhyuZWjKSagCjfMSBsaMmbym4iSwCvGFFVWxVHlmwe1lqZGsPZmq5
RXCW4DVCnnak8nGAJbUmf24mZ3XRcCEEj2XCKEhNUtTjcoMeFRalbgFKoqFD1VOm
5tgr/3MHHZ4J1Oz8hBZ4GMCxuGjpCijsGbuIpUNEzsnS4zujIpUkRUbksAmekXD8
8AFZn5D2/Le0AH22kdMZjzo+84uxGBEFkfljlGyMbkK1eIneVZSghO0wcjY2SW5Z
Vwy0lKqxEPyNrIZTAbpE86oftVxEtmmx+vjIqkNx7D8CTsXqBQ+usiY51H89w8r3
4jpKusSlMH57btzDH5TLRR7nOJXRrAPnwafadUK3r5ogY6XVrQBqdramVj09CnAA
HHWjySny0w6HLIKK7y+m
=6//A
-----END PGP SIGNATURE-----

--SJBlQl/PP8ECuS+e--
