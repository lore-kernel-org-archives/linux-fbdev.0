From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 27 Aug 2014 14:30:23 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827143022.GC32243@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XWOWbaMNXpFDWE00"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <20140827135609.GW15297@lukather>
In-Reply-To: <20140827135609.GW15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 03:56:09PM +0200, Maxime Ripard wrote:
> On Wed, Aug 27, 2014 at 02:56:14PM +0200, Thierry Reding wrote:
> > > >> So second of all, Thierry, what exactly is the technical argument =
against
> > > >> adding support for dealing with clocks to simplefb ?
> > > >=20
> > > > I've already stated technical arguments against it. You could just =
go
> > > > back and read the thread again, or would you rather want me to repe=
at
> > > > them for your convenience?
> > >=20
> > > It is a long thread, IIRC your main arguments against this are:
> > >=20
> > > 1) You don't want this kind of platform-specific knowledge in simplefb
> > > 2) That simplefb is supposed to be simple, and this is not simple
> > >=20
> > > As for 1. several people have already argued that clocks as such are
> > > an abstract concept, found one many platforms and as such are not
> > > platform specific.
> >=20
> > That alone doesn't justify this patch. SoCs often have a requirement to
> > enable clocks in a specific order, for example. Other systems may need
> > to coordinate clocks with resets in a specific order or enable power
> > domains and such. All that is very SoC specific and if we don't make it
> > very clear what this driver assumes about the state of the system, then
> > we can't object to anybody adding support for those later on either. The
> > result of that is going to be a driver that needs to handle all kinds of
> > combinations of resources.
>=20
> Which is not an issue in our case, since the firmware enabled them
> already.

Exactly, so why do you need them at all? You shouldn't have to.

> > So there's a couple of SoCs and boards that actually are generic enough
> > to work with a generic driver. And then there's a whole bunch of other
> > drivers for hardware that's compliant with the same standard yet needs
> > different drivers. To me that's a clear indication that there isn't
> > enough genericity to warrant a generic driver in the first place.
> >=20
> > The commonality is in the functionality and defined by the standard
> > registers. But there's little to no commonality in how that interface is
> > glued into the SoC. Luckily the above subsystems implement the standard
> > hardware programming in a library, so that non-generic drivers can still
> > make use of most of the generic code.
>=20
> To be fair, these additions are a couple of release old, and are quite
> recent. You can't really make any judgement based on barely 2 releases
> of history.

Okay, fair enough. Time will tell. It's still kind of odd to declare a
driver to be generic without attempting to make the majority of existing
drivers work with it.

> > > If you look at how almost all dt bindings work, then the dt node for
> > > a device specifies the resources needed, I don't see why simplefb wou=
ld
> > > be so special that it should be different here. I agree that it is
> > > important to get the abstractions right here, but to me it seems that
> > > the right abstraction is to be consistent with how all other devices
> > > are abstracted and to add needed resources to the dt node for the
> > > simplefb.
> >=20
> > But simplefb is fundamentally different from other devices. It isn't a
> > physical device at all. It's a virtual device that reuses resources as
> > set up by some other piece of code (firmware). It implies that there's
> > nothing that needs to be managed. It should only create a framebuffer
> > with the given parameters and allow the kernel (and userspace) to render
> > into it.
>=20
> Nothing should be managed, but everything should stay as is. Again,
> this is something that we all seem to agree on, yet differ completely
> on how to implement that.

I'm arguing that if everything should stay as is, then nobody should
have to do anything.

> > The only way you can deal with such virtual, completely generic devices
> > is by being very explicit about the requirements. For simplefb the
> > assumptions are that firmware set everything up and passes information
> > about what it set up to the kernel so that it can be reused. None of the
> > resources need to be explicitly managed because they have all been
> > properly configured. For that reason, again, I think the right way is
> > for the kernel not to switch off any of the used resources.
>=20
> So, you're saying that the firmware should inform the kernel about
> what clocks it has set up?

Yes. The problem is that even if we tell the kernel that clocks have
been set up it may still decide to disable them when they are unused.
That's the whole purpose of clk_disable_unused() as I understand it.
Whatever mechanism we introduce needs to specifically imply that the
clock must stay enabled.

> > If you want to equate simplefb to other drivers then it is fundamentally
> > broken anyway. Given only what's in the DTB the simplefb driver won't be
> > able to do anything useful. Consider what would happen if the firmware
> > didn't set up all the resources. Then the DT is missing resets, power
> > supplies and all that to make it work.
>=20
> That would mean that the framebuffer wasn't working in the first
> place, which breaks the initial assumption, doesn't it?

Exactly. simplefb gets away with an incomplete description of the
hardware in DT because of these assumptions. So you can't draw parallels
to other drivers since they don't make these assumptions and need to be
described completely.

Thierry

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/et+AAoJEN0jrNd/PrOhbmQP/1iuejPiARKgqJT06STkUYKC
Qdy8mX6fmff0JBZliMCXlCjoI1ERoCsZQqKw5yrMAQJsi4Yft0RW2Pzv6CGzux0J
qHTum+mYiA0AfiW7CGyWLXD27rRjUOq/Atcj5oDkOg4QkqsF34IlNfLO5kNU5+Fu
6iAaENYzU+8cem7LMUodCG7radfypomhioNUx3DhBOcoTkMt8pP6t5XzVBQlrhYt
WZEKJqZRcJVksPdKpb3zY3Mxg+6QBnbsYiCkMTqvL3RDPhLv3xkX/Vl2zOFS0h/f
6UFWWv3cPmfPfPb3Mxfo3E+/H6IMrpwJ61tzceY/pgFZ07Yu4i/hw+zKy/zfnjA6
sarTi0sOonxUI5ax+JkUGmYM24HoXdoBugUsQ3kThTmJjAOlF7tbJR8PGVe924h+
0g4K+6cTyRLbG4D92wUlcDOf2K/dMyBjp5Bg00ouur3bI89bU/uEnKxNRrTrIPNR
/sbzp0t2Sf2Q+BSPMd7SnOSlCFG6zqQacm+eB46Qk0yC1MOdWvFb8uN0Pb1vB8Ct
wlGpt+TzYn5QTcWmqFNGOYiH10Pk5QDwIbj0Emu578FgfiY3Wz0g+DiO2El2JZCN
BpAac+wDNb9toAHP5uhz2iyhzoVGt+n614wEe6ZevoRKGwl5nAal0HGMV5EZF5dd
NsGE+fFHebpnxs9E2xe/
=FOJ8
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
