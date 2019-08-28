From: Jacopo Mondi <jacopo@jmondi.org>
Date: Wed, 28 Aug 2019 16:40:44 +0000
Subject: Re: [PATCH v3 0/7] backlight: gpio: simplify the driver
Message-Id: <20190828164044.ku3xozmp7wlipn5d@uno.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ootzxk2uvromcpqa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190724082508.27617-1-brgl@bgdev.pl>
 <CAMRc=Mex_Ricd+C4F7nGLmpBggO-hWwJDB6duX8kFpPEeaTDjQ@mail.gmail.com>
 <CAMRc=Mci4ncbDmns=0uL8hsAGz1Wvd5bgK4yxTF8QQQitXDv0g@mail.gmail.com>
 <CAMRc=McUEgm6yH7enwHuHxVTL41dmb5KAY_pxTmSr3vctCs2xg@mail.gmail.com>
 <CAMuHMdV3obGtQ7qohNedQNgpvZvyL9xjH0HUiBKD6b8Ou5F+XA@mail.gmail.com>
 <CACRpkdbgZhgSvicq2XG0n2hiKA9K8VFmvCPn3W9oXgSLrZiw=w@mail.gmail.com>
In-Reply-To: <CACRpkdbgZhgSvicq2XG0n2hiKA9K8VFmvCPn3W9oXgSLrZiw=w@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lee Jones <lee.jones@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Thompson <daniel.thompson@linaro.org>


--ootzxk2uvromcpqa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Geert,

On Wed, Aug 28, 2019 at 06:31:19PM +0200, Linus Walleij wrote:
> On Wed, Aug 28, 2019 at 10:36 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>
> > CC the pour soul with the ecovec board.
>
I'm sorry, Eco what ? :)

> With great power comes great responsibility ;)
>

Yeah, that's -exactly- a 'great powers' board :)

I'll try to resurect it from the deads again and get back eventually
with a tested-by.

I only briefly looked at the series and I don't have any LCD to test
the backlight with, I hope I can sample the backlight GPIO value from
some test point, if I ever find the schematics...

> Yours,
> Linus Walleij

--ootzxk2uvromcpqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl1mrowACgkQcjQGjxah
VjxtAA//YCv1S5V4Y+U+KJqq8uhB+Cs4NqedH2fC45FFxMAz/ze/UnG4XixNT9x1
UP3xPgozXZeOzJyfM9w4bRC8yLTq6/t4kazDK0jjr/defxi1YpHCARTEw4/ioEkb
FJ9K2FolNzhcQbTQNqNQNYqCtXPsUwzOR701cZkf2eE5PE/1DJi17wsYfycbi/1/
HDrnrjDXnjla5CMrObPmvJ5rxPDHSHo3Le+SpBflzwvEWIktFKSwCMiNYUj2z9/x
N71lKRlTS4jr//BURsomOt6i5Qzr6X2DroQ+VFLzsoToSVRleS/UMiY/ADnNori6
xB9brM1ua/98Go61pIGXkhwOztB880f1dsyNygtyqxssWBUsWFEKsKcxQC5uAaeA
iWY68EcVHFRKipu0CzJCNTh/mWrEbKZznDQPrXO4PIS8KlZuTlhKvrrTZAQL0knN
zgTETUPOD4Yo27IvaNfxZKXWvfJbdywvPXOfV5i7lnMyYo17nfNQ3ZGeNcI+7oMA
mgSi7zzNyOn1Rrag82vAytbXehRLkBq6vY7CpiCL6Cnh9J+NySiqOwpm/j1RBpek
6rb2rbdu2kYUICirp9Fij8Ii1fkV4maFrRSxqe3Zig4Vr+swUl2Rc00Alz0Rj2y9
I6CVuwpecgOeEmGst6RgEZ6R5ZyS5sO93znoz/ux6lbxW6UcYCE=
=s/MY
-----END PGP SIGNATURE-----

--ootzxk2uvromcpqa--
