From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 27 Aug 2014 15:42:21 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827154221.GX15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="A7dSUaxngFh2KEF6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <20140827084526.GR15297@lukather> <20140827095241.GC23186@ulmo>
In-Reply-To: <20140827095241.GC23186@ulmo>
To: linux-arm-kernel@lists.infradead.org


--A7dSUaxngFh2KEF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 11:52:48AM +0200, Thierry Reding wrote:
> On Wed, Aug 27, 2014 at 10:45:26AM +0200, Maxime Ripard wrote:
> > On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
> > > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> > > > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
> [...]
> > > > > > Mike Turquette repeatedly said that he was against such a DT pr=
operty:
> > > > > > https://lkml.org/lkml/2014/5/12/693
> > > > >=20
> > > > > Mike says in that email that he's opposing the addition of a prop=
erty
> > > > > for clocks that is the equivalent of regulator-always-on. That's =
not
> > > > > what this is about. If at all it'd be a property to mark a clock =
that
> > > > > should not be disabled by default because it's essential.
> > > >=20
> > > > It's just semantic. How is "a clock that should not be disabled by
> > > > default because it's essential" not a clock that stays always on?
> > >=20
> > > Because a clock that should not be disabled by default can be turned =
off
> > > when appropriate. A clock that is always on can't be turned off.
> >=20
> > If a clock is essential, then it should never be disabled. Or we don't
> > share the same meaning of essential.
>=20
> Essential for the particular use-case.

So, how would the clock driver would know about which use case we're
in? How would it know about which display engine is currently running?
How would it know about which video output is being set?

Currently, we have two separate display engines, which can each output
either to 4 different outputs (HDMI, RGB/LVDS, 2 DSI). Each and every
one of these combinations would require different clocks. What clocks
will we put in the driver? All of them?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--A7dSUaxngFh2KEF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/fxdAAoJEBx+YmzsjxAgaHQQALDRGwdTzEHkd1r1RvFu71Zk
GYm+lHXW2pLc+8djR/onJEBmINLoaIuqwnxPQZ2f91BeA07zeqQRCz3gJup+uCNB
WBNXxYhEc54qEVuJENkGmpi3QXplVDBpv9Ci3i4L7rnZ2VPTjeKCIsMrbYg16dEl
FkGN1Fs1S3DZFNR3i0faWwEDv1RdA4mUiHwygS2ZF7r8Yd9gwPCPfN+2qDfMnpuy
57MP3gj24VFlTw2J5SgK/h50ZzonAfWn6xroMO/aYTfTSAf+Ga1gABavBJz5x1Uu
/e/8olYNVaPFig1aLvfd38RpSln6KXc3r/VdkmfXNwAI5Ma3OyoGXWnXPskZlW5S
7UlaXvAGQ6ALOdZ+3Vn4IFz35oV2h811UXuohdmnewBX2bR7KCqXdq3J9V1wFFjH
A8su2kOhEauqIS4Rb6H8wCImnIvksW7FBzDpROKT+p2oU0d6FGMTnYS7G0MQQp/2
UF2IJBp6Dz9xSjEh9kJwGTqAFLQ/Gx+2HqTBfkfr8hNzgdO/DlCN+TuEUpYcQZf1
oCTukKbmOxDnXhYFPF73NqumBjXq2QJVGVta5AszvuISbSvhUxn7ALeEgeNMfGob
uHA/GwYW2AqaCx0FRe6rmWZL6dg7go1QKi+qR50lTflbqho3vS8VoMDaFVBJ2Aox
ty87r7zl7lES1rBHGJwn
=k0jA
-----END PGP SIGNATURE-----

--A7dSUaxngFh2KEF6--
