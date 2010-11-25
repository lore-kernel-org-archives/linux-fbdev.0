From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 25 Nov 2010 09:21:48 +0000
Subject: Re: [PATCH 1/2] fbdev: bf537-lq035: new Blackfin Sharp LQ035 framebuffer driver
Message-Id: <201011250421.49237.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1395800.aotqLRKeyI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290591239-6089-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1290591239-6089-1-git-send-email-vapier@gentoo.org>
To: linux-fbdev@vger.kernel.org

--nextPart1395800.aotqLRKeyI
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday, November 25, 2010 03:28:11 Paul Mundt wrote:
> On Wed, Nov 24, 2010 at 04:33:58AM -0500, Mike Frysinger wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >=20
> > For LCDs hooked up to BF537-STAMP boards.
> >=20
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Bryan Wu <cooloney@kernel.org>
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > ---
> > note: these have been posted in the past, but before we got a fbdev
> >=20
> > 	maintainer, so i'm just reposting them to hopefully get merged
>=20
> On Wed, Nov 24, 2010 at 04:33:59AM -0500, Mike Frysinger wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >=20
> > Driver for ADV7393 add-on card for multiple Blackfin boards.
> >=20
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Bryan Wu <cooloney@kernel.org>
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > ---
> > note: these have been posted in the past, but before we got a fbdev
> >=20
> > 	maintainer, so i'm just reposting them to hopefully get merged
>=20
> While I don't really have any strong opinions about these drivers one way
> or the other, a cursory glance shows that they end up sharing quite a bit
> of code, along with the existing in-tree blackfin fb drivers. Have you
> considered trying to abstract things a bit and moving things in to a
> drivers/video/bfin or the like? Much of the DMA and PPI stuff looks like
> it could be pretty easily broken out.

we have thought about it quite a bit, but havent quite gotten an answer tha=
t=20
worked without a lot of cruft
=2Dmike

--nextPart1395800.aotqLRKeyI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJM7iqtAAoJEEFjO5/oN/WBAaoQANsQjkSMAPr8VTiGVuzhFM2l
lmkOWoBsrQKw0NLxLBt6pG94tg9OI5uMFUFwqW7PqIwHB8hOU0OTvdOpXiihO4Hf
BDJm9K/iwxNsCyQo4s77YRgdFK8yN1qkE4Xv8CiN4XyCUQ8O8ZlWwhKjc1K+W0OC
/7tgK6Ax6hj0awT0GikehDT7yU3yk+WwQxM2YMnG4qBdwP7v7B/MICxIeDh0QNiH
dWqAgbpxgkSAphXseThztDjHLyrSxADbK0yH0PvmK/8mMXPJ6VvvBfwnkr/cAwpF
U/t51FEnxYgxAw1EPfqSY2PDUghs5uunduslMgbTgwWd0/gbap5qu/DD1CLOS29B
O2DRhjXR7kZz7azFQgXW3u+0RLRQtoc6qNwxs/ovyaC9BNaWZukpe3ldIlunUghb
Dumixlpm7bVa9haXEqfMBotmdqf3WWyltYDq8C3bjZV8GhP2CVfQXMSnz5hyEbEH
lvHg1i+We7lnVBw83WYhn+E+DHm4M0eZrhVMotun4wGXqZqKz4Mo1end0f9kyVp9
fsBtYbzpes88uxlYI9zBJx+3+hbMiSqmf22/7sdp0X8nB22VDiiL9GltS/nJ1AH6
eHVwRSo3dK+prNXxn6hh/vfgQZ2IiRoH0bCwbSz9ssJhlZiK4qzNseEseBo0bO8t
YnlOOAQDeIzsQw9pqtRE
=avwE
-----END PGP SIGNATURE-----

--nextPart1395800.aotqLRKeyI--
