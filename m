From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Sep 2012 06:54:09 +0000
Subject: Re: [PATCH v6 1/4] Runtime Interpreted Power Sequences
Message-Id: <1347519249.7471.42.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-Z7zQN41Yy4VWSEps7HLu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
	 <1464760.6eqxJ2IzZ2@percival> <1347517377.7471.23.camel@lappyti>
	 <2689722.93BQTh4lSC@percival>
In-Reply-To: <2689722.93BQTh4lSC@percival>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-Z7zQN41Yy4VWSEps7HLu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-13 at 15:36 +0900, Alex Courbot wrote:
> On Thursday 13 September 2012 14:22:57 Tomi Valkeinen wrote:
> =20
> > However, I fear these board specific things may be quite a bit anything=
,
> > so it may well be pwm, gpios and regulators are not enough for them. Fo=
r
> > example, there could be an FPGA on the board which requires some
> > configuration to accomplish the task at hand. It could be rather
> > difficult to handle it with a generic power sequence.
>=20
> Right. Note that this framework is supposed to be extended - I would like=
 to=20
> at least add regulator voltage setting, and maybe even support for clocks=
 and=20
> pinmux (but that might be out of place).

Yes, that's one concern of mine... I already can imagine someone
suggesting adding conditionals to the power sequence data. Perhaps also
direct memory read/writes so you can twiddle registers directly. And so
on. Where's the limit what it should contain? Can we soon write full
drivers with the DT data? =3D)

 Tomi


--=-Z7zQN41Yy4VWSEps7HLu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUYMRAAoJEPo9qoy8lh71/G0QAK/iACEID25N+9nv22F94xd8
XJaD08QNPvPVBn6i2ImESx9GyIC0MW38txdKcNLWsoEmxiTTUiHZt9ORH5uihGMZ
0etZRUzuFZKgYLXfpMR57Np+23j55w51vYYjBsmrRooDsWxdcXO6CDTJQEzVctya
SJg4LjH/HznrwMsSbtFsmWEO2RIO9ukM4kHqTCRgYOdVfmRP8il/rpMyTBCneZ2y
qfEHkWIUtwmdDuzOj45c8G0apugUmb0eBGai5xc7PkXng5zfveZZNiBSlt4Z+CQ5
C9+PElyF+6NOEtHV1J0OCz3njOJnGGUjqPpoaP5SSSRKtqdzh5ypmM59O9SWHx08
AIaWBZkbctf21EWyRoLsXKckn2JC9NUR7qCNyOTLbH5wPwXdhA5o6wehuZMOTNk/
AsGpl0W/fL+sxZ9OerIYCZhiLpIO28pA9X1TuUOEsPqFjod1CCgKVrm+xwephZn1
VuRFOAYTYf/OYo2ahcSxZ9+s3q3vkCQMsiqdtFK7TaLE7YdTPDGQBKHfEzSICIeQ
DLvmaldw9MuhwsxF+HAtzdIUlzwtJ2UfIcFNoHY57iYCf8lrfbV2DdwL4f/FCk43
lhEeZryEkqDhnLCEw8LdjkxDY+o+8lcm1uY6YhG6dNtFpeMbbHR24p8SNtAZ0lZu
exN3o8jW2fuTRlnisslK
=deQn
-----END PGP SIGNATURE-----

--=-Z7zQN41Yy4VWSEps7HLu--

