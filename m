From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Sun, 20 Dec 2015 11:13:19 +0000
Subject: [PATCH v2 0/3] fbdev: omap2: panel-dpi: support reset-gpios and vcc regulator
Message-Id: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello,

these patches are what is remaining from my previous series sent
starting with
Message-Id: 1449753107-11410-1-git-send-email-uwe@kleine-koenig.org .

I split out the changes to
Documentation/devicetree/bindings/video/panel-dpi.txt in a (single)
separate patch. Also I changed the behaviour of the reset gpio to never
assert it because there are too many different needs.

Have fun
Uwe

Uwe Kleine-K=C3=B6nig (3):
  devicetree/bindings: add reset-gpios and vcc-supply for panel-dpi
  fbdev: omap2: panel-dpi: make (limited) use of a reset gpio
  fbdev: omap2: panel-dpi: implement support for a vcc regulator

 .../bindings/display/panel/panel-dpi.txt           |  2 ++
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 23 ++++++++++++++++++=
++++
 2 files changed, 25 insertions(+)

--=20
2.6.2

