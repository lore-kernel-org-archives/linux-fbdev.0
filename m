From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 29 Aug 2014 13:57:08 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140829135708.GG15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OyvJ9bcDTA2jS0yg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <20140827084526.GR15297@lukather> <20140827095241.GC23186@ulmo>
 <20140827154221.GX15297@lukather> <20140828101140.GB14388@ulmo>
 <20140828204603.GB15297@lukather> <20140829062932.GB13106@ulmo>
In-Reply-To: <20140829062932.GB13106@ulmo>
To: linux-arm-kernel@lists.infradead.org


--OyvJ9bcDTA2jS0yg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 08:29:33AM +0200, Thierry Reding wrote:
> On Thu, Aug 28, 2014 at 10:46:03PM +0200, Maxime Ripard wrote:
> > On Thu, Aug 28, 2014 at 12:11:41PM +0200, Thierry Reding wrote:
> [...]
> > > Then since firmware already knows what it set up it can tell the
> > > kernel to not touch those.
> >=20
> > Somehow, I've been raised kernel-wise into thinking that you can never
> > fully trust your firmware. Or at least that you should have a way to
> > recover from any bug/bad behaviour from it.
>=20
> If you don't trust your firmware then you shouldn't be taking over a
> device that it's set up for you. Rather you should write a proper driver
> that sets things up from the start.
>=20
> This whole "we don't trust firmware" isn't going to work if we want to
> have hand-off from firmware to kernel. And it's already been decided in
> other threads that moving more code out of the kernel and into firmware
> is a requirement (c.f. ARM64).

Except that in ARM64 case, it has been asked before having any
SoC/boards out. We're definitely not in this situation there.

> Also in this case you wrote the firmware, so why wouldn't you trust it?

We partly wrote the firmware, on some of the available SoCs. Some
other just have allwinner's own. But yeah, in this case they wouldn't
even set up the framebuffer in the first place.

> > Moreover, the way I see it, there's a major flaw in having an
> > attribute in the clock node: you don't even know if the clock is ever
> > going to be used.
> >=20
> > If simplefb is not compiled in, you won't claim the clocks, and they
> > will be disabled, which is imho a good thing. This case wouldn't be
> > covered with an attribute at the clock node, because you don't have a
> > link to what device/feature actually uses it in the system, and so you
> > have to make the assumption that it will be used. And you will end up
> > with clocks with a rather high rate running for nothing.
>=20
> That's completely hypothetical. If simplefb isn't enabled and the clock
> isn't claimed there's probably still going to be some other driver
> taking over eventually. If there isn't, what's the point of firmware
> setting up display in the first case?

And now, here is a new requirement for the firmware: that in addition
to being reliable, that it must not be dumb, or take shortcuts, like
setting up the framebuffer in every case, no matter wether there's a
screen or not.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--OyvJ9bcDTA2jS0yg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUAIa0AAoJEBx+YmzsjxAgfLsQAJeJv7eDy3R/zak1r7O9EhZN
ghnNtdX2Ayn0VhQpi15p7TLKAJuK5WYLPpoEndu2kdQOZQyn+DGZUyfdbAcotMSI
OnwUaD6qF++D6TMNUKoVrQTTzZ1bHCVAI0G3p9FdgOJv5v0b3XQhhngcWFQis0Pp
7EkOEflv0PFEFe0sT1jO5+5HTiWXJC9LpBb4ZFO1ZQZ8ULiM/3AOHIFV6znnz3yM
d+841Vju/7BZQ/x5BAVRvFNvLPDPY744PTLb16wE+CJkzsAN5MSHCuX4iGAOsrFj
P81M9VXxh6lhrLUSmfj+p/ijoYKpKVqpnYKCmmbnBGnR5XTPME2AQKdlh6OxpAEa
+K1F5OOMKAa4JrROK5SC9dAXTdBtmUWHYAHjdoJ2f/YOCnwl9vrp7jiZ8c62HiVf
/4kxQCWu1bqAvjCYY49MuqRaPMoQpupfCkpiGC2wNeOfAcxe72q65/mr4/si277g
t4IjL+5knHqCwZ8sshiWHqg/YrXSnB4YqOOCT3RW7MF3CBggCr03YYxc4e8oIXsr
vYPOVLQfcf9GLI5AtAljBOgjpprmdSlj6Q2MNUsgoyDiU3au6Sv7l32/h3aELt4h
5qneMVSPteapHZyKobF9GqYqXAEnbSWtO2Ug/z8gmpxEc1kSFxuWSVv6MRehoOj1
prRtYiCef5WewJGfcLqC
=E4el
-----END PGP SIGNATURE-----

--OyvJ9bcDTA2jS0yg--
