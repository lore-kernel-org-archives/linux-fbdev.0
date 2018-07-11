From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 11 Jul 2018 14:46:11 +0000
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QBiUdYI2cLAGlVt5Ah5DucB7J6nfmFTpz"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
In-Reply-To: <20180628090351.15581-3-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QBiUdYI2cLAGlVt5Ah5DucB7J6nfmFTpz
Content-Type: multipart/mixed; boundary="sNmtio5EuBf8Tpax2m8x7cLI3SzjIhJHB";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Hans de Goede <hdegoede@redhat.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
In-Reply-To: <20180628090351.15581-3-hdegoede@redhat.com>

--sNmtio5EuBf8Tpax2m8x7cLI3SzjIhJHB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi

Am 28.06.2018 um 11:03 schrieb Hans de Goede:
> Replace comments about places where the console lock should be held wit=
h
> calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.

Debugging fbcon sometimes requires to not take the console lock. This
patch breaks the debugging workaround provided by
'fb.lockless_register_fb'. The dmesg is now filled with warnings about
the missing lock.

Best regards
Thomas

> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patchset
>
> Changes in v4:
> -Keep the comments about which fbcon functions need locks in place
> ---
>  drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/cor=
e/fbcon.c
> index c910e74d46ff..cd8d52a967aa 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, int=
 user)
>  	struct fb_info *oldinfo =3D NULL;
>   	int found, err =3D 0;
> =20
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	if (oldidx =3D=3D newidx)
>  		return 0;
> =20
> @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
>  {
>  	int i, new_idx =3D -1, ret =3D 0;
> =20
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	if (!fbcon_has_console_bind)
>  		return 0;
> =20
> @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info *=
info)
>  {
>  	int i, idx;
> =20
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	idx =3D info->node;
>  	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++) {
>  		if (con2fb_map[i] =3D=3D idx)
> @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info *=
info)
>  static void fbcon_remap_all(int idx)
>  {
>  	int i;
> +
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++)
>  		set_con2fb_map(i, idx, 0);
> =20
> @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info *in=
fo)
>  {
>  	int ret =3D 0, i, idx;
> =20
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	idx =3D info->node;
>  	fbcon_select_primary(info);
> =20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)



--sNmtio5EuBf8Tpax2m8x7cLI3SzjIhJHB--

--QBiUdYI2cLAGlVt5Ah5DucB7J6nfmFTpz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltGGDcACgkQaA3BHVML
eiPA0wf/UjMoShlEcO26+mipgSTdopT9blwyQ1cR05HKOc7R5ex02SGodVTYBPSm
YAaNa+vnGy0i8UFUirr1kjlYAfipVoU5MmLiT2GZp2tUOQ7RIv79QYgArB4nCGHZ
JhOh7enLjJnQHUx0mP0uHe3S3KD5hkUC5zU5aDpreJcFPJABDObVWAhJlsNk1Xvj
bzO+XqkN7T4mMCEx1Xlrv1ZVUF6KowfhtvTYYC7Z1+CDcL94fNj92u4IvtFNtyHC
oo/I2jr0+QzZC8bfPYWfMSv/2RkQ11bWns8jCnLr3pAKuCn5jxoOgeJLZpruL0H3
KJPQ4pbnSiP79Yrs8WxZwfI5kPK3Fw==
=PX+n
-----END PGP SIGNATURE-----

--QBiUdYI2cLAGlVt5Ah5DucB7J6nfmFTpz--
