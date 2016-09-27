From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:17:54 +0000
Subject: Re: [PATCH] video: fbdev: constify fb_fix_screeninfo and fb_var_screeninfo structures
Message-Id: <d602d8af-2c60-6337-3e68-bee09ed2f46c@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JI5haVODTXRJMj6h1s1STULaeV5qRgtNO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1473607040-21295-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1473607040-21295-1-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Hans de Goede <hdegoede@redhat.com>, Jaya Kumar <jayalk@intworks.biz>, Paul Mackerras <paulus@samba.org>, Ferenc Bakonyi <fero@drama.obuda.kando.hu>, linux-nvidia@lists.surfsouth.com, Antonino Daplas <adaplas@gmail.com>

--JI5haVODTXRJMj6h1s1STULaeV5qRgtNO
Content-Type: multipart/mixed; boundary="MKiAMwPtL29BQ0TKTkAa7DWE2uxwj73wx";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Hans de Goede <hdegoede@redhat.com>, Jaya Kumar <jayalk@intworks.biz>,
 Paul Mackerras <paulus@samba.org>, Ferenc Bakonyi
 <fero@drama.obuda.kando.hu>, linux-nvidia@lists.surfsouth.com,
 Antonino Daplas <adaplas@gmail.com>
Message-ID: <d602d8af-2c60-6337-3e68-bee09ed2f46c@ti.com>
Subject: Re: [PATCH] video: fbdev: constify fb_fix_screeninfo and
 fb_var_screeninfo structures
References: <1473607040-21295-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1473607040-21295-1-git-send-email-Julia.Lawall@lip6.fr>

--MKiAMwPtL29BQ0TKTkAa7DWE2uxwj73wx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/16 18:17, Julia Lawall wrote:
> These structures are only used to copy into other structures, so declar=
e
> them as const.
>=20
> The semantic patch that makes this change in the fb_fix_screeninfo case=
 is
> as follows (http://coccinelle.lip6.fr/).  The fb_var_screeninfo case is=

> analogous.
>=20
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct fb_fix_screeninfo i@p =3D { ... };
>=20
> @ok@
> identifier r.i;
> expression e;
> position p;
> @@
> e =3D i@p
>=20
> @bad@
> position p !=3D {r.p,ok.p};
> identifier r.i;
> struct fb_fix_screeninfo e;
> @@
> e@i@p
>=20
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct fb_fix_screeninfo i =3D { ... };
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/video/fbdev/arcfb.c                  |    4 ++--
>  drivers/video/fbdev/asiliantfb.c             |    4 ++--
>  drivers/video/fbdev/aty/aty128fb.c           |    6 +++---
>  drivers/video/fbdev/aty/atyfb_base.c         |    2 +-
>  drivers/video/fbdev/aty/radeon_monitor.c     |    2 +-
>  drivers/video/fbdev/hecubafb.c               |    4 ++--
>  drivers/video/fbdev/hgafb.c                  |    2 +-
>  drivers/video/fbdev/i740fb.c                 |    2 +-
>  drivers/video/fbdev/kyro/fbdev.c             |    2 +-
>  drivers/video/fbdev/pm2fb.c                  |    2 +-
>  drivers/video/fbdev/s1d13xxxfb.c             |    2 +-
>  drivers/video/fbdev/savage/savagefb_driver.c |    2 +-
>  drivers/video/fbdev/simplefb.c               |    4 ++--
>  drivers/video/fbdev/sm712fb.c                |    2 +-
>  drivers/video/fbdev/ssd1307fb.c              |    4 ++--
>  drivers/video/fbdev/tdfxfb.c                 |    4 ++--
>  drivers/video/fbdev/uvesafb.c                |    2 +-
>  drivers/video/fbdev/vfb.c                    |    2 +-
>  drivers/video/fbdev/vga16fb.c                |    2 +-
>  19 files changed, 27 insertions(+), 27 deletions(-)

Thanks, queued for 4.9. There was a minor conflict in vfb.c, I resolved
that.

 Tomi


--MKiAMwPtL29BQ0TKTkAa7DWE2uxwj73wx--

--JI5haVODTXRJMj6h1s1STULaeV5qRgtNO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6isyAAoJEPo9qoy8lh71xGQP/0J5lZO8CWvf3olLMdh1zjTy
CP5Q9REOlq6k2ADKE+/vhpHzmhKigxH+s2KorZLlbqCheqXEyuMjzL2e2SBsL9P/
D58rd06+htOvOV80pAy61kEFucjJem5WCoY8mczuaf9J/G6sq5WQPMdra4WnjSdF
PH4rD9oP2WEAHIR6szjhZq2ltopPWpZ8aHb1IRiySpNi18kgE094yqcD+nJgn3iF
sycIKV8eA4796vzGR6xY4WqZPnlRZbnG8fN6FwBayJeII9C8k1sDk+159Z57CcdW
/kmw5/Ap1qQxQE9lOInAy8KLBQk74xddl+fHLz+l9Wz2CMgUhtawesAW2+u3kXlQ
M48fJiu+xwa9I3tIcJnUlRyaAKhtdD1fn76CGHk+e3wwBwWLYhb3N5qkJU/RRIAx
OcCnKmvUh4oCB+KpowMFr+OafbdOpQarw39PdymO4Esja5oYG799X39VQibnB+p3
BsxVZe0Twl4OnE5vmNkATLaTB4Kj3BTzAx6BL2CJnQL6oP/caL1y1bLlgA8xJaZv
qpy3NeumRKuHSOoZqGOwx87otMw3m19WAawXk07anbKTYniBlBVGiUK6p6s7OSqo
X9EbKJhvEjnvZsbWML8WpqJRzKIQd+E1S1w4tnDca4aCQ91EMe3lWsXJPmiAJTHZ
KLQZyp5m4dF93cjNrdB5
=x4wK
-----END PGP SIGNATURE-----

--JI5haVODTXRJMj6h1s1STULaeV5qRgtNO--
