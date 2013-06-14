From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Jun 2013 10:23:14 +0000
Subject: [GIT PULL] fbdev changes for 3.11
Message-Id: <51BAEF12.4020605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2CQLWMNXMDEWOTQSVPXAG"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

------enig2CQLWMNXMDEWOTQSVPXAG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The following changes since commit f722406faae2d073cc1d01063d1123c3542593=
9e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/fbdev-for-3.11

for you to fetch changes up to ffa3fd21de8ab0db7962b612d4c6e17c0d88e9c2:

  videomode: implement public of_get_display_timing() (2013-05-28 14:42:5=
2 +0300)

----------------------------------------------------------------
Small fbdev changes for 3.11

* Add of_get_display_timing() for parsing single DT entry
* Add support for SSD1306 OLED controller
* ssd1307fb performance improvements

----------------------------------------------------------------
Maxime Ripard (4):
      video: ssd1307fb: Add support for SSD1306 OLED controller
      video: ssd1307fb: Rework the communication functions
      video: ssd1307fb: Speed up the communication with the controller
      video: ssd1307fb: Make use of horizontal addressing mode

Tomi Valkeinen (2):
      videomode: don't allocate mem in of_get_display_timing()
      videomode: implement public of_get_display_timing()

 .../devicetree/bindings/video/ssd1307fb.txt        |  10 +-
 drivers/video/of_display_timing.c                  |  55 ++-
 drivers/video/ssd1307fb.c                          | 392 +++++++++++++++=
------
 include/video/of_display_timing.h                  |   2 +
 4 files changed, 339 insertions(+), 120 deletions(-)


------enig2CQLWMNXMDEWOTQSVPXAG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRuu8SAAoJEPo9qoy8lh71jy8QAIep4hPMfZHfvV/+G9UCc6/c
sjsxRiwWVXdPllt4wgSco3l3pcsHQsxJc9qZFexKIdlkaETvqqujrAEM8b+IezaK
IR7RmDoFuU3+WmyaqomUSFbr1h3tP7rtGUU7C3j7FSHmTArEPZPafOZkvx5ejNxU
kGuFPrrKKT2uzk0h/3pCaDbRNtfDB7jL5DhIK5eiSM/QXhd/dNBEmEUGeicB23M0
k6wSShAJvXynXSi6CoIKLBULdIkrsD3JAXz32CBetO7oppfOpw28Nu6VYDeiwSNV
uDI+G5ZAr2RaSVZ4FZ2WGhSfW2gNpXTgugND4CuZZQBqUDXjo+W9sRipPQbj/HNj
Jg0ee0ig2LWFsGNWboyj4TUld3dyBN4BT5PB2qshnwnQCULnHeb+qsRYOEYUI1zq
4KFIsYEDHr1LNaKvvVa1nGPJcbBw2ogNuWXwAtq0zdyzDJWTYg4zLOSx1jXA4TMB
cyS4eznxMFkE9VGDLgOlnDzlNIY/uOv/sdqIFsR8qLsEXcLeP6nCsd2U4vReH2RI
TCsgfx0rppC1Tc04ghGYhf3SWK0gvTvV0nGrTvLahp3u89WtHwZXQ5m0YpNga4+X
1NZ1HrBETCrv8/hb3BkaGJknmsTnSce3+kpD2gQDpsMvyxPj6bAAe9VWIjW2XDsU
wklp2N1CDPlwwTUpShit
=gR2q
-----END PGP SIGNATURE-----

------enig2CQLWMNXMDEWOTQSVPXAG--
