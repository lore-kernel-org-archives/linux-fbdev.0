From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Feb 2014 08:43:21 +0000
Subject: Re: [PATCHv14][ 3/4] video: Kconfig: Allow more broad selection of the imxfb framebuffer driver.
Message-Id: <52FDD729.60405@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AKKMrvRWbfdi6T02NbS00J3CQBrlEEWEM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390410577-22073-1-git-send-email-denis@eukrea.com>
 <1390410577-22073-3-git-send-email-denis@eukrea.com>
In-Reply-To: <1390410577-22073-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org

--AKKMrvRWbfdi6T02NbS00J3CQBrlEEWEM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/01/14 19:09, Denis Carikli wrote:
> Without that patch, a user can't select the imxfb driver when the i.MX2=
5 and/or
>   the i.MX27 device tree board are selected and that no boards that sel=
ects
>   IMX_HAVE_PLATFORM_IMX_FB are compiled in.
>=20
> Cc: Eric B=C3=A9nard <eric@eukrea.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied for 3.14 fbdev fixes.

As a generic comment, I'd appreciate if you'd use normal formatting in
the patch descriptions (no double spaces in the beginning of the lines).

 Tomi



--AKKMrvRWbfdi6T02NbS00J3CQBrlEEWEM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS/dcpAAoJEPo9qoy8lh716q8P/R0qmcBsGS8xpqrltM5XHAq3
Hme/lbWQuqiqo8C1zmWNvHKVxdRfi07PWuoM/aLmPWZDz/IOw3UtpdAYJ1tKbX7K
iWq8ewcV7qszmY99szbkeAbpOx6/PRBjHfip+z2AptwWnmcxwZTGJnCZRQYtAnGq
NwvGHOcnz9yRjZGEEaqC8g7mQoIcpIFVyL1mWdzuHehaUs02XzR0Cs//JCH1zxmr
vb9w5aR0o9aqDfABAMA79VF5YTcSX+zysBIcQL87x++k0jTS9RGDznYL88wCZCdd
oimyyMs2deD7giwHVKuFCyZzp74oPZTJEJKzirxqc8DQ5FQkaASkQdMG4lv6z4pp
ZQjz8HfQ9vqLF7DAC3+NUC/4qZs+j/76e9zrbLzSgaKcQhOxXpUehrq+CblBZ/Ai
0664iy7ZN3nP4a1yRD6HI2Kri7cT3GZJ3skxVvAXuU2PLNoH2bAVBVPtS4nZdQCX
bKDv+AfgnQaqH0E0as5phe9Pf0JpRjuwgywatpuVn5VcnkNLeF8Z0AzBnpSWNa0s
LGZDvzMSM4ga1zX0yY/h3qNDbtY1ur9XIPb/Vy8mEiN66TUlA2o5W5dMpw3Yj06c
6g/esOQ9LtiC9/oSC0sA1sblNG/vtu9buw2W4PeZrFrn2tl1K7HT9uWj80W8CSUs
Y+Rj10T/3H0mAYLoiJqK
=7hr4
-----END PGP SIGNATURE-----

--AKKMrvRWbfdi6T02NbS00J3CQBrlEEWEM--
