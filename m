From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 18 Jul 2018 08:15:29 +0000
Subject: Re: [PATCH v2] console: Replace #if 1 with a bool to ignore
Message-Id: <3bc67f92-d590-b338-1953-157d9863405d@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="atdjv6TYUOVLoJhuJY4fHII1pziybYOhR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180712092938.22e33641@gandalf.local.home>
In-Reply-To: <20180712092938.22e33641@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--atdjv6TYUOVLoJhuJY4fHII1pziybYOhR
Content-Type: multipart/mixed; boundary="aU3KOqIK40UTqpqA20DZ8Q8s5VaQdV8oZ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Petr Mladek <pmladek@suse.com>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Message-ID: <3bc67f92-d590-b338-1953-157d9863405d@suse.de>
Subject: Re: [PATCH v2] console: Replace #if 1 with a bool to ignore
References: <20180712092938.22e33641@gandalf.local.home>
In-Reply-To: <20180712092938.22e33641@gandalf.local.home>

--aU3KOqIK40UTqpqA20DZ8Q8s5VaQdV8oZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 12.07.2018 um 15:29 schrieb Steven Rostedt:
>=20
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>=20
> There's been discussion on the fb list about the addition of
> WARN_CONSOLE_UNLOCKED() inside the fb code. The complaint is that when
> the fb module is loaded with lockless_register_fb the console lock is
> not taken for debugging reasons. With the addition of
> WARN_CONSOLE_UNLOCK() within the fb code, this causes the console to
> fill up with warnings when trying to debug the fb driver.
>=20
> There's also a #if 1 that enables the warning which was added before
> git history, and we look down on constant #if's in the kernel nowadays
> anyway.
>=20
> Remove the #if 1 and add a ignore_console_lock_warning boolean that can=

> be set by drivers to ignore the warning in order to do debugging.
>=20
> Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@sus=
e.de
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> Changes since V1:
>  - Added comment to describe ignore_console_unlock_waring variable
>  - Abide by 80 character limit
>=20
> Index: linux-trace.git/include/linux/console.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-trace.git.orig/include/linux/console.h
> +++ linux-trace.git/include/linux/console.h
> @@ -200,11 +200,14 @@ void vcs_make_sysfs(int index);
>  void vcs_remove_sysfs(int index);
> =20
>  /* Some debug stub to catch some of the obvious races in the VT code *=
/
> -#if 1
> -#define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_=
in_progress)
> -#else
> -#define WARN_CONSOLE_UNLOCKED()
> -#endif
> +#define WARN_CONSOLE_UNLOCKED()						\
> +	WARN_ON(!ignore_console_lock_warning &&				\
> +		!is_console_locked() && !oops_in_progress)
> +/*
> + * Set ignore_console_lock_warning to true if you need to quiet
> + * WARN_CONSOLE_UNLOCKED() for debugging purposes.
> + */
> +extern bool ignore_console_lock_warning;
> =20
>  /* VESA Blanking Levels */
>  #define VESA_NO_BLANKING        0
> Index: linux-trace.git/kernel/printk/printk.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-trace.git.orig/kernel/printk/printk.c
> +++ linux-trace.git/kernel/printk/printk.c
> @@ -66,6 +66,9 @@ int console_printk[4] =3D {
>  	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
>  };
> =20
> +bool ignore_console_lock_warning __read_mostly;
> +EXPORT_SYMBOL(ignore_console_lock_warning);
> +
>  /*
>   * Low level drivers may need that to know if they can schedule in
>   * their unblank() callback or not. So let's export it.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

This resolves the problem for me.

Tested-by: Thomas Zimmermann <tzimmermann@suse.de>

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--aU3KOqIK40UTqpqA20DZ8Q8s5VaQdV8oZ--

--atdjv6TYUOVLoJhuJY4fHII1pziybYOhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltO9yEACgkQaA3BHVML
eiOjggf/eGpR02dnXYx0IDH0HWbLIg/i8K6lU9XMIK5h4aAsg3ulwa3IKZ4gWIyR
VFUn1qyrGGtyBbHNRMdwEmddZ9m6phw45XDsS6CAZ16cTvimHZcsEHMy/dYpntO5
bfyoZjPVpDteP5zZOocwe6gif+tjYKcSsQHMmEM0mTCTsnGVXJlbwqB0yvamrNCr
LQ9M0gqicgfbyB1c9V1nDQ5SvbtlWvkH7OWtNHLj+4wzROwSRsblmuUa8/eiY6QQ
piNwOUaKWSYSdmql47stjdQLfmdBqiDW7umai6Fja5deGHym/vJh6rdy/kRBmGvE
RZnUJ4dk53GEHxivhmHCnxPncFMHHw==
=Nit+
-----END PGP SIGNATURE-----

--atdjv6TYUOVLoJhuJY4fHII1pziybYOhR--
