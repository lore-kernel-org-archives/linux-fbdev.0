From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 31 Aug 2016 08:18:11 +0000
Subject: [PATCH 0/6] Introduce NextThing GR8 support
Message-Id: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org, Alexander Kaplan <alex@nextthing.co>, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi,

This serie introduces the support for the NextThing GR8.

This SoC is loosely based on the SoCs of the Allwinner sun5i family,
hence we can use most of the support already there. Compared to the
already existing A10s and A13/R8, the pin layout completely changed,
meaning that also the set of available controllers is changed.

There's some new controllers (SPDIF) and some are gone
(Ethernet). This also introduces the support for the GR8 Evaluation
Board.

Even though it's not been tested yet, the SPDIF and I2S-related
components have been listed but we do not create a card from them, so
they won't be usable.

Let me know if you have any questions,
Maxime

Maxime Ripard (3):
  backlight: pwm_bl: Handle gpio that can sleep
  drm/panel: simple: Add A10 EVB 5 inch panel support
  ARM: sunxi: Support the Nextthing GR8

Myl=C3=A8ne Josserand (3):
  pinctrl: sunxi: Add GR8 controller support
  ARM: dts: Add NextThing GR8 dtsi
  ARM: dts: gr8: Add support for the GR8 evaluation board

 Documentation/devicetree/bindings/arm/sunxi.txt    |    1 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |    1 +
 MAINTAINERS                                        |    1 +
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/gr8-evb.dts                      |  378 +++++++
 arch/arm/boot/dts/gr8.dtsi                         | 1080 ++++++++++++++++=
++++
 arch/arm/mach-sunxi/sunxi.c                        |    1 +
 drivers/gpu/drm/panel/panel-simple.c               |   26 +
 drivers/pinctrl/sunxi/Kconfig                      |    4 +
 drivers/pinctrl/sunxi/Makefile                     |    1 +
 drivers/pinctrl/sunxi/pinctrl-gr8.c                |  541 ++++++++++
 drivers/video/backlight/pwm_bl.c                   |    4 +-
 12 files changed, 2038 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/gr8-evb.dts
 create mode 100644 arch/arm/boot/dts/gr8.dtsi
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-gr8.c

--=20
2.9.2

