From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2016 09:04:13 +0000
Subject: Re: [PATCH] fbdev: fbmem: implement error handling in fbmem_init()
Message-Id: <5731A40D.4050801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HsDPHMB4ujS2pejJJgBL3iVmDBe8fHBSc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1462242147-19876-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1462242147-19876-1-git-send-email-khoroshilov@ispras.ru>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

--HsDPHMB4ujS2pejJJgBL3iVmDBe8fHBSc
Content-Type: multipart/mixed; boundary="4TWjau5rgAKLprVSMGPwvTuGIbjOwVofU"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ldv-project@linuxtesting.org
Message-ID: <5731A40D.4050801@ti.com>
Subject: Re: [PATCH] fbdev: fbmem: implement error handling in fbmem_init()
References: <1462242147-19876-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1462242147-19876-1-git-send-email-khoroshilov@ispras.ru>

--4TWjau5rgAKLprVSMGPwvTuGIbjOwVofU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/05/16 05:22, Alexey Khoroshilov wrote:
> fbmem_init() ignores all errors, while fbmem_exit() does not
> check if deallocating resources are valid.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/video/fbdev/core/fbmem.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/cor=
e/fbmem.c
> index 4e73b6f6b1c0..76c1ad96fb37 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1854,17 +1854,31 @@ EXPORT_SYMBOL(fb_set_suspend);
>  static int __init
>  fbmem_init(void)
>  {
> -	proc_create("fb", 0, NULL, &fb_proc_fops);
> +	int ret;
> +
> +	if (!proc_create("fb", 0, NULL, &fb_proc_fops))
> +		return -ENOMEM;
> =20
> -	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
> +	ret =3D register_chrdev(FB_MAJOR, "fb", &fb_fops);
> +	if (ret) {
>  		printk("unable to get major %d for fb devs\n", FB_MAJOR);
> +		goto err_chrdev;
> +	}
> =20
>  	fb_class =3D class_create(THIS_MODULE, "graphics");
>  	if (IS_ERR(fb_class)) {
> -		printk(KERN_WARNING "Unable to create fb class; errno =3D %ld\n", PT=
R_ERR(fb_class));
> +		ret =3D PTR_ERR(fb_class);
> +		pr_warn("Unable to create fb class; errno =3D %d\n", ret);
>  		fb_class =3D NULL;
> +		goto err_class;
>  	}
>  	return 0;
> +
> +err_class:
> +	unregister_chrdev(FB_MAJOR, "fb");
> +err_chrdev:
> +	remove_proc_entry("fb", NULL);
> +	return ret;
>  }
> =20
>  #ifdef MODULE

Looks good to me, queueing for 4.7.

 Tomi


--4TWjau5rgAKLprVSMGPwvTuGIbjOwVofU--

--HsDPHMB4ujS2pejJJgBL3iVmDBe8fHBSc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMaQNAAoJEPo9qoy8lh71mewP/0SM0sVOFc5OjMf3xXQYwvuA
VR5uO2lC7VAL/Br8nTPRsP8Dixsxwc0W+uRPr0HrnRYcHTS9qdhgdirpR/3ioMKP
62pN6ANzwZxV871X96APHVLA+h1cR9vnh4UBa1wgoGFrrYNY84iS0pIHwJMa1Lzc
ZF9LYVeb7845eWAspavv4YRiMk+1IBVQ8v+2eGIYxaAa0FFU8dv5PtMlAcYZVV2w
CMYdCi2HScmiJ2VUEACAQcISbqyVpxPM/xCiDCP7UQc3b0I4dpqXrj+/RDI0OxcC
RTlosZEznmsBK7b5NCJO/AE/5kUGKB3NTttOTATun7y3Yt5deJmkqhowEkBwq1cx
NAckMQSdCUU1uOJe1TehTriVtbrWK44hm2EYRuUWMjPCsjbtEMXXLKsJDqsCwOQN
YAo+Zqk+uaMtrcnxbVY5yldFcqdLDUnC/3J9yGo+98QP9G9XF9k0xw0fg65Xok7b
48IbUVYm2niECSCWOzuU8kIGfDzPnDl06hdkfuf6fEdXcQWVO9Og5TBgdqW/Tg13
C71LIqjPR6M1lPwEpM3r28tlEUpu19vf3qq68sQBhZgOWoqVgA7P3Qn6ZCyQmEyu
5z9CjwqZxDL/JqD+onmcDcmOae77jdD3P1XwFv72YozdnoR3etihEv0d7MN3QKGt
1e1JJHW+UtzBmCg/AxGp
=4hSV
-----END PGP SIGNATURE-----

--HsDPHMB4ujS2pejJJgBL3iVmDBe8fHBSc--
