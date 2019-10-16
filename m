From: Jacopo Mondi <jacopo@jmondi.org>
Date: Wed, 16 Oct 2019 13:05:36 +0000
Subject: Re: [PATCH v5 0/7] backlight: gpio: simplify the driver
Message-Id: <20191016130536.222vsi5whkoy6vzo@uno.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="obmlgf7bnd7gsis3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191007033200.13443-1-brgl@bgdev.pl>
 <20191014081220.GK4545@dell>
 <CACRpkda9Kco-bVPw1OA6FMpQ1L8dZ4WFJ227wTCM9rh5JE7-+A@mail.gmail.com>
In-Reply-To: <CACRpkda9Kco-bVPw1OA6FMpQ1L8dZ4WFJ227wTCM9rh5JE7-+A@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>


--obmlgf7bnd7gsis3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, sorry for not having replied earlier

On Wed, Oct 16, 2019 at 02:56:57PM +0200, Linus Walleij wrote:
> On Mon, Oct 14, 2019 at 10:12 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> > >  arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--
> >
> > I guess we're just waiting for the SH Acks now?
>
> The one maintainer with this board is probably overloaded.
>
> I would say just apply it, it can't hold back the entire series.

I've been able to resurect the Ecovec, and I've also been given a copy
of its schematics file a few weeks ago.

It's in my TODO list to test this series but I didn't manage to find
time. If I pinky promise I get back to you before end of the week,
could you wait for me ? :)

Thanks and sorry again!

>
> Yours,
> Linus Walleij

--obmlgf7bnd7gsis3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl2nFaAACgkQcjQGjxah
VjzoFBAAhwhZPZe4vv+vLpIH9nXV/zZkAZjerr/FDZoeAm13GfCbvATlAG3xuN2O
/yt4lmoNa0HPZn59BxgVUsCZC5/uTUg8NosCm33YOUGtYU1bhqo9dvBIQc2U7OXJ
u+CxQrlsXVXJtF+51bzDbU0dQRXgccwVhl8F0KMtq/OwyzboyFOl400CN5CqIKHP
Htq5yUN7BPhMNWtSM9ar/CfZpLQUvhl2P/h4id6uuPhM8CQtlDEHxHSULFxtJBwl
w7y0N5f+7wUKtrPVsJ5M6ya3iPrhda49XWtcEPuYGGkOxgM3DiLJENLnStTf78Bh
4hde/25m0jCdbqqRENmccyBcznO1ljcdQOYTAZty+ufXtTWFcJwNk7+Obaz2P447
09kuzxY+Syp7QWAmjh9R1gxaxBpfHCkALgttNqws8jLhou70YeglHSgA/4z/aHgK
wgTcAz2HrzgbtJA15KTO9x+99Gyr/NzJE7ffXSNPXket5u9U2O0r+efDKeCMAGVl
O1YQD4zAnk460taT03o8QndflimZp1kq8Wg8PlXgV3y4XAsIgq64Dc2QGqzLaxI6
30Ak7ph277+RSc6SU6lMazid9TF/b8sf1Rk8tc/usVoWrN7BoHhyFSJj9tdFG71f
kFfg9ieXD+Lno9Ri03PmblRxX1Qted/2kJzw6YX65On55W72l0A=
=RcMR
-----END PGP SIGNATURE-----

--obmlgf7bnd7gsis3--
