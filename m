From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 03 Mar 2016 11:52:10 +0000
Subject: [GIT PULL] fbdev fixes for 4.5
Message-Id: <56D8256A.8020301@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3f49RvA6cNLOVQKntKgdcJuQ08hXA61cF"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--3f49RvA6cNLOVQKntKgdcJuQ08hXA61cF
Content-Type: multipart/mixed; boundary="LDKV59AJLqriptk1ME1iuHTfePpB8jiqv"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <56D8256A.8020301@ti.com>
Subject: [GIT PULL] fbdev fixes for 4.5

--LDKV59AJLqriptk1ME1iuHTfePpB8jiqv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 81f70ba233d5f660e1ea5fe23260ee323af5d5=
3a:

  Linux 4.5-rc5 (2016-02-20 13:39:35 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.5

for you to fetch changes up to a1e533ec07d583d01349ef13c0c965b8633e1b91:

  fbcon: set a default value to blink interval (2016-02-26 13:19:55 +0200=
)

----------------------------------------------------------------
fbdev fixes for v4.5

* fix hang caused by fbconsole blink timer

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      fbcon: set a default value to blink interval

 drivers/video/console/fbcon.c | 2 ++
 1 file changed, 2 insertions(+)


--LDKV59AJLqriptk1ME1iuHTfePpB8jiqv--

--3f49RvA6cNLOVQKntKgdcJuQ08hXA61cF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2CVqAAoJEPo9qoy8lh71XWIQAI0RL5cziVrEyASUBlry8+Wh
QLvw8WXUyiEa2bGYzf8pQ+E8A4SX4u7EwwTRejOLMwEMlnIjpK1oJ4H88HXwe+Ba
ZeciVsrN6NbUkCjNIJsgDgMdqCBq3KoJNesDybsrQVFBcly9VyelD0flLCffy4Cs
IWuYkjlDMoq5ewwPAHdAQagJ7btPpNdDfsDw1Ru8nr33U+D1Lo8sjs+K1aBDH1qD
apw5YOUIo/t6aeobi3uxSChFfEeshYy6u0bMxGwpl8M4UvnUgDK2ozOhNNoCVeOC
S9uPp9KYX2ciVAx0RCLoJR4dBoM1WYmwbsUboZZGoYAJbgcdkqde/Ab0UTSFJ6Ac
udS0MLVd0bWZxMlrgmpzLeZA6odV6tJE6XjGnz9WJPDpyiDZ/84G9Crie2IUhluO
rsEFRwWQlZfkhjgylDOMXol/xSgLRoEDdCrWx7p2PqPCcbPxnD/Tul264XHPfLqr
0RhfcaEfiB1AA3p+rzW156o1C/vcN8IPlBssWyhqWKXUrzvIcedS7Yo/a7RO7Bez
UGTafzTGxg2sL0Z0Muub8tpuSxyqOf4mUdN1i8Crj2D42VJ09+vFNDkGVkVrhuvH
1tQeN8zi2T2ce+fRY+QrlFkL1QwL7mJSdP+Jrh4hFFrJ8zJp57ps5SCxhdU1aYhu
wdXbLpZ34PqYQC2Xx/GD
=EV7Q
-----END PGP SIGNATURE-----

--3f49RvA6cNLOVQKntKgdcJuQ08hXA61cF--
