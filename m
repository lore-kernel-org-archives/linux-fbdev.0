From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:08:45 +0000
Subject: Re: [PATCH] video: fbdev: add missing \n at end of printk error message
Message-Id: <71d17288-3772-44ae-46fb-024ce9972bd3@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HORiAA8wqQg0i35fIa4aSlhT5NSeFqH5s"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160912102421.25926-1-colin.king@canonical.com>
In-Reply-To: <20160912102421.25926-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

--HORiAA8wqQg0i35fIa4aSlhT5NSeFqH5s
Content-Type: multipart/mixed; boundary="KTlUtUNNqh5KSB07xRssLtvCHFS2QcpHW";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Colin King <colin.king@canonical.com>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <71d17288-3772-44ae-46fb-024ce9972bd3@ti.com>
Subject: Re: [PATCH] video: fbdev: add missing \n at end of printk error
 message
References: <20160912102421.25926-1-colin.king@canonical.com>
In-Reply-To: <20160912102421.25926-1-colin.king@canonical.com>

--KTlUtUNNqh5KSB07xRssLtvCHFS2QcpHW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/09/16 13:24, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The message is missing a \n, add it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/video/fbdev/s1d13xxxfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d=
13xxxfb.c
> index 96aa46d..6a271d8 100644
> --- a/drivers/video/fbdev/s1d13xxxfb.c
> +++ b/drivers/video/fbdev/s1d13xxxfb.c
> @@ -929,7 +929,7 @@ static int s1d13xxxfb_suspend(struct platform_devic=
e *dev, pm_message_t state)
>  		s1dfb->disp_save =3D kmalloc(info->fix.smem_len, GFP_KERNEL);
> =20
>  	if (!s1dfb->disp_save) {
> -		printk(KERN_ERR PFX "no memory to save screen");
> +		printk(KERN_ERR PFX "no memory to save screen\n");
>  		return -ENOMEM;
>  	}
> =20
>=20

Thanks, queued for 4.9.

 Tomi


--KTlUtUNNqh5KSB07xRssLtvCHFS2QcpHW--

--HORiAA8wqQg0i35fIa4aSlhT5NSeFqH5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6ikNAAoJEPo9qoy8lh71nyUP/1XibEwdlgF5UZQk+SjAt3dL
OFESrStPnffJG0VOY//EYTrLNk9RxGkEA/2OlwbzcU+WrUDaNH5+D8o5DuRcrxCN
jj0pMksnqnnNzAjDJkbQ2JJeNyGAgzSnydBrbNEsmmm+czXU+7dZ+xIoR6HZe/W1
V6oeFqfr9ABh1fadLyM/tW5tMSOkWMt9qy6aM91l3PcgdRDsI8cDFmn612CeWIa/
QNOsfIre4AvsLgxII+fdUQLFBh01SSQtlIkfhm50OZ76cikp/X8Lcqf2U/+rBtP8
AyxmJxgFHK2ttemCU4JAFxDjBbTPpCg+2MvQJuzfm48Yp4Yg8lScUeB+FG/WtO2w
58iqAAxSvQzgSyTli9E3gIE+0sYxu7UYgpKqVOYeD9roVw2VIBIxqmWmDFgku3QZ
sGiqcpG+I4yr+4lEuDNcCRuGXDaox8dLYbBHaCRBlRJfiXGfOfsCUhEid61nL1Lc
X+8JqAZQvUjsw8FlR220hRU+1kQa3kzsi044jChdhIirQb9h1vPrFqwftGZbDMkE
P45CRVOdKqk+iiOw5oDt1k0hQFzKWjdNQEOgO7V0avvALzL1MgABORahlzUu6NCz
CPhqU/bNGPZMXoCWX50xkRRyRpt9T5NWJk8b4rLkA7Z6kNw61mLGuiE4yzFoQqVw
XxgV80d28rYCffOXgA+z
=1KRR
-----END PGP SIGNATURE-----

--HORiAA8wqQg0i35fIa4aSlhT5NSeFqH5s--
