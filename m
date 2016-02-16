From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Feb 2016 13:14:32 +0000
Subject: Re: [PATCH resend] video: Use bool instead int pointer for get_opt_bool() argument
Message-Id: <56C320B8.1070900@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="a7t8lONT4GQg9cf0nVB9xibfuufe628u8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455009512-26806-1-git-send-email-daniel.wagner@bmw-carit.de>
In-Reply-To: <1455009512-26806-1-git-send-email-daniel.wagner@bmw-carit.de>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>, Maik Broemme <mbroemme@plusserver.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--a7t8lONT4GQg9cf0nVB9xibfuufe628u8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 09/02/16 11:18, Daniel Wagner wrote:
> As the function name already indicates that get_opt_bool() parses
> for a bool. It is not a surprise that compiler is complaining
> about it when -Werror=3Dincompatible-pointer-types is used:
>=20
> drivers/video/fbdev/intelfb/intelfbdrv.c: In function =E2=80=98intelfb_=
setup=E2=80=99:
> drivers/video/fbdev/intelfb/intelfbdrv.c:353:39: error: passing argumen=
t 3 of =E2=80=98get_opt_bool=E2=80=99 from incompatible pointer type [-We=
rror=3Dincompatible-pointer-types]
>    if (get_opt_bool(this_opt, "accel", &accel))
>=20
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
> [resend because Maik's emial address bounced last try]
>=20
> Hi,
>=20
> In the 'simple wait queue support' series is a patch
> which turns on -Werror=3Dincompatible-pointer-types which will
> result in a compile error for intelfb.
>=20
> https://lkml.org/lkml/2016/1/28/462
>=20
> Even if that patch wont make it, this one makes sense (at least
> for me :))
>=20
> I'll prepend this patch to the next version of the series in order
> to see if I got rid of all incompatible pointer types errors caught
> by the kbuild test robot.

The patch looks good to me, but I didn't quite catch the above. So do
you want me to apply this to fbdev tree, or do you need to take this via
some other tree? If the latter, you have my ack.

 Tomi


--a7t8lONT4GQg9cf0nVB9xibfuufe628u8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWwyC4AAoJEPo9qoy8lh71L/wP+QEFzhQVljy3tFdXfMjsNBHM
lgQb+8aTCFS4tcq9O+OvvWJM+eP2C/zHyIxQSeP7agqiStpq5G7y+t3E1xLEoxF9
lWBbCJyaPK8KSXsZdkT4j0jsrS6D5wk8rWQR/GRs0TLY3HNTe49rNMfKAlJYFs1s
z+2stFhlZ/rB9QJ13sgGuOeVIKDt7zE5cUiZStMyTweX0is2rZ7Z8rkizrSaAIPk
RJsWDlSO3uoCMaVdaqV9aw3iAhpdyMKyp3TYpkSkOaC+NH/ebdbULrTXUDEQPxb+
zWKpylqZ7Foioc0Oz92Xg/6h4j98Om4HqONh9IyDtmq6OZhkQ425FsUp12CiPQQP
13LsSarn/D8Muq0noyzL5hCxsBA3ODaNY7jL3Qi+mGEjs3ROvzyMFZuY7cqnX0+R
6XMqEySxiAXbq4THM8eSX9iR060qd04uwQO8NFWpJgxu/9TZ3Kwf4H0wgG2if9o2
Hl9pBT5fa65jvHZCtcaWVQu3DQO04dNzBo3sn88zPr4leCQQ9zgYys9t2/0EJs/R
cyJ5GaQK3cVPf9RJA9/yqzQfoj19+OU9sqUpW5iVmuIEBdo2EF4yOG5P9DEgeRWY
XHSKfS8PN5nGnbpF3gpcCsuniNLqIhrclLCc7cnxQHkpZKCC23rXNQSaJGenV/wB
1koZvf+Nnup7zBTJla59
=3x4n
-----END PGP SIGNATURE-----

--a7t8lONT4GQg9cf0nVB9xibfuufe628u8--
