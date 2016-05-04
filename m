From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Wed, 04 May 2016 09:43:15 +0000
Subject: [PATCH v2 0/3] video: fbdev: imxfb: make it work again
Message-Id: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello,

this is v2 of the series which addresses the review comments I got vor
(implicit) v1.

For patch 2 the question is still open if this is the right fix, but
without this the display doesn't stay on. Patches 1 and 3 should be
applicable independant of patch 2.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (3):
  video: fbdev: imxfb: fix semantic of .get_power and .set_power
  video: fbdev: imxfb: enable lcd regulator in .probe
  video: fbdev: imxfb: add some error handling

 drivers/video/fbdev/imxfb.c | 53 +++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 41 insertions(+), 12 deletions(-)

--=20
2.8.0.rc3

