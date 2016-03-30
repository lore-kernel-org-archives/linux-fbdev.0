From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Wed, 30 Mar 2016 20:03:23 +0000
Subject: [PATCH v5 00/46] pwm: add support for atomic update
Message-Id: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@>

Hello,

This series adds support for atomic PWM update, or IOW, the capability
to update all the parameters of a PWM device (enabled/disabled, period,
duty and polarity) in one go.

It also adds support for initial PWM state retrieval (or hardware readout),
which should allow smooth handover between the bootloader and Linux. For
example, critical PWM users (like critical regulators controlled by a PWM)
can query the current PWM state, and adapt the PWM config without having
to disable/enable the PWM, or abruptly change the period/dutycyle/polarity
config.

Thierry, I hope this version meets your expectations, if that's not the
case, could you let me know quickly so I can adjust the implementation
accordingly (I'd really like to get most of those changes in 4.7).

Best Regards,

Boris

Changes since v4:
- introduce pwm_args to expose per-board/platform config
- deprecate non-atomic APIs
- implement non-atomic functions as wrappers around atomic ones
- patch all PWM users to use the atomic API
- rename the ->reset_state() hook into ->get_state()
- drop most acks
- rework PWM config in the pwm-regulator driver
- patch sun4i and sti PWM drivers to support HW readout

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

*** BLURB HERE ***

Boris Brezillon (45):
  pwm: rcar: make use of pwm_is_enabled()
  backlight: pwm_bl: remove useless call to pwm_set_period()
  backlight: lm3630a_bl: stop messing with the pwm->period field
  pwm: get rid of pwm->lock
  pwm: introduce the pwm_args concept
  pwm: use pwm_get/set_xxx() helpers where appropriate
  clk: pwm: use pwm_get_args() where appropriate
  hwmon: pwm-fan: use pwm_get_args() where appropriate
  misc: max77693-haptic: use pwm_get_args() where appropriate
  leds: pwm: use pwm_get_args() where appropriate
  regulator: pwm: use pwm_get_args() where appropriate
  fbdev: ssd1307fb: use pwm_get_args() where appropriate
  backlight: pwm_bl: use pwm_get_args() where appropriate
  pwm: keep PWM state in sync with hardware state
  pwm: introduce the pwm_state concept
  pwm: move the enabled/disabled info into pwm_state
  pwm: add the PWM initial state retrieval infra
  pwm: add the core infrastructure to allow atomic update
  pwm: switch to the atomic API
  pwm: rockchip: add initial state retrieval
  pwm: rockchip: avoid glitches on already running PWMs
  pwm: rockchip: add support for atomic update
  pwm: sti: add support for initial state retrieval
  pwm: sti: avoid glitches on already running PWMs
  pwm: sun4i: implement hardware readout
  regulator: pwm: adjust PWM config at probe time
  regulator: pwm: swith to the atomic PWM API
  regulator: pwm: properly initialize the ->state field
  regulator: pwm: retrieve correct voltage
  pwm: update documentation
  pwm: deprecate pwm_config(), pwm_enable() and pwm_disable()
  pwm: replace pwm_disable() by pwm_apply_state()
  clk: pwm: switch to the atomic API
  hwmon: pwm-fan: switch to the atomic API
  input: misc: max77693: switch to the atomic API
  input: misc: max8997: switch to the atomic PWM API
  input: misc: pwm-beeper: switch to the atomic PWM API
  leds: pwm: switch to the atomic PWM API
  backlight: lm3630a: switch to the atomic PWM API
  backlight: lp855x: switch to the atomic PWM API
  backlight: lp8788: switch to the atomic PWM API
  backlight: pwm_bl: switch to the atomic PWM API
  video: ssd1307fb: switch to the atomic PWM API
  drm: i915: switch to the atomic PWM API
  ARM: s3c24xx: rx1950: switch to the atomic PWM API

Heiko St=C3=BCbner (1):
  pwm: add information about polarity, duty cycle and period to debugfs

 Documentation/pwm.txt                |  27 +++-
 arch/arm/mach-s3c24xx/mach-rx1950.c  |  17 +-
 drivers/clk/clk-pwm.c                |  36 ++++-
 drivers/gpu/drm/i915/intel_panel.c   |  39 +++--
 drivers/hwmon/pwm-fan.c              |  88 ++++++----
 drivers/input/misc/max77693-haptic.c |  28 +++-
 drivers/input/misc/max8997_haptic.c  |  23 ++-
 drivers/input/misc/pwm-beeper.c      |  46 ++++--
 drivers/leds/leds-pwm.c              |  15 +-
 drivers/pwm/core.c                   | 186 ++++++++++-----------
 drivers/pwm/pwm-clps711x.c           |   2 +-
 drivers/pwm/pwm-crc.c                |   2 +-
 drivers/pwm/pwm-lpc18xx-sct.c        |   9 +-
 drivers/pwm/pwm-lpc32xx.c            |   9 +-
 drivers/pwm/pwm-omap-dmtimer.c       |   2 +-
 drivers/pwm/pwm-pxa.c                |   2 +-
 drivers/pwm/pwm-rcar.c               |   2 +-
 drivers/pwm/pwm-rockchip.c           | 156 +++++++++++++++---
 drivers/pwm/pwm-spear.c              |   9 +-
 drivers/pwm/pwm-sti.c                |  67 +++++++-
 drivers/pwm/pwm-sun4i.c              |  73 ++++++---
 drivers/pwm/sysfs.c                  |  98 ++++++++---
 drivers/regulator/pwm-regulator.c    | 151 ++++++++++++++---
 drivers/video/backlight/lm3630a_bl.c |  15 +-
 drivers/video/backlight/lp855x_bl.c  |  15 +-
 drivers/video/backlight/lp8788_bl.c  |  17 +-
 drivers/video/backlight/pwm_bl.c     |  51 +++---
 drivers/video/fbdev/ssd1307fb.c      |  28 +++-
 include/linux/pwm.h                  | 303 ++++++++++++++++++++++++++-----=
----
 29 files changed, 1096 insertions(+), 420 deletions(-)

--=20
2.5.0

