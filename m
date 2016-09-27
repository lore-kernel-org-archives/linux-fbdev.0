From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:48:11 +0000
Subject: Re: [PATCH] video: smscufx: remove unused variable
Message-Id: <26515073-e9e6-9351-c213-ccae571c87a6@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3UFRKHh1xS6B18vfxt53oMwr369BQFjIu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1464178788-10591-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1464178788-10591-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--3UFRKHh1xS6B18vfxt53oMwr369BQFjIu
Content-Type: multipart/mixed; boundary="0XsnOrADgh8l6O8fGw0MTOoAVfH2k2Kkb";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Message-ID: <26515073-e9e6-9351-c213-ccae571c87a6@ti.com>
Subject: Re: [PATCH] video: smscufx: remove unused variable
References: <1464178788-10591-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1464178788-10591-1-git-send-email-sudipm.mukherjee@gmail.com>

--0XsnOrADgh8l6O8fGw0MTOoAVfH2k2Kkb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/05/16 15:19, Sudip Mukherjee wrote:
> The variable was only assigned with the pointer but was never used.
> We can safely remove it.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/video/fbdev/smscufx.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscuf=
x.c
> index 9279e5f..ec2e7e3 100644
> --- a/drivers/video/fbdev/smscufx.c
> +++ b/drivers/video/fbdev/smscufx.c
> @@ -1761,10 +1761,8 @@ error:
>  static void ufx_usb_disconnect(struct usb_interface *interface)
>  {
>  	struct ufx_data *dev;
> -	struct fb_info *info;
> =20
>  	dev =3D usb_get_intfdata(interface);
> -	info =3D dev->info;
> =20
>  	pr_debug("USB disconnect starting\n");
> =20
>=20

Thanks, queued for 4.9.

 Tomi


--0XsnOrADgh8l6O8fGw0MTOoAVfH2k2Kkb--

--3UFRKHh1xS6B18vfxt53oMwr369BQFjIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6jJLAAoJEPo9qoy8lh71rGIQAKLyyxRzyKoeIfva7SgXFJlu
l5FHiKj7wb/dvFtWF6zqcALQMca0INkNhCJjMOkbhHYU4wAYqHs3Z7Eg2DdwM+KV
wjQ/tXBWODPIj0G9XbXUTnwvVkLHurI8jWcv3elijX2l+avSUDXetbvf+Jd+bZKK
eBJf6OTv+D7SuQyL8dOTO6AhiYyjzpsrpF8NfxXhQnqlzzRsj5y82rydgtfkFgxj
H2XlDv5fJTbuC3sr7ckgytdF66nUouCFnVAUzuB/LhEXL7mfDgW5bGrXIdan+sua
7o5b8cj8wSdkpUHShbcZvK/olee6xZMFPwe8P+YhKM1hhyAYuHqm+wnockV8gaqD
a3EFvtqb3skJKNjEk4na8iM8buvxDKvAqxJ34CCpYE7LT/2PQyTt6RkXEcVxVM85
ZX1A/rifrl/cKBHvoeh/7rrFiM5bovJvf0JtTlhQDhC963Iw/VVerHrgqdWVhoIb
4oJoNDImKwNYLrua9Czf9HkBAZNXi2nxeciNfNYE3Dh1VW5cGsMlQw9qcX7PciIf
qTgX+6RqlCMIE0NDy1riJ2DnX00AWRt5ENrRDUb9W7wY1j5WAKyihh+Hla9Rif19
x7hlDSJ+RQ43cto7eQl9m34DZUDNuljPd5vJzZdnLiABwIp2FMKA/5qOnrbgYQ2R
vKJN9NTUCuUyH1JLo1gH
=gE/t
-----END PGP SIGNATURE-----

--3UFRKHh1xS6B18vfxt53oMwr369BQFjIu--
