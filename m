From: Thomas Schlichter <thomas.schlichter@web.de>
Date: Sun, 06 Feb 2011 11:02:05 +0000
Subject: Re: [PATCH] uvesafb,vesafb: create write-combining or write-back PAT entries
Message-Id: <201102061202.09503.thomas.schlichter@web.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart8479254.T2lzAKVkOP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <201011271437.38126.thomas.schlichter@web.de> <20101130061051.GD17114@linux-sh.org>
In-Reply-To: <20101130061051.GD17114@linux-sh.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart8479254.T2lzAKVkOP
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorry for answering this late, unfortunately I was quite busy with my daily=
=20
work...

Am Dienstag 30 November 2010, um 07:10:51 schrieb Paul Mundt:
> uvesafb presently has no special architecture dependencies, but
> ioremap_wc() is not as of yet a wholly generic interface. Some
> architectures that don't set ARCH_HAS_IOREMAP_WC get it by virtue of the
> asm-generic/iomap.h include, and most of the nommu architectures will
> stub it in via asm-generic/io.h, but this still leaves quite a long list
> of platforms that don't handle it at all.
>=20
> Your options at this point are either to establish ioremap_wc() as a
> generic API, and layer this patch on top of that, or rework
> uvesafb_init_mtrr() to do the actual broken-out remapping and rework it
> in to something like a uvesafb_remap(), where you bury the MTRR details
> under CONFIG_MTRR.
>=20
> While there's probably value in exposing ioremap_wc() as a generic
> interface, you're never going to hit any of the non-default ioremap()
> calls on platforms lacking MTRRs anyways, so special-casing it is ok.

Thank you for finding that problem and showing possibilities for fixing it.=
 I=20
prepared 3 patches, where the first essentially is my old patch with specia=
l-
casing via ifdef CONFIG_X86. The second patch establishes ioremap_cache() a=
nd=20
ioremap_wc() for all architectures, and the third patch removed the special-
casing from uvesafb.

So the first patch can stand on its own and hopefully can be merged upstrea=
m.=20
The third patch needs the second one, which may be merged for unifying=20
purposes. But as these are mor cleanup-patches, they are not that important=
=20
for me.

Best regards,
Thomas Schlichter

--nextPart8479254.T2lzAKVkOP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1Of60ACgkQYAiN+WRIZzTmTwCgmkXxrMFyHBH7SZEoKuaWdoOL
0igAoI0ZvOlJw4EKfhpJXdaDvojUCjir
=c5J2
-----END PGP SIGNATURE-----

--nextPart8479254.T2lzAKVkOP--
