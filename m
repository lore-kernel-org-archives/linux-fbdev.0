From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 18 Apr 2013 03:40:08 +0000
Subject: Re: [PATCH 00/33] OMAPDSS: platform_enable/disable callback removal from panel drivers
Message-Id: <516F6B18.8080407@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig68FF7CC488801802B8F2A4F8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <20130213164647.GF7144@atomide.com> <515C2058.8030402@ti.com> <20130403154645.GV10155@atomide.com> <516BC897.5020802@ti.com> <20130415212022.GP10155@atomide.com> <516CD17A.5050403@ti.com> <20130418003419.GB10155@atomide.com>
In-Reply-To: <20130418003419.GB10155@atomide.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig68FF7CC488801802B8F2A4F8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-18 03:34, Tony Lindgren wrote:

> Just one request: Let's do branches like this early on before -rc6,
> not what might be five days before the merge window potentially
> opens..

Agreed, it got a bit late. But the branch itself has been stable and in
linux-next for some time.

Perhaps it would've been better to merge it to l-o earlier, instead of
me pushing it to linux-next via my tree. Any possible found problems
(there weren't any this time) could've been fixed with a new fixes branch=
=2E

> I've pulled them into omap-for-v3.10/dss and will send a pull
> request for Arnd and Olof.

Ok, thanks!

 Tomi



--------------enig68FF7CC488801802B8F2A4F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRb2scAAoJEPo9qoy8lh71QAYQAKpqTpp8IcTWe7BvASWjyvu3
lTlB0i4YXRFdoILyFFYL9LbSY3lEXsHDytRvyoonnu+Lvpthli/Hen0u3MLFzoq3
os7reHf0NS6SIpl3AJrh/i69N4ANrXPmFumg74OdpV1wtxQwu5/DAJZUjhWb6K+i
AHhqYLs/fmJS+X+5Wny32eXdXdzJ5FhTzXxOd9vdpuH6KHGayZhcq4piSsYt28gn
3tpW1Ay1WoOuycOkaaznHluVjkKJFC95U9sd/2RzNBe6oqdYDAo5Z3vX4rOGnLrJ
c+PnutwKE+prq6ARWHCVOF7jdeChp1NmBr9+uiLGSHnigL6e/mEm8wX2g0vktxPv
qCtosWmtAImZ/+lcS2W/+ZOBA7HjuBi/9MxuevD22LrJoMCWBhIRSQQ9DjxvE2xW
hBcNGdsqFhYKMYl3yanMYThS4Pv4UKAu6jL6qSWQfBn3O0z5f5/hV1WflIWrx77K
yTU89jI9CRDbRPXHNGDq52nv0cyyjByVdxuRPrGUJ/eeH4cRChUl8gLjsGU/q91j
TZ3g86lZmnwPbYQPvG2p90fdsivTbQgXcH/Gt+FHIPcYoJrO0ZrM2HkSZvyRBiFk
4i9uKyjlTIBOf0cJs8iSTlbeacOuFlHf+8LalzFb4CmVx7DH8fpasHZPYnVUk8ut
HBQNqkWd8Sc8E1GmnEEb
=1Ll0
-----END PGP SIGNATURE-----

--------------enig68FF7CC488801802B8F2A4F8--
