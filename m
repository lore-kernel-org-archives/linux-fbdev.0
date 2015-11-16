From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:23 +0000
Subject: [PATCH v4 00/24] pwm: add support for atomic update
Message-Id: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello,

This series adds support for atomic PWM update, or IOW, the capability
to update all the parameters of a PWM device (enabled/disabled, period,
duty and polarity) in one go.

Best Regards,

Boris

Changes since v3:
- rebased on pwm/for-next after pulling 4.4-rc1
- replace direct access to pwm fields by pwm_get/set_xxx() helpers, thus
  fixing some build errors
- split changes to allow each maintainer to review/ack or take the
  modification through its subsystem

Changes since v2:
- rebased on top of 4.3-rc2
- reintroduced pwm-regulator patches

Changes since v1:
- dropped applied patches
- squashed Heiko's fixes into the rockchip driver changes
- made a few cosmetic changes
- added kerneldoc comments
- added Heiko's patch to display more information in debugfs
- dropped pwm-regulator patches (should be submitted separately)

Boris Brezillon (23):
  pwm: rcar: make use of pwm_is_enabled()
  pwm: use pwm_get_xxx() helpers where appropriate
  clk: pwm: use pwm_get_xxx() helpers where appropriate
  hwmon: pwm-fan: use pwm_get_xxx() helpers where appropriate
  misc: max77693-haptic: use pwm_get_xxx() helpers where appropriate
  pwm: introduce default period and polarity concepts
  pwm: use pwm_get/set_default_xxx() helpers where appropriate
  leds: pwm: use pwm_get/set_default_xxx() helpers where appropriate
  regulator: pwm: use pwm_get/set_default_xxx() helpers where
    appropriate
  backlight: pwm: use pwm_get/set_default_xxx() helpers where
    appropriate
  fbdev: use pwm_get/set_default_xxx() helpers where appropriate
  misc: max77693: use pwm_get/set_default_xxx() helpers where
    appropriate
  hwmon: pwm-fan: use pwm_get/set_default_xxx() helpers where
    appropriate
  clk: pwm: use pwm_get/set_default_xxx() helpers where appropriate
  pwm: define a new pwm_state struct
  pwm: move the enabled/disabled info to pwm_state struct
  backlight: pwm_bl: remove useless call to pwm_set_period
  pwm: declare a default PWM state
  pwm: add the PWM initial state retrieval infra
  pwm: add the core infrastructure to allow atomic update
  pwm: rockchip: add initial state retrieval
  pwm: rockchip: add support for atomic update
  regulator: pwm: properly initialize the ->state field

Heiko St=C3=BCbner (1):
  pwm: add information about polarity, duty cycle and period to debugfs

 drivers/clk/clk-pwm.c                |  11 +--
 drivers/hwmon/pwm-fan.c              |  16 ++--
 drivers/input/misc/max77693-haptic.c |   9 +-
 drivers/leds/leds-pwm.c              |   2 +-
 drivers/pwm/core.c                   | 169 +++++++++++++++++++++++++++++++=
----
 drivers/pwm/pwm-crc.c                |   2 +-
 drivers/pwm/pwm-lpc18xx-sct.c        |   2 +-
 drivers/pwm/pwm-pxa.c                |   2 +-
 drivers/pwm/pwm-rcar.c               |   2 +-
 drivers/pwm/pwm-rockchip.c           | 119 +++++++++++++++++++-----
 drivers/pwm/pwm-sun4i.c              |   3 +-
 drivers/regulator/pwm-regulator.c    |  30 ++++++-
 drivers/video/backlight/lm3630a_bl.c |   4 +-
 drivers/video/backlight/pwm_bl.c     |  10 ++-
 drivers/video/fbdev/ssd1307fb.c      |   2 +-
 include/linux/pwm.h                  |  89 +++++++++++++++---
 16 files changed, 386 insertions(+), 86 deletions(-)

--=20
2.1.4

