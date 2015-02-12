From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 12 Feb 2015 16:58:40 +0000
Subject: Re: [PATCH 2/8] fbdev: ssd1307fb: Unify init code and make controller configurable from device tree
Message-Id: <20150212165840.GL2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="W/y7qBwfEQL/2otS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-3-git-send-email-niederp@physik.uni-kl.de>
 <20150207104225.GM2079@lukather>
 <20150207155933.4f1d0998@maestro.intranet>
 <54D62D09.8080404@tronnes.org>
In-Reply-To: <54D62D09.8080404@tronnes.org>
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>, linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--W/y7qBwfEQL/2otS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2015 at 04:19:37PM +0100, Noralf Tr=F8nnes wrote:
> >>and the DT itself should not contain any direct mapping of the
> >>registers.
> >>
> >I think I don't get what you mean here. Is it because I do no sanity
> >checks of the numbers set in DT? I was just looking for a way to hand
> >over the information about the wiring of display to the driver. How
> >would you propose to solve this?
>=20
> I have the exact same challenge with the staging/fbtft drivers.
> I have asked about this on the DT list a couple of days ago, but no answer
> yet:
>=20
> Can I do register initialization from Device Tree?
> http://www.spinics.net/lists/devicetree/msg68174.html

The DT is just an hardware representation, and should not contain any
logic. Any attempts at doing so have been failures, mostly because
that kind of construct are really fragile.

What would happen if at some point some new controller pops up and
need to poke a GPIO before every write?

Every driver should contain all the needed code to initialise properly
its hardware. The only exception being stuff that are volatile by
essence, like bus addresses, GPIOs, etc.

In your case, using (and maybe extending) the generic panel bindings
look like a better way forward.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--W/y7qBwfEQL/2otS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU3NvAAAoJEBx+YmzsjxAgdHUP+wcfgjbPcOfNSUHJiv3c4Poj
qQfOKYfBa5u4HDYtclLiOY7B8QjzvZDpfp4mEn+5TbAyjBCdGUTZhss6usAPxrbv
epVQzVryF1Qf2ihZhWS4MOMC76kFuW/aHW3CwLPFpuo49WrcHE3tZWaapPfSXjr5
Mv7zcR9lpc8vCLOM1Yvgxvh8cKMCAZ7i2mpcc0gxVRgUkuA9LQS1pj1RqenfTH7t
np4W72S/F8chS5C7IsnEbc47sQxtQakThcaKfp++HoxD63epTf2ZyRXNyng6Qy2X
Ebw1ySrywzXN1396Pm62+0zB+9dP6+k2VAaQT+1IeLCQ1LdFFh7U1jPQdCVObh70
pQBAhqKhjYdXvVeXbm3UbKnGLRqDV9Bgtz72kXybbuJ/yugsvmV3gpJI0q+9fNA6
jjJVWApm1jVwJRC1HZr55p0eWF1I9WEcsVfeJCaFdeObWqxSQ07watP5pCQCg3Oj
5oZViKBxIG35J25ZkxAHP8uN9DvaW4r4PHIqc3SDnU8Ntm/V6bWGu+K/k37jXIjq
9VIhsitzRrCd09I6oqQX01E7o3K1fX/TTqVQnZZQIgePcpRfDFVY4aL3L9CFV+z3
+DXkK5HXhAEeU0t56aJd89Exe0E1h0xqAfQLollZYmSCFOoMu/jICJfK1yXLaSYa
ZhagnojoX+N46snCHrny
=er2e
-----END PGP SIGNATURE-----

--W/y7qBwfEQL/2otS--
