From: James Hogan <james@albanarts.com>
Date: Thu, 09 Sep 2010 22:38:43 +0000
Subject: fb_write unaligned writes
Message-Id: <201009092338.59880.james@albanarts.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart6423560.VPvvt7sj25"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--nextPart6423560.VPvvt7sj25
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I came across a problem in fb_write (drivers/video/fbmem.c) which doesn't m=
ake=20
any effort to avoid unaligned writes. It copies up to a page at a time from=
=20
userspace into a buffer, then fb_writel's as much as possible from the buff=
er=20
into the framebuffer, then fb_writeb's any remaining bytes. However on=20
architectures which don't perform unaligned writes this can cause a bus err=
or=20
or silently fail when it tries to fb_writel to an unaligned framebuffer=20
position.

My question is how best should this be fixed? I know I could avoid writing=
=20
more than 3 bytes to an unaligned framebuffer offset, but the standard writ=
e=20
syscall should be able to handle this, and Documentation/unaligned-memory-
access.txt makes it clear that unaligned accesses are to be avoided and wit=
h=20
good reason.

Is it possible to just copy_from_user straight into the framebuffer, or sho=
uld=20
I define an fb_memcpy to go with the other definitions around line 925 of=20
include/linux/fb.h, or something else?

Thanks
James

--nextPart6423560.VPvvt7sj25
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkyJYgMACgkQ4hGc8zKz77AnCQCeIXxFe4ECeKxiyJC3066b2C3f
PXcAn3ZXIV/OCX6UGiPB6poQ3vJNeZ85
=zW/Q
-----END PGP SIGNATURE-----

--nextPart6423560.VPvvt7sj25--
