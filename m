From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Jan 2014 12:05:54 +0000
Subject: Re: [PATCH] video: Replace local macro with PCI standard macro
Message-Id: <52CE90A2.1030705@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9buUbBoCl8M4oaE3IVr35akXABkuAaqDh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386242718-24372-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1386242718-24372-1-git-send-email-wangyijing@huawei.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>

--9buUbBoCl8M4oaE3IVr35akXABkuAaqDh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-05 13:25, Yijing Wang wrote:
> Replace local macro TGA_BUS_PCI with PCI standard
> marco dev_is_pci().
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/video/tgafb.c |   16 +++++-----------
>  1 files changed, 5 insertions(+), 11 deletions(-)

Thanks, queued for 3.14.

 Tomi



--9buUbBoCl8M4oaE3IVr35akXABkuAaqDh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzpCiAAoJEPo9qoy8lh71wQEQAJY4WqEr46216E8rKRCUDnsM
tIUPWPDbno6AjGfY4J2H1VeVc8BhcJ/i/dJkLgoG1LTzyB0b9+Db9+RXC13u4SWb
heXyfJd32BDIpbZGwezmvZckr6BnU3WFwTz+gXp9QQy+PvjijSqI8OrHThTqoPkH
IiEekIi+9WwlxHdeNmlHicxaIU1UUIVlpAdRx/q66bfCiomCY796NWJUM1i5wlzH
klR/rHGk/0cJ4l+prfLukMaX2B9wq3BzD+lEcD1uQs9CunOckA7kQpFTXfCbGG0A
/s+/ULiLQjX2payAIxJGCkv78MW8YBW6VHpUl7Yyy9HI1MsfzUWhhws1dF/o8gE9
u/E9VmcQwa5fRhz5b5gTlI+eDEvWJkRfRWFLzx7gJVpXQhrnmmiTveEv+oAdtmYn
od/CgxynpNZAc39LKjdd5f/Ly5lqqHIx+zMh7nKLe08vX/hlRzlSAU0ZTxq0RlyY
PVju8mXM9jOaiPvejAmM5t9VkiOdBu9p2zGPP4tg7CjKjGG5eZTzrT4vYSk0kQ4L
9LWjnUBbOxtv0/3ob79Bgtbg5eTrR7hv2FlhltDRLKbe7apCGkF19vWOPCg+Yb4t
p0F1pLFNUGL8Cu35E1YkX3R7lzgdhPyhsTuyF3t6O/pX+iZTKMbCvBCnslpTJiA/
/Y0/ln0zl28ARrtD9eby
=b5fc
-----END PGP SIGNATURE-----

--9buUbBoCl8M4oaE3IVr35akXABkuAaqDh--
