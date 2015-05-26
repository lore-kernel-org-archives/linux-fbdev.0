From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 May 2015 08:32:52 +0000
Subject: Re: [PATCH 1/1 linux-next] video: fbdev: matrox: use swap() in matroxfb_decode_var()
Message-Id: <55642FB4.3060902@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="hlI7ocuvFdQ7tjl7adMbqvishkugvVvA0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431970264-16195-1-git-send-email-fabf@skynet.be>
In-Reply-To: <1431970264-16195-1-git-send-email-fabf@skynet.be>
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

--hlI7ocuvFdQ7tjl7adMbqvishkugvVvA0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/05/15 20:31, Fabian Frederick wrote:
> Use kernel.h macro definition.
>=20
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/video/fbdev/matrox/matroxfb_base.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video=
/fbdev/matrox/matroxfb_base.c
> index 62539ca..2ba4e54 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -591,12 +591,8 @@ static int matroxfb_decode_var(const struct matrox=
_fb_info *minfo,
>  			unsigned int max_yres;
> =20
>  			while (m1) {
> -				int t;
> -
>  				while (m2 >=3D m1) m2 -=3D m1;
> -				t =3D m1;
> -				m1 =3D m2;
> -				m2 =3D t;
> +				swap(m1, m2);
>  			}
>  			m2 =3D linelen * PAGE_SIZE / m2;
>  			*ydstorg =3D m2 =3D 0x400000 % m2;
>=20

Thanks, I've queued this and the two other swap() patches for 4.2.

 Tomi


--hlI7ocuvFdQ7tjl7adMbqvishkugvVvA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZC+0AAoJEPo9qoy8lh71xjQP/0+/vCCpitxc/nGAYarYsJ9z
qKAW2KVb0tTF/hdtScFmprte2XxEXg/q6kvBd0GgiM8K7y4b68Hbw0RY4yo02QFb
QojQy0Cf3nlFTN/M2zdzosImdRl0gk3PTAunb9Gcm7M96ld3msqQQgYKHkoFu6MM
NmzTdiprTwR8+DC879fVlOzdWI/o57iVeaDYkBoC5PhTlXoiKlJmdwTSjgLDAhl6
KvQfvtrnago8c8iILL4n8OxuBf/qkKXa6h8qQ94aY/g3m6LR4oc8IygK1UiMyH4a
uNlpxxbCfTzyOp8dX5GTcyFttqTKL0mrV96P5oDA/yA56FIaPKcUxQeqtSFSrqCw
SAyt+WGv1Q1bgV7Miz70aVMctprGAAFOHE8hqd8CYEjKjP+GHy6uvDzT/UJRm8B6
9k+N282FpquzV+Ujq+whOxBbyVDsF+ZpFcH+nuYZmu8nGaXiVIeU9fOTtVfyj+vr
lx8yIgb4dxc5sfI6F/lSFS6BG/QseiPJvIbRJp7VYeHXSVO967dhYsP4fH31LuJp
/DvnP9BJbCZrGMrenA3fahXpxudB5ual/VlkxZj5FVZlP+euz9REjktnDd9Zq9BD
tI3b5cx/UHDJT8jp7o1PqR7WnZCLp94gwkzwNM7J7TELeTdqdUZ1zMNYE8WMYOGt
090A0am4iWt0NWUJauY2
=V2A0
-----END PGP SIGNATURE-----

--hlI7ocuvFdQ7tjl7adMbqvishkugvVvA0--
