From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 May 2014 10:47:30 +0000
Subject: Re: [PATCH] video: of: display_timing: remove two unsafe error messages
Message-Id: <53749B42.2090605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Cx58uqnAVkV1L595qEht0nb5rN6agSCmk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1399985901-30756-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1399985901-30756-1-git-send-email-l.stach@pengutronix.de>
To: linux-fbdev@vger.kernel.org

--Cx58uqnAVkV1L595qEht0nb5rN6agSCmk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/05/14 15:58, Lucas Stach wrote:
> The error message would try to dereference the pointer that
> just has been tested to be NULL. As those messages don't
> really add any value without the info that the np could
> provide, just remove them.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/video/of_display_timing.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Thanks, queued for 3.16.

 Tomi




--Cx58uqnAVkV1L595qEht0nb5rN6agSCmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdJtCAAoJEPo9qoy8lh71FbYP/0v0RcfSAvL43dXPKkI1Gx+u
E2apRcnW2yBHvnELjEyUKK7o//8afyuTFZuRarAg+RVj74X3pt3evGBQPmPNKexI
GUFMI5GR6So9u5TDJor5/ODzK5DUUGd58423N4WX1/MxR2Vb1gQ5zM+sKvhHvMNG
6QMSUz9jjdtkxy8Dbo5d76JPt1rw9+8h2vsUJqjv/PS45AUfBZly2EpQoTIfdN6v
9yVl9LgKvm1kAPs42rBJE4qKzrw8vQ21rPY5KAsD76TdaF15VAYW7tAPVhNdgTpH
6aOCIZf1aZjcnu65JjL8X9XgvFyAhPoRJlKqQpDdsbDS3xMVAaTxGqK2IskVdp0h
J9gAAfCg9cE2K7zvc+srPE5wk/enxovmAKbYBZU6d+oYXXopsqE+oMH3OEBZYXPB
22SfJ05/Irr52hGJODLVUetXSmDTWzsS0yd5UJMeKw7YInOXmR278xvdm3k2ypN2
iSyji5sTnenffnEDM2I6gQYb9EydxLjKpBdq/ue/8C+60o6GTnAZ5VEwaWUwO4m6
4Q1NRssIf9b8WlS4T1nbTlmUQDXZoZRyGJ36wN+sFCjf8uBujXhSyfeLI6Z0PUkj
fPYCyx9cr3dlG+gxqMLfSXJbFF/8U5Tx14b/fTotNZ7km0Blaos9PbwkBwv+AeqP
yb8DCAr9Bk1oD2upS3y6
=WtMV
-----END PGP SIGNATURE-----

--Cx58uqnAVkV1L595qEht0nb5rN6agSCmk--
