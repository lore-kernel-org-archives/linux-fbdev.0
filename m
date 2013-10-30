From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Oct 2013 11:20:37 +0000
Subject: Re: [RFC PATCH RESEND] fb: reorder the lock sequence to fix a potential lockdep
Message-Id: <5270EB85.1030103@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dfiQb3TWVNumgxRMhjITDr4I4crUv1apa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <526DFDA8.7010806@cn.fujitsu.com>
In-Reply-To: <526DFDA8.7010806@cn.fujitsu.com>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

--dfiQb3TWVNumgxRMhjITDr4I4crUv1apa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-10-28 08:01, Gu Zheng wrote:
> Following commits:
> 50e244cc79 fb: rework locking to fix lock ordering on takeover
> e93a9a8687 fb: Yet another band-aid for fixing lockdep mess
> 054430e773 fbcon: fix locking harder
>=20
> reworked locking to fix related lock ordering on takeover, and introduc=
ed console_lock
> into fbmem, but it seems that the new lock sequence(fb_info->lock ---> =
console_lock)
> is against with the one in console_callback(console_lock ---> fb_info->=
lock), and leads to
> a potential deadlock as following:

A quick grep shows that there are other places than fbmem.c which use
lock_fb_info and console_lock, for example drivers/video/sh_mobile_lcdcfb=
=2Ec.

 Tomi



--dfiQb3TWVNumgxRMhjITDr4I4crUv1apa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJScOuFAAoJEPo9qoy8lh71nTMP/0LXtkpHctkUogDJZHlE14Gf
8xMRFtHFauyf950HUCro4VJ+vf3PaLQXK5LPJAzY8VnCkQUBZGEGiOrh7u13tK4O
nocFMebEp6EJ5NVQwEb5SzTwpi6eNB7drhsJYHegM6Yi/tzMS/KnmL0OUGVAlKTq
fUG1wIxam0ZzCDUsgi6FJZGS/6oCXi7rF6RAbZKf52P1X8Ea59bGahtuA+86PCla
m9j0TnNTPfsvSTT2FkytxVMapa3spb+2aJOrX5+E73dW8MqdcIJIxDXJ0GJwbVwI
y2CQjmOM2vJRkGuCZDlUbrI3w8Pw8N8qCRpaSawdVtckdkrXYPLUVkQmVLEMgux+
ioTSedlNdyisvr+ql2SONIfPtliRKOR2tw87udDhKM/SeCoUDCik95Nr+OEVPL/p
7NOw6AAfesKqkROFjRnEA+TJ3B8BnB5YfNr2lNwsKFJNASiUjjrXXuyXX1AfglnK
DToaM9ys+hmYqOvTf8aFEuvZc79mQ17Tj+nCPvZIzuTfyltofyy5FWEc0EnYEK9M
4VbYWShHrlQh5hXFxbaL7DN5wViuROxgOZFYN2ZAMdAWOiIf5G/aajk3LsPpK5CK
m5+ygae6Hy+ELAP5+VXoQfpc3lnPfB2N72fHNFCVBapwVKKwut3H5PGKwdNLgBLJ
qz5/W8fQFaVxYG/mf3iR
=XuwQ
-----END PGP SIGNATURE-----

--dfiQb3TWVNumgxRMhjITDr4I4crUv1apa--
