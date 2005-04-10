From: Hendrik Sattler <post@hendrik-sattler.de>
Subject: small radeon frame buffer issues
Date: Sun, 10 Apr 2005 11:59:32 +0200
Message-ID: <200504101159.36819.post@hendrik-sattler.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2211450.mzSVtRhO5D";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DKZG4-0002Qp-0E
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 03:01:36 -0700
Received: from smtp1.rz.uni-karlsruhe.de ([129.13.185.217])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DKZG2-0003Nc-8R
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 03:01:35 -0700
Received: from localhost.rz.uni-karlsruhe.de ([127.0.0.1] helo=localhost)
	by ma2geo.mathematik.uni-karlsruhe.de with esmtp (Exim 4.30)
	id 1DKZFP-0006A3-RV
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 12:00:55 +0200
Received: from ma2geo.mathematik.uni-karlsruhe.de ([127.0.0.1])
	by localhost (ma2geo [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23048-09 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 10 Apr 2005 12:00:38 +0200 (CEST)
Received: from p54a3e8b1.dip.t-dialin.net ([84.163.232.177] helo=coruscant.local)
	by ma2geo.mathematik.uni-karlsruhe.de with asmtp (TLS-1.0:DHE_RSA_RIJNDAEL_128_CBC_SHA:16)
	(Exim 4.30)
	id 1DKZEe-00069m-GO
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 12:00:08 +0200
Received: from [192.168.37.246] (helo=tatooine.local)
	by coruscant.local with esmtp (Exim 4.50)
	id 1DKZE9-0003dg-1n
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 11:59:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

--nextPart2211450.mzSVtRhO5D
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I write this to you because you are also in the MAINTAINERS file for=20
linux-2.6.11.
I have some issues with the radeonfb, rather minor but I want to tell you=20
anyways. I am not subscribed to the list, so please CC me when answering.

1.
RADEON FRAMEBUFFER DISPLAY DRIVER
P:      Ani Joshi
M:      ajoshi@shell.unixbox.com
is unreachable. The file should be updated.

2.
I tried with
video=3Dradeonfb:1024x768-24@60
and this resulted in no framebuffer console at all. 24bpp is a common setti=
ng=20
for X and in my opinion, the driver should just do the right thing with the=
=20
request (e.g. map it 32bpp if necessary).
Or at least you could print a kernel message in the default case that the=20
selected bpp value is not supported.

3.
radeonfb is mentioned in no file in Documentation/fb/. This lets one guess =
on
how to use it. Please add radeonfb to the supported list in=20
Documentation/fb/modedb.txt

Thanks.

Hendrik Sattler

=2D-=20
Mein GPG-Key ist auf meiner Homepage verf=FCgbar: http://www.hendrik-sattle=
r.de
        oder =FCber pgp.net

PingoS - Linux-User helfen Schulen: http://www.pingos.org

--nextPart2211450.mzSVtRhO5D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCWPkIzvr6q9zCwcERAsysAJ91ZNJhfZsnrZwf2Gl5YUUjh7zRBgCgrRwx
7/MpM2UGVQ+7sfQkM6+BYGs=
=mnYU
-----END PGP SIGNATURE-----

--nextPart2211450.mzSVtRhO5D--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
