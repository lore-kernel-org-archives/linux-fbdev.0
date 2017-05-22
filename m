From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Date: Mon, 22 May 2017 10:27:19 +0000
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Message-Id: <20170522102719.yzqujz327hv5zu7r@earth>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tjpa2ifnbroetnta"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
In-Reply-To: <20170521220212.1404-4-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Felipe Balbi <bal>


--tjpa2ifnbroetnta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> [...]
>  drivers/power/supply/twl4030_charger.c  | 2 +-
> [...]

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

--tjpa2ifnbroetnta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkivQQACgkQ2O7X88g7
+pr+JBAAgfqciZwOxlKdgg1Ffp+cnY74bMb+kL52A5+T4mkbwSyRNm944UI4PbYg
y4k137b5tcH/YyF66lqI+C3pXQzbrMBvO0rLfqHCB0HKRd7akG8AKSwhe7TA52MH
zt58f9un02aqyyNceNOzr/jg2DAFCQP3q/w3ZscyoehFC2rezpCbX8Vb2PTu81hR
9STMybSMS0K/B1D9X5gmBIhZ8ofTPDZDirPUNgdn4zD26iNsEnWbPc/5qCL2ecFU
H9RWUUmUdkYxtyjmWVa2fktT66VYhq4Ku6BiD8E6f7qwtQ+WqjVglTLx6s+PdxWI
tbgbf/6BVLw+ogSIvEuDdXlZeZVM7e4qUjcRw6FnzsqgyBDMbB+SqIpnbRYHUwsH
Y4Jh6yD9M6X0YA71B7i2nkUIRoYFmEzRI+Evk5vchFTZIyW5V4nu95BcsgTH/ZVZ
le93GTruiQSSZkLS471xqZ+XCgSMIE052sJLhLRjzT+PjLqs3F0b8fpg53/wITcJ
Rr06jGF/k0YdgpBGHexUiA+3frXdkdY5bx9wKh9C7y1JnjR6ZME4FN2rhkecZHX2
VxwW9ra2g9wdJn0SL/eZNtb79FKNCigQik5grIG7kw55bdybGXgGZMHRvYbN91eU
wccj0CYykJ9wKuRfttth4jVCwoMV1vt2TvYcrUfMv9eTEd7VeTU=
=JcW1
-----END PGP SIGNATURE-----

--tjpa2ifnbroetnta--
