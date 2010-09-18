From: James Hogan <james@albanarts.com>
Date: Sat, 18 Sep 2010 00:11:09 +0000
Subject: Re: fb_write unaligned writes
Message-Id: <201009180111.18130.james@albanarts.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2454580.4veGkkqhkQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <201009092338.59880.james@albanarts.com>
In-Reply-To: <201009092338.59880.james@albanarts.com>
To: linux-fbdev@vger.kernel.org

--nextPart2454580.4veGkkqhkQ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for the response Florian,

> > I came across a problem in fb_write (drivers/video/fbmem.c) which doesn=
't
> > make any effort to avoid unaligned writes. It copies up to a page at a
> > time from userspace into a buffer, then fb_writel's as much as possible
> > from the buffer into the framebuffer, then fb_writeb's any remaining
> > bytes. However on architectures which don't perform unaligned writes
> > this can cause a bus error or silently fail when it tries to fb_writel
> > to an unaligned framebuffer position.
> >=20
> > My question is how best should this be fixed? I know I could avoid
> > writing more than 3 bytes to an unaligned framebuffer offset, but the
> > standard write syscall should be able to handle this, and
> > Documentation/unaligned-memory- access.txt makes it clear that unaligned
> > accesses are to be avoided and with good reason.
> >=20
> > Is it possible to just copy_from_user straight into the framebuffer, or
> > should I define an fb_memcpy to go with the other definitions around
> > line 925 of include/linux/fb.h, or something else?
>=20
> Just doing copy_from_user straight into the framebuffer sounds like the
> right thing to me but my knowledge is limited to x86. As far as I can see
> this would make the functions (doing the same for fb_read can't hurt, can
> it?) in fbmem.c very similar to those in fb_sys_fops.c. Most users of the
> later functions can be easily eliminated as simply removing
> ".fb_{read,write} =3D fb_sys_{read,write}" is sufficient, only xen-fbfron=
t.c
> looks more difficult as it also refreshes the screen so I'd suggest the
> following:

Yes, I noticed fb_read has the same issue after I sent the first email.
Having looked a bit deeper though I'm not so sure copy_from_user straight i=
nto=20
iomem is a good idea, since as far as I can see iomem isn't necessarily=20
readable or writeable in the normal way (c pointer dereferences) on all=20
architectures.

Cheers
James

--nextPart2454580.4veGkkqhkQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkyUA6YACgkQ4hGc8zKz77B2igCgghMet9uUNPjn2vpQJbYLVc+Y
Z9QAniL4g70065IjpOK5jIcggm19Pr7u
=+BWA
-----END PGP SIGNATURE-----

--nextPart2454580.4veGkkqhkQ--
