From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 20 Jul 2015 15:31:57 +0000
Subject: [PATCH v2 00/10] pwm: add support for atomic update
Message-Id: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Thierry,

This series adds support for atomic PWM update, or IOW, the capability
to update all the parameters of a PWM device (enabled/disabled, period,
duty and polarity) in one go.

Best Regards,

Boris

Changes since v1:
- dropped applied patches
- squashed Heiko's fixes into the rockchip driver changes
- made a few cosmetic changes
- added kerneldoc comments
- added Heiko's patch to display more information in debugfs
- dropped pwm-regulator patches (should be submitted separately)

Boris Brezillon (9):
  pwm: introduce default period and polarity concepts
  pwm: define a new pwm_state struct
  pwm: move the enabled/disabled info to pwm_state struct
  backlight: pwm_bl: remove useless call to pwm_set_period
  pwm: declare a default PWM state
  pwm: add the PWM initial state retrieval infra
  pwm: add the core infrastructure to allow atomic update
  pwm: rockchip: add initial state retrieval
  pwm: rockchip: add support for atomic update

Heiko St=C3=BCbner (1):
  pwm: add information about polarity, duty cycle and period to debugfs

 drivers/leds/leds-pwm.c              |   2 +-
 drivers/pwm/core.c                   | 169 +++++++++++++++++++++++++++++++=
----
 drivers/pwm/pwm-pxa.c                |   2 +-
 drivers/pwm/pwm-rockchip.c           | 119 +++++++++++++++++++-----
 drivers/pwm/pwm-sun4i.c              |   3 +-
 drivers/regulator/pwm-regulator.c    |   2 +-
 drivers/video/backlight/lm3630a_bl.c |   4 +-
 drivers/video/backlight/pwm_bl.c     |  10 ++-
 drivers/video/fbdev/ssd1307fb.c      |   2 +-
 include/linux/pwm.h                  |  86 +++++++++++++++---
 10 files changed, 336 insertions(+), 63 deletions(-)

--=20
1.9.1

