From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 21 Mar 2014 13:42:42 +0000
Subject: Re: [PATCH] fbdev: Make the switch from generic to native driver less alarming
Message-Id: <532C41D2.7030509@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Hja1gfHAlXBs43clittwAlXw2ijBSj6cc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345223444-15852-1-git-send-email-ajax@redhat.com>
In-Reply-To: <1345223444-15852-1-git-send-email-ajax@redhat.com>
To: linux-fbdev@vger.kernel.org

--Hja1gfHAlXBs43clittwAlXw2ijBSj6cc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 23:02, Adam Jackson wrote:
> Calling this "conflicting" just makes people think there's a problem
> when there's not.
>=20
> Signed-off-by: Adam Jackson <ajax@redhat.com>
> ---
>  drivers/video/fbmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 7309ac7..b6d5008 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1596,8 +1596,7 @@ static int do_remove_conflicting_framebuffers(str=
uct apertures_struct *a,
>  			(primary && gen_aper && gen_aper->count &&
>  			 gen_aper->ranges[0].base =3D=3D VGA_FB_PHYS)) {
> =20
> -			printk(KERN_INFO "fb: conflicting fb hw usage "
> -			       "%s vs %s - removing generic driver\n",
> +			printk(KERN_INFO "fb: switching to %s from %s\n",
>  			       name, registered_fb[i]->fix.id);
>  			ret =3D do_unregister_framebuffer(registered_fb[i]);
>  			if (ret)
>=20

Thanks, queued for 3.15.

 Tomi



--Hja1gfHAlXBs43clittwAlXw2ijBSj6cc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTLEHSAAoJEPo9qoy8lh71xtkQAIYGV0yCa+C21VkZ5o/lAwum
zX3tHb0mnZDB9Dx/Xl9KlD1w34kHtjrEia3JBSJt0h5t9mmnOR1ykFHsAz5ZGnCi
H5j3MoKhD2QfEa7uEi+eCYNfSQRmExiaryVNMi3bPt4cWPInzIlxQDgg07cS58Qo
6gVX6yQnf8NG2hObrNY9UfjkVv49aLu0gODSXgmtGxai8KsI98o1JzgPi8Jw1NRS
gwdyHdg8MYN32IoSgREWjGalwuoOmMOMRStxjS1F5n7UxkiWX9fGvvUkI4GTUKdh
8vvU+bVKs2Cgecjttv7H0t88JAWRtB8PU0a71mlcFUjF2UUQr/fCEjjPY5zolsBY
Jh3te308i2R15mXdxloaVYErw0qw5F4ReqZiPm1VXeF/Tt+THvu2bX4tYXgEH429
C2FOzMa/Gp8yTmqDn5PmfrxQW09Lc+Hb1+CVVdrNYeJN/00TGEPZA0hvs1w1E9U0
7CrWkq0mMPxjjzT8vUk+Ie8q6aQD+8big4YBjXbl4QsUkzasGUsESxt3eAwOJf/4
Ar5qMaA7o+h2BQfwD/11AlYZiViOTcEb+sfSzM5NxibNZo8o9kjgJ8jdshUvcGBL
DlEPvryEJVaH4BudOwkmRirNssrWMGu/PgLX43E+DOwZ0ATUgOt06JL35na5llee
S1ZHEFprtYGFd2y4R8gt
=GCQw
-----END PGP SIGNATURE-----

--Hja1gfHAlXBs43clittwAlXw2ijBSj6cc--
