From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 07:54:31 +0000
Subject: Re: [PATCH] framebuffer: disable vgacon on microblaze arch
Message-Id: <55D587B7.6060902@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7Qum51xDrxStkga8bhU6inKdN9x5NE1cI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <87d20u5dji.fsf@gmail.com>
In-Reply-To: <87d20u5dji.fsf@gmail.com>
To: Nicolai Stange <nicstange@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--7Qum51xDrxStkga8bhU6inKdN9x5NE1cI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 17/06/15 22:40, Nicolai Stange wrote:
> Fix an allmodconfig link failer on microblaze:
>   drivers/built-in.o: In function `vgacon_save_screen':
>   drivers/video/console/.tmp_vgacon.o:(.text+0x8fc10):
>     undefined reference to `screen_info'
>=20
> Disable vgacon on microblaze because the symbol
>   struct screen_info screen_info;
> is not defined for the microblaze arch.
>=20
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>

Thanks, queued for 4.3.

 Tomi


--7Qum51xDrxStkga8bhU6inKdN9x5NE1cI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1Ye4AAoJEPo9qoy8lh71k3sQAKthM7s6TaCLxM+7QVXtTmtH
wfxyvNJOcIQY+/T7IV4v7AH4bmKhy3ZWWqSnyBiKJC+SlM+/NKp0PSWeebd7cKjI
kXOYGk0sHpp8TFkLi3me0i8SjLV/RE4xWTPIjU3E7eZ2P1wTBESp8Dy4IRminWz5
KO20PrqpsDzTVbSAhHJNh1IzwIIGpZ9xDkLy5XMdS50r97dEMrOAdTxs7KQHqI4/
qp1BLcokY7klcD5evu4hYFaHgsHf+HKOcxTjCLU4qfR1cIO4wjl9CY2+TwzrRH7H
bUC23mUhVXy9gbORUUo+B6b8NPp6Z5RNP+I6ju2Vpr6W66ZA09y0BOHLwnzHdtJl
alfGGKd/eWWtjINmsCQf9Le9bD7HmkqgPzqS2OADXMyKrxbSD/1FrRvQDgos8/GW
NY8ZVUO+BI4GdKj4Aw060wcjEDzkd/BmLadQpXFqi0hzzCIuEQlJxdvQE1C83YVv
f5EEECuwwhXwutWKrM8VOg/eukEGYS66ZD5o2EpTxOXfvvCxougxNoaRv84FqXaq
GKhK21AZszSOcetu6BQwybtoRCNSvV1dk3OBnv+GryGbnK37OZ5YiQFRQU6wQmZm
yT6rApM7cRDL5F4vX0coAKI0DriQzQh28iCb8Cq0h/S9dWmxl1yN1hinfppvJliB
Jo5R2J1UBvWWqrA/NrXX
=Gigy
-----END PGP SIGNATURE-----

--7Qum51xDrxStkga8bhU6inKdN9x5NE1cI--
