From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 11:24:05 +0000
Subject: Re: [PATCH] fbdev: put module after running driver callback
Message-Id: <5603DD55.8080801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PNQrPIiHNA9jfsNPTJkuH76NkkLP162Ik"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441987843-4313-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1441987843-4313-1-git-send-email-dh.herrmann@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>, linux-fbdev@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org

--PNQrPIiHNA9jfsNPTJkuH76NkkLP162Ik
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 11/09/15 19:10, David Herrmann wrote:
> Currently, for each open() on an fbdev device, we pin the underlying
> fbdev device and driver module. On close(), we release both. This
> guarantees that the fbdev object stays around until the last FD is
> released (even though it might be unregistered already).
>=20
> However, currently we call module_put() *before* calling put_fb_info().=

> This has the side-effect that the driver module might be unloaded befor=
e
> put_fb_info() calls into fbinfo->fbops->fb_destroy().
>=20
> Fix this by keeping the module pinned until after we release our fbdev
> reference. Note that register_framebuffer() and unregister_framebuffer(=
)
> are special as we require the driver to unregister device before
> unloading. Hence, they don't need to pin the module. However, all open
> handlers *have to*.
>=20
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  drivers/video/fbdev/core/fbmem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/cor=
e/fbmem.c
> index 0705d88..4e78731 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1482,13 +1482,16 @@ __acquires(&info->lock)
>  __releases(&info->lock)
>  {
>  	struct fb_info * const info =3D file->private_data;
> +	struct module *owner;
> =20
>  	mutex_lock(&info->lock);
>  	if (info->fbops->fb_release)
>  		info->fbops->fb_release(info,1);
> -	module_put(info->fbops->owner);
> +	owner =3D info->fbops->owner;
>  	mutex_unlock(&info->lock);
> +
>  	put_fb_info(info);
> +	module_put(owner);
>  	return 0;
>  }

Looking at fb_open(), in error case it calls module_put() followed by
put_fb_info(). Is that broken also?

Have you hit this bug, or did you just find it by looking at the code?
In other words, is this for 4.3 fixes, or 4.4. I guess the user needs to
unload the module just at the right time to trigger this bug.

 Tomi


--PNQrPIiHNA9jfsNPTJkuH76NkkLP162Ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA91VAAoJEPo9qoy8lh71yc8P/1Z9GlqenZKjedv1hipr6szP
AwqYTlbxKAMdEf4IeVY33tXWtQnEKIm4MvKi9oTu81HwrRuOKzUrG5x01y6VBQ84
B5jfXZHmLF0vnIPvsmeqAj/G1LYdmbTAC+3k4bY4+JzmRMPWDmOcC4i7t+zHqJPI
MkMlMcF4eK+q8ayMJQYML4UUpui8J8eEXTyN3+5aprpbkhxPaL1qOlZ3HXKni9gb
EUMgD8kVb83bOyf+WQCKnhYdMu9TieDx59IjWRS9W6AoIkZ7S2mNapoKj1SkIz1X
vbTiyceSu6AXbuDMgyZF4dU9l8WYszBTk9xU2puojhdCNQi4V7O3gAV4TpiRUtNC
RisE/qlU8Ol6Km+/gZLwjnNMXmzuCGAlFjtKs3e8ZeoTMOSs9aI755bgvxQw7mkT
8Fh3tcgSL8Q2wfmw/sNI5g1sY2iD2hEDOO/GrGIP9BB/dVWAzpVTmD7zObhs6j+x
rPZb705R5Maa9U/uRLQ/3S7ydVcKakCyMQy5FE5IOdLCRNs+jPKS5qlUglvK+1HQ
q5ZJtOEkBiPz2EK+EXht3bPQgxg0AigNsKz4/cc1+zfXnPuIxEkFvqaSzDh1A0IM
l3k4JTAJ5TKmxp0gUTAbaft0oqvXBpbQqZ3CSntKXEXRgFDqql1E4nOuNMGU0duK
fy9hh9DeJ2lF+b9mWeFW
=ba6a
-----END PGP SIGNATURE-----

--PNQrPIiHNA9jfsNPTJkuH76NkkLP162Ik--
