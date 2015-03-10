From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Mar 2015 12:18:34 +0000
Subject: Re: [PATCH,RESEND] framebuffer: don't link fb_devio into kernel image unconditionally
Message-Id: <54FEE11A.4080802@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tEHGBXK3vJrgoiLspTdTfncsGabi8Qgs5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <E1YSma9-0001JA-6C@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1YSma9-0001JA-6C@stardust.g4.wien.funkfeuer.at>
To: linux-fbdev@vger.kernel.org

--tEHGBXK3vJrgoiLspTdTfncsGabi8Qgs5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/03/15 15:09, Harald Geyer wrote:
> CONFIG_FB_DEFERRED_IO is defined as bool while CONFIG_FB is defined as
> tristate. Currently fb_defio.o is linked into the kernel image even if
> CONFIG_FB=3Dm.=20
>=20
> I fix this by updating the Makefile to link fb_defio.o into fb.o and th=
us
> go into one place with the other core framebuffer code.
>=20
> This has been tested on arm/sunxi and arm/mxs.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> Resending this patch as I didn't get any reply for over two weeks.
>=20
>  drivers/video/fbdev/core/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/co=
re/Makefile
> index 67f28e2..23d86a8 100644
> --- a/drivers/video/fbdev/core/Makefile
> +++ b/drivers/video/fbdev/core/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_FB_CMDLINE)          +=3D fb_cmdline.o
>  obj-$(CONFIG_FB)                  +=3D fb.o
>  fb-y                              :=3D fbmem.o fbmon.o fbcmap.o fbsysf=
s.o \
>                                       modedb.o fbcvt.o
> +fb-$(CONFIG_FB_DEFERRED_IO)       +=3D fb_defio.o
>  fb-objs                           :=3D $(fb-y)
> =20
>  obj-$(CONFIG_FB_CFB_FILLRECT)  +=3D cfbfillrect.o
> @@ -14,4 +15,3 @@ obj-$(CONFIG_FB_SYS_IMAGEBLIT) +=3D sysimgblt.o
>  obj-$(CONFIG_FB_SYS_FOPS)      +=3D fb_sys_fops.o
>  obj-$(CONFIG_FB_SVGALIB)       +=3D svgalib.o
>  obj-$(CONFIG_FB_DDC)           +=3D fb_ddc.o
> -obj-$(CONFIG_FB_DEFERRED_IO)   +=3D fb_defio.o

I think this change makes sense. An alternative would be to make
fb_defio tristate, but as fb.ko uses fb_defio, fb_defio will always be
loaded if fb is used. And I don't think fb_defio.ko can be used alone,
without fb.ko.

But if you do link fb_defio into fb.ko, I think you need to remove
MODULE_LICENSE() from fb_defio.

 Tomi



--tEHGBXK3vJrgoiLspTdTfncsGabi8Qgs5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/uEaAAoJEPo9qoy8lh712nkP/38cUxBsnQsroe4UnWDdZKbu
6WJoD2nVGz7Ne6P2r8kbAiy79OAR/YkBpLk6NShgbkCBDbKZhT6fqOTgbOKpYbRA
gmrhmUEiD3qJRIBgiCN1dFC3Ib+i+H4dUKQRFkpv+rFtIUiBji72rzQKGIFLzLUh
tuoKY7yJtDvX7wjvrsv6aVOufBiSfjqRUyr6mJci2sy3V7ETEu6UsinxbilDySrX
eJ7ZqrdjzSUaPi2KsThrU9NMoffOK6XBJEvVzmwNEsFtC1og4SZ1yH6rXXGJg7OH
yhZCknJQcpQid/Ino0zEN4aXOTJBpFta+CmDeTH/UOcKX2QHlwQ1bHE3X7HPP6aJ
S5+gSfQYG2fdi2yKE28cKShzSAC358Jdjanp/+RtSYeQ5kRK67tJNx7IsnqGkjjd
TIfUWD4gCKsQHj9DEaoA0+e9vQLlP0A1uGbByEjq09t/XMrXO3IDvmFBc0nI+l2t
6ZS23NBp22D8lnUY+SVvvzN47bLBwQxEt3hE4oKc8Ljs3EUeaaURC1k0GEGQb38T
qpqclfWoH6SbtldCcKsVyRek+oFm+3me/ATZKq3kKIzRHmsxURCG7w6c942kS/rA
J8Ij1G/0eKqHdAYd/+A68/dr1vFd1qW7KJv8upE9eRUD0OHFxBWMcxzxnOg9Q/PE
/v6vqnN1aTASXpEYGN8p
=1KdC
-----END PGP SIGNATURE-----

--tEHGBXK3vJrgoiLspTdTfncsGabi8Qgs5--
