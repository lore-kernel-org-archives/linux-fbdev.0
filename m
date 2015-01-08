From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
Date: Thu, 08 Jan 2015 09:33:31 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <20150108093331.GO7853@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GTjM2GI4zMe3xHZ5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
To: linux-fbdev@vger.kernel.org


--GTjM2GI4zMe3xHZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 06:30:01PM +0530, Ssagarr Patil wrote:
> > It's probably even easier with SPI. Have you considered reading
> > include/spi/spi.h?
> >
> Thanks for the pointer, I am using spi_write() call and I see /dev/fb0 no=
de created.
> but when I do echo "1121"> /dev/fb0 nothing comes up on oled any pointers=
 on this ?

You can't use it like that. It's a standard framebuffer, that is
represented as an array of pixels, so you need to use a font rendering
software if you want to output some text.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--GTjM2GI4zMe3xHZ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrk7rAAoJEBx+YmzsjxAg1NYQAL00eUyg4KVf1jhL0hxLS5XC
rpxAEOOCXPkTFsVJtzwAhR9znkBo0oZyszhHOJq2gkXE8+aTsahWZ3KDgOrNqeIE
C4OFFI8MaJudaP0qyPJ1k+YrSdQpPvg/AznjYs7zc/sfX3SLSITaESVa/26GWih5
yop28cxkRZi6qs4wpG3NfWgt8jyIMcE3OGYD9gzPlusK09n7VNoXd+khoATWRAMW
EQ+wgMiPkdIRPNpjfB8dhdxJ7STl+Un4RBoWHZFfSQJ8y8FHK9lfys+zrXjwZMCa
zBDJztVu/j8DNY/wYeo6b/Z7zE9BdnYPCLQtKUypjj3/gWF2hhSNZTWaBF7pNV0X
pjm96dbf76bMF1F30n6nKEjbk8TQs2I6FDVwOGZtD3qPHe6OxPLK3HiJmgo6cX3y
JN3IxAvgArEHW1mCQ7Soa6hJNgO5GytiV1NgaTjz8IBCf5fhu+eiBw8U6HKgQWNB
a6o7YRYuQYkgiHTwHaAhH86tzi9jEP2T2z3Ige1ggogdskOHEhOszHzk2KxsU7+9
ubfILmgyICptRHPSdCz8aGgJ2V6nLgWKkgaFWEjENCcv/kuSQCiW7RQhVdhvjtRS
XzaHW1ilAnD8G6Ks/9vWWcriBvYOloLAT+9Q220+javlkZ9rUtxX3CVdFOmXQ5xR
IX6wgpcQrzBMBNpE2f2N
=Fzei
-----END PGP SIGNATURE-----

--GTjM2GI4zMe3xHZ5--
