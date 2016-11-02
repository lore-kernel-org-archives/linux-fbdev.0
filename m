From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 02 Nov 2016 08:22:41 +0000
Subject: Re: question about drivers/video/fbdev/auo_k190x.c
Message-Id: <c63e1332-36a1-2c83-7c59-708e7f85d77d@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ehlWJIKWwthrDwTbFhIF2OjBXWrC5djbs"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--ehlWJIKWwthrDwTbFhIF2OjBXWrC5djbs
Content-Type: multipart/mixed; boundary="74rUEpl0iVRn9gsMT7hVIvtnxwPht3dPK";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Julia Lawall <julia.lawall@lip6.fr>, linux-fbdev@vger.kernel.org
Message-ID: <c63e1332-36a1-2c83-7c59-708e7f85d77d@ti.com>
Subject: Re: question about drivers/video/fbdev/auo_k190x.c
References: <alpine.DEB.2.20.1610282231170.1999@hadrien>
In-Reply-To: <alpine.DEB.2.20.1610282231170.1999@hadrien>

--74rUEpl0iVRn9gsMT7hVIvtnxwPht3dPK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/16 23:33, Julia Lawall wrote:
> The file drivers/video/fbdev/auo_k190x.c contains the code:
>=20
> static DEVICE_ATTR(temp, 0644, temp_show, NULL);
>=20
> Is it correct to have the permission 0644 and not have a store function=
?
> Should it be 0444 instead?

444 looks correct to me.

 Tomi


--74rUEpl0iVRn9gsMT7hVIvtnxwPht3dPK--

--ehlWJIKWwthrDwTbFhIF2OjBXWrC5djbs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYGaJRAAoJEPo9qoy8lh71WY0P/jBAgWKkJeTbK6Qbyxk2Z1kW
0Pz8hPbZPNK0nFRdZq/8IG4TS1tJeXZ1fA4QwQqzaHcRT8lDyUfiBGRAmCZT/IYA
RLuDTHWR1fWrO/rOyq3Y/KDCwG/e8VJ9YCtcwCbJ2zcjEpWkQyk/rMPfc7O76g3U
lPl74cfp/JQ7eyr4qOJSBze0SFJFJZana+OGjhZ7vRDmGbBj+sIbC5O8g8hAgkGL
XrYMcEcEXuGgSD1ManE9fx2Q0+ZS4b9H2ptW5kIJpaMyBGYTAQ4rsYI/79+X9Pei
tXp9QWsSMP8dUwoIVnayCp5YQIHrgh8NInrFzyLrNbnrTNZp/Lk5mLPu2GhBCNOj
33jq0i+L26XSJrz7ZNvuEKgg5SmEQXSJsPD1URio9GwcnVHVb6y9NFok0rpU2u9q
RkEayQwBq25L2YN7aPwSWi/hpydOSJCZS5V/MlNiDgLkqJlfLyXXOABnqVOH60jt
z4LufygzjeVUblg4Ld4t46Lx5u4u7esAuRqTmri74/TxpdEi9Hri/v25yQP9h86+
BzvEB+RrOzYyb59uTmXNQIxPTqLK8vDu87Ieaca0scSFgnxlLmIBzrG9V80kMcWD
gYYLLFEvKREWcKdT6qZ9NS003J2LSEgyjL3BVVQO1x/Ap3KgiA8pQCceJqhEiLYN
Kwzx3PUbSmr7tuRFyY36
=y4w9
-----END PGP SIGNATURE-----

--ehlWJIKWwthrDwTbFhIF2OjBXWrC5djbs--
