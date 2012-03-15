From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 15 Mar 2012 19:08:03 +0000
Subject: Re: [Linux-fbdev-devel] [uclinux-dist-devel] [PATCH] [#7001] framebuffer: old image of last app woul
Message-Id: <201203151508.04564.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4173243839655916680=="
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--===============4173243839655916680==
Content-Type: multipart/signed; boundary="nextPart4992493.1MfDLordnU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4992493.1MfDLordnU
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 15 March 2012 05:23:50 Wu, Aaron wrote:
> Old image of last application would retain for a while when starting a new
> application, this patch clear the frambuffer before displaying every time
> the fb is opened.

i'm not sure the behavior you describe is wrong.  in fact, i'm pretty sure =
it=20
sounds correct.  if an app writes an image to the framebuffer and then quit=
s,=20
that image should stay there indefinitely until something else opens the=20
framebuffer and draws their own image.
=2Dmike

--nextPart4992493.1MfDLordnU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPYj4UAAoJEEFjO5/oN/WBGV4QAKwhe0e238iKxvXRuWL430fg
0bM1r/tKPLqd6RR+npC4e02flTBsWHgT1IgT9MtsMmqe1dXk4HBqkqAJpz1U5Ryd
6trd7PocyfryahKoTmBZ3INFQHmpGqCB5h/DbC0ufCZdAGK14vMTMkNpY96qF0+b
rDlG9f8F85QU6jH7IP2rtad6PQ4kZQdLpe/YRxroJR0fBvTCgqBc2AtdJ+oS9anS
B5CQdPDdeitAavZlJJkcMgz2IgPnYJBqccnRN+h15JcBeyBI4u4teujB/Qfg85QN
rbGY9V+UVVVdB4q8bdGdvgNN5XpqD7aVjP8nBhxBTJTSekPDSaCvW4zvk7eMMZ3J
6BIwrizQmS4ScLZ0SNvUBSBI9hjRNGt8KtMd8IIZ0LVBe/nHWtlNUJBbWOlXb/Ck
MJtZupcGull1GXg9mvA8bvGMSB5DaZjjlVAqrH9Jtb4YuTLLMyVX0K+o280ZRNEz
UUgqotk90VOZzGS2OZ4213/jZKUDANL0ryi2FB/l6DfcH2evlMz+/ZLYNHRb33Ts
Q+//n2i5Z0UuVjA27hC+0kzaa7Hubm9GrKhOg28YBTVhg2I2zjduczMn7cU9H+QZ
Y26PIRjU1mlY41kSkhqpznrXS+GLk6e+ybnjXBYTVqkIsLSuOfOMy68ULgnxS9b8
ZFEXsDzYOyrpq5AKfZmM
=AEK9
-----END PGP SIGNATURE-----

--nextPart4992493.1MfDLordnU--


--===============4173243839655916680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============4173243839655916680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============4173243839655916680==--
