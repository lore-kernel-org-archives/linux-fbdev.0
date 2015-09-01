From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Sep 2015 10:56:32 +0000
Subject: Re: [PATCH] video: fbdev: Use devm_clk_get
Message-Id: <55E58460.3050503@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3aokho5Le1mbxOXmkTVhdR6O7M52DmNbV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150818032840.GA14566@localhost>
In-Reply-To: <20150818032840.GA14566@localhost>
To: Vaishali Thakkar <vthakkar1994@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--3aokho5Le1mbxOXmkTVhdR6O7M52DmNbV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/08/15 06:28, Vaishali Thakkar wrote:
> This patch introduces the use of managed resource function
> devm_clk_get instead of clk_get and removes corresponding calls
> to clk_put in the probe and remove functions.
>=20
> To be compatible with the change various gotos are replaced with
> direct returns, and unneeded label failed_put_clk is dropped.
>=20
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---
>  drivers/video/fbdev/pxa168fb.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Thanks, queued for 4.3.

 Tomi


--3aokho5Le1mbxOXmkTVhdR6O7M52DmNbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5YRhAAoJEPo9qoy8lh712EgP/R5rclm6L35n/vo9GbV0xDY9
0Byyv0bjsKJZlaX68+Wj5PAYsnH/HwDVvaMoxuclEX/KnT+62EIc7/GeGM2QaCXF
cAJFyxMjO/x6MEkl9RFiDnc9HoSk81m8o2DK3CXNXiN/UJgO6EaJQzASvTf8FmEy
fCcfJyF1v7alHYcPoRqTnDtvkf77K+sKx9fpOhUPNftB9Za9rLkxsZLmckYiAxsN
ZRrTverxV85jV+HrYlAzOk2VdDsUliiXZ7ArAJyjMoE3mtskblgbH3jvB/0JYKxQ
swl/fCCIf/mjaM9eresJ7rKP0lQfiwjJoM01wfFRnfDWLSykpyNslJTXs/m3JVkl
7sUeZWv/sNRcDudqZDjAqa3W44HuVnt4flJFRSiTStl9PkUvytBS3B0Gy8jTEOD7
YPDrtlyID4Xg8x++214Z20jHusggZ/d1r/XdjK1nbZBlVuKrrz3+lWFiLJUhNajO
UHDAYyKYj37JaP80JHYMJUxfHMC5NCI4OWTp0dJY/r83mmlkruV+vW8psFU8PR5i
ZJROTapL/GI2LtnWODxwnIYS+WLipr1yZTJ7zfEjt1FSpfADc8PD0OHV77EtBPk1
RWCXuLLxLI1kYErWWA3VbHp9rd+ZcOASK3SQSpHPiF97QNNxCu1fa+z4+8zqQUnn
XtdWLk8SbuukmkaeBqgk
=a/eU
-----END PGP SIGNATURE-----

--3aokho5Le1mbxOXmkTVhdR6O7M52DmNbV--
