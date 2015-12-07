From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 16:01:12 +0000
Subject: Re: [PATCH RESEND] fbdev: Make fb-notify a no-op if CONFIG_FB=n
Message-Id: <5665AD48.6000602@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WshMS16vpidpjpK7gUVt9LhsO0TMS1Ncp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448421108-3437-1-git-send-email-ezequiel@vanguardiasur.com.ar>
In-Reply-To: <1448421108-3437-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-fbdev@vger.kernel.org

--WshMS16vpidpjpK7gUVt9LhsO0TMS1Ncp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 25/11/15 05:11, Ezequiel Garcia wrote:
> There's no point in having support for framebuffer notifications
> is CONFIG_FB is disabled. This commit adds the necessary stubs
> for code to link properly when CONFIG_FB=3Dn and moves fb-notify.o
> to be built only when CONFIG_FB=3Dy.

Why do you add CONFIG_FB_NOTIFY, isn't plain CONFIG_FB enough? Oh,
right, to have it built-in even if FB is a module.

But this makes me wonder, why is fb_notify in obj-y list currently.
Nobody just bothered to make it build only when needed, or has there
been some use for it earlier... The commit descriptions in git history
suggest the former.

Actually, looks like fb_notify.c was originally made to solve the same
problem as your patch solves, but by separating the notify code from the
main fbdev code. So I still wonder, was there some reason to keep the
notification code built instead of having stub functions.

Any thoughts?

 Tomi


--WshMS16vpidpjpK7gUVt9LhsO0TMS1Ncp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZa1IAAoJEPo9qoy8lh71yxIP/isQMR4oMjTgSRbWJpxsNUY9
guAKH4vXAglhAENr2O8whUR8et1M4tLbF+nfrD7fZDTVhdZjBGNQh2EiNEHEll97
9bVgoZeO84nODTa5MErOluOVbNiRJZpweqnHagwDGPLUGr0icwNwza04KUUvMgqG
Dp4wjdYicFl2V5JhIJyZ12VukUESqNlbbWtQx2ecRRGAZadNHKLbxRKp+5oOXfbb
qiXgkdjKyGchmyUGKuvL7dvofcoprFclHmU1TIN6SMMl0o/pLk9g5poAs2OjwFmC
ctGOvp3lecOEwt9RRuzgw1pVBxSNswmhhcfGVPymNHvXrHdAqlomH4Ov+CxQOoYZ
dRgAu/AGrgBjd1HiPL271dy4qAou00BDXqps/iZw0FtBgkwjOiv6N/9NrhNgRHN3
e0K/dcVBUTO/QyQpEXlD5xAJKGrgwSZEC+6Ri+Rc45GEXc/05zhS5M6pPQ2cxmLW
+3rS/VDGkUPuD/yplRNiYibiG0VnzFuU1YMvxjGWShWiI8EMkz2DT0mo9E9a59u/
m2b4BkBWeLiBcm/7EXNr4H0E8LvmlXZ4WgAFDJjijke5IIg5ymBbglMyVwOyIvUR
6rfXXj416w3QiGkeinXtcWvgxFreeRhL0GAGL7bZR11i1poRJIyn+WFMck7yClzD
VPHz0Xta/yEuqUD6zyRD
=/0E9
-----END PGP SIGNATURE-----

--WshMS16vpidpjpK7gUVt9LhsO0TMS1Ncp--
