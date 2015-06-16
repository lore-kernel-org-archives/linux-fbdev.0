From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Jun 2015 07:07:21 +0000
Subject: Re: [PATCH] fbdev: propagate result of fb_videomode_from_videomode()
Message-Id: <557FCB29.3000006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tE38rcbpRJlF7TBufPqlxxfbPg57lwEnO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434117559-32130-1-git-send-email-vladimir.murzin@arm.com>
In-Reply-To: <1434117559-32130-1-git-send-email-vladimir.murzin@arm.com>
To: linux-fbdev@vger.kernel.org

--tE38rcbpRJlF7TBufPqlxxfbPg57lwEnO
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 12/06/15 16:59, Vladimir Murzin wrote:
> fb_videomode_from_videomode() may fail, but of_get_fb_videomode()
> silently covers this fact. Instead, trow the error code to the
> caller.
>=20
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  drivers/video/fbdev/core/fbmon.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/cor=
e/fbmon.c
> index 01ef1b9..d787533 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -1475,7 +1475,9 @@ int of_get_fb_videomode(struct device_node *np, s=
truct fb_videomode *fb,
>  	if (ret)
>  		return ret;
> =20
> -	fb_videomode_from_videomode(&vm, fb);
> +	ret =3D fb_videomode_from_videomode(&vm, fb);
> +	if (ret)
> +		return ret;
> =20
>  	pr_debug("%s: got %dx%d display mode from %s\n",
>  		of_node_full_name(np), vm.hactive, vm.vactive, np->name);
>=20

Thanks, queued for 4.2.

 Tomi


--tE38rcbpRJlF7TBufPqlxxfbPg57lwEnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVf8spAAoJEPo9qoy8lh7187wQAJGzY4MHgX+REz4vNELr3CwX
E1fMQICU3PFxtjzBAmghOSW+y3vpaOgWBkWCdGsLn1kVdLVIfQCblJxM+DYEnrvP
zaydXPhJdAnKjK30WETlZKhULKt2UcQMeBh8zGeyIceoRr5/trtErwj8QIPVgSit
Ta+AZcY4M7s96OvqohcRZQuL6y15fZCvl+uqVBy1AdKM5u/CLdkB5ebytMfzeiF9
ePwEOMK9WpVflK6KFi11f5BxXd3ggkDiv8zv7xJGloPKTMDtghcPpYUd28++rDHy
VXjKbwGC6Ml+VR7IF63SGsxBDGwi/MhHXhMTqHSb201KHJpXla3a20hhSdxLxKmL
tQtSTL91KeUctnpf9iLG46ZGlYBqP1bsj9/Hd5MhasAN85laeys6H5C8uSPyOEet
jFiig6UnxV3+Svt7Kgfer/KBtsow9yW9gaH5aVq54F3NdNXMA6gV3TH5pYJqD4/3
8fsTIoS5Mrz0/omb+V8JVxvg76NH3/pW9UiD6406d5DNX7yVkWVwJGDF9ba5n11a
+SrxACYPBXk3TbTsP8nS1U4Apnzhz5Ysb1ScVmKanr8gzXChJK/rnKwdzIJwDJE5
nlpG7ZWPFeKR+sI5AkYj6j6O+0m+bZoj+onZfguN/bPU3feSYWBe7Oj1V9VvyrFS
qKGGyePwJmMC/aVxEYdr
=dMlT
-----END PGP SIGNATURE-----

--tE38rcbpRJlF7TBufPqlxxfbPg57lwEnO--
