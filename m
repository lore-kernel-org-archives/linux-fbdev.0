From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 09:37:50 +0000
Subject: Re: [PATCH 1/2] video: of: display_timing: correct display-timings node finding
Message-Id: <5244006E.1030604@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="s7FNfRmFxufqNwg5P0ibwpEpPvkrCnb1m"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380109892-13040-1-git-send-email-a.hajda@samsung.com>
	<1380109892-13040-2-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1380109892-13040-2-git-send-email-a.hajda@samsung.com>
To: Andrzej Hajda <a.hajda@samsung.com>, FRAMEBUFFER LAYER <linux-fbdev@vger.kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org

--s7FNfRmFxufqNwg5P0ibwpEpPvkrCnb1m
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 14:51, Andrzej Hajda wrote:
> of_get_display_timing(s) use of_find_node_by_name
> to get child node, this is incorrect, of_get_child_by_name
> should be used instead. The patch fixes it.
> Small typo is also corrected.
>=20
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/video/of_display_timing.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, queuing for 3.12 fixes.

 Tomi



--s7FNfRmFxufqNwg5P0ibwpEpPvkrCnb1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRABuAAoJEPo9qoy8lh71lOEQAKG+NP/82T0P3Caqaej1njms
9+vVyP/5xIL3XrT9SY9YwurZDT/ptu/CkmGjEEAXZi17qF9njjbBYshq0qe9RleL
B/kiu/XIvABfQiMYzb62lTdSPOqjNqivs9kDACf4gbLbaBOFCgmA1e92KAGbZaWr
eqTNXMzT0Uu/IDNFEDZxIIA2VFh3VlWNyxF0+EpN36UJMo4abwDtzZsUMfOerfFB
LTkDi3GuFvNODUG1eZ1FaVQJoBT3Lu0orUD1cf3oOPwYtvxQNLd3UJUHnOMM9UvM
DI/26eWrrztisuZR/5TZQH5JR9VPzdMuhnZR1mG0Ne8rMcGEgEpYSgfiN/flULmk
T9/nNt2cZGHMSh/XoLTH+xV5P3ON63CE/4YZnHrzKNKlI9VlslNOZB9B7a0fUSuC
4CUcm+cfWfgSn5NhXXZDZJoCwR9mBMeqIB1e5ioQPg8JXikQd2oJ/EMOh/TgBJM1
nx2RTtfrWsLWwPmDwEPSJYbfPq4jGUtmwRL0v4y3vzBwmc6l2v3Zw/bU55TrEcvX
izUR61BiBaivzzJcm91Mif3qV/9GwSAQhOn7wOHQgB0pnKdmp+B5wRsyyyo93K+y
HAcRFcp18l4s6WZ4v3XqGGuVvwIWbN+R6eMP0pSWIzbI9YpSziKo1YhtBzH5DccL
OP8cEuftAbf/gxxzu6GN
=fAv7
-----END PGP SIGNATURE-----

--s7FNfRmFxufqNwg5P0ibwpEpPvkrCnb1m--
