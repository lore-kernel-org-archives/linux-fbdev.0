From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 28 Aug 2014 20:46:03 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140828204603.GB15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4HtkOwtDb9iYfHNA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <20140827084526.GR15297@lukather> <20140827095241.GC23186@ulmo>
 <20140827154221.GX15297@lukather> <20140828101140.GB14388@ulmo>
In-Reply-To: <20140828101140.GB14388@ulmo>
To: linux-arm-kernel@lists.infradead.org


--4HtkOwtDb9iYfHNA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2014 at 12:11:41PM +0200, Thierry Reding wrote:
> On Wed, Aug 27, 2014 at 05:42:21PM +0200, Maxime Ripard wrote:
> > On Wed, Aug 27, 2014 at 11:52:48AM +0200, Thierry Reding wrote:
> > > On Wed, Aug 27, 2014 at 10:45:26AM +0200, Maxime Ripard wrote:
> > > > On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
> > > > > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> > > > > > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
> > > [...]
> > > > > > > > Mike Turquette repeatedly said that he was against such a D=
T property:
> > > > > > > > https://lkml.org/lkml/2014/5/12/693
> > > > > > >=20
> > > > > > > Mike says in that email that he's opposing the addition of a =
property
> > > > > > > for clocks that is the equivalent of regulator-always-on. Tha=
t's not
> > > > > > > what this is about. If at all it'd be a property to mark a cl=
ock that
> > > > > > > should not be disabled by default because it's essential.
> > > > > >=20
> > > > > > It's just semantic. How is "a clock that should not be disabled=
 by
> > > > > > default because it's essential" not a clock that stays always o=
n?
> > > > >=20
> > > > > Because a clock that should not be disabled by default can be tur=
ned off
> > > > > when appropriate. A clock that is always on can't be turned off.
> > > >=20
> > > > If a clock is essential, then it should never be disabled. Or we do=
n't
> > > > share the same meaning of essential.
> > >=20
> > > Essential for the particular use-case.
> >=20
> > So, how would the clock driver would know about which use case we're
> > in? How would it know about which display engine is currently running?
> > How would it know about which video output is being set?
> >=20
> > Currently, we have two separate display engines, which can each output
> > either to 4 different outputs (HDMI, RGB/LVDS, 2 DSI). Each and every
> > one of these combinations would require different clocks. What clocks
> > will we put in the driver? All of them?
>=20
> Ideally the solution wouldn't involve hard-coding this into the clock
> driver at all.

Cool, so we do agree on that too :)

> There should be a way for firmware to communicate to the kernel that
> a given clock shouldn't be disabled.

And this patch was such an attempt. I guess it wasn't that far off
then.

> Then since firmware already knows what it set up it can tell the
> kernel to not touch those.

Somehow, I've been raised kernel-wise into thinking that you can never
fully trust your firmware. Or at least that you should have a way to
recover from any bug/bad behaviour from it.

Moreover, the way I see it, there's a major flaw in having an
attribute in the clock node: you don't even know if the clock is ever
going to be used.

If simplefb is not compiled in, you won't claim the clocks, and they
will be disabled, which is imho a good thing. This case wouldn't be
covered with an attribute at the clock node, because you don't have a
link to what device/feature actually uses it in the system, and so you
have to make the assumption that it will be used. And you will end up
with clocks with a rather high rate running for nothing.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--4HtkOwtDb9iYfHNA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/5ULAAoJEBx+YmzsjxAggAoP/1ifZHyaW/kidZZ+0Omy0Glv
CC9R4UiaPNeKGkF+1sEkW+PaN+9Zp0rXbm0pscPo9ArTksJEE/brpcOF657egl/6
k0/F+g/FFRmrXAH1qFXcGB+nhB2+dKmUlU3860NLW18fA2RIUPLdg49IYT4DZqCb
SHJmscONduh0T+5AHcXITsUAAXBBlJHE6p7aacHZTpRHMneXLbLecMvWE1yzH+nU
Uso31J42wW0MdyB+tb5z4vXGG9KE5kAlFkpK5d3dztbSBdyRv5jRxZJZrj8uSDxE
sxX2rdFXiO3ezTGFAGQR54kXdU64uPC3m42F60FqGGKcSmlc3tXZE85B/HjC8PA9
rBOd5weGEIDF0lO0nz9zFViSjWNAp9PgP/V+Vy5tVk975OtJ2RMcDSWnV6xGdKRL
7RW4dvJlmikN4AqkQ3TIATXdAcVM3mji1bkG7Oo0dkaeyH97SKICRsC3T5hOH1Ln
MrkGpiceyhA4C7qsli5RzU0CeWxZxUU07zCTEB2iTYIlqVZk0nxyDTDnAIp6VpJw
Sp/lAjdSa/VEJCI2ZVlSNJYiAgZ5Nh7W9xojNN7axQijsxO4LAQ5TQV2I70K+4xi
8ja+FZYlWfiFuajavf9S0eaKY7zJC+8mII34Kl9WrxDc8OKUs64kL8KGVyqtWZPl
hhtEK32VdK/zI9uceXL6
=yFSY
-----END PGP SIGNATURE-----

--4HtkOwtDb9iYfHNA--
