From: Thierry Reding <treding@nvidia.com>
Date: Mon, 29 Oct 2018 15:24:20 +0000
Subject: Re: [PATCH] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <20181029152419.GB30162@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mojUlQ0s9EVzWg2t"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181029130232.31661-1-prarit@redhat.com>
In-Reply-To: <20181029130232.31661-1-prarit@redhat.com>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Steven Rostedt <rostedt@goodmis.org>

--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 09:02:32AM -0400, Prarit Bhargava wrote:
> A variant of this patch has been in Fedora since at least 2010 and
> AFAWCT there haven't been any complaints about the change in behavior.
>=20
> https://src.fedoraproject.org/cgit/rpms/kernel.git/tree/silence-fbcon-log=
o.patch
>=20
> P.
>=20
> ---8<---
>=20
> On text-based systems the 'quiet' boot option will show printk levels
> higher than CONSOLE_LOGLEVEL_QUIET.  The displaying of the Tux logo
> during boot can cause some consoles to lose display data and as a result
> confuse the end user.
>=20
> Do not display the Tux logo on systems that are in 'quiet' boot.
>=20
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Marko Myllynen <myllynen@redhat.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  drivers/video/fbdev/core/fbcon.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 75ebbbf0a1fb..a2f2c7ea11ef 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -650,11 +650,14 @@ static void fbcon_prepare_logo(struct vc_data *vc, =
struct fb_info *info,
>  		kfree(save);
>  	}
> =20
> +	if (logo_shown =3D=3D FBCON_LOGO_DONTSHOW) {
> +		return;
> +

You're missing a closing } here (well, you really shouldn't have the
opening { in the first place since this is a single line block.

That's what's causing the warnings from the 0-day builder.

Thierry

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvXJiEACgkQ3SOs138+
s6Hrmg/5ASm2hDKX84Wv+yBqKnP/6fjI7Pr3/SJXByEpvFVPWK26cw71boMqHMjC
koPA7F52oWpEYn0IgT+kJOx5uQ5/MnIvsOiXt4Hh/rz0aeglBfV/4CA8fCf64rAB
kM6EB65V4RQjGhhTr6R/R9xCZZK5RrytqNe8nvNPNKChwcxmlyicqUAwB22A9Y6N
YC7HWbjVogfIOPR5ITLrFBZMcL78n/foBpaADxm6p5r2pH3SElJ81C05FeuYJzVY
d/v2Xw0xghCscDEH6KxobGh+5JoNdIzH4rpD52AX1ppRAvmxunpgJGYu50HrQJrK
URwLsyYjzhdJOGfjHNJwa9KXLHNIXdTbRa8WUrGmq3zfBKKV17zWfjHiXcX6vgYG
+MxAMXdm34WRUOX35ZG9SAPV04mo5bb9+zQbQPY7fmPh/C1IsOcSesmVcwJNK55x
x60O5NYhNY/rjn4XSrgLIreikmBt0KN3SEbk6uq0M6JxxFrnUpx995CZXKnGwQgV
YjYhTQP86X0Msfg55m2WzVwBV9tYSQYfxjDmyw49WPIwUvZ9wuV5pHFCfA1NeCEq
v/bLrTP+Wfu6dcpuhINFwD0ejHoOrEqqqdaXS/LxfBbxAZBLyUHauu9OnPn81Ed2
nYN9X5hknsGaVqkGs7bGXqvM1A3AF2gcOCJhUXRZiLmymOGCEYg=
=1agK
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
